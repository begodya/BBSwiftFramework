//
//  BBHTTPExcutor.swift
//  BBSwiftFramework
//
//  Created by Bei Wang on 10/22/15.
//  Copyright © 2015 Bei. All rights reserved.
//

import UIKit

typealias HTTPCallback = (data: NSData!, response: NSURLResponse!, error: NSError!) -> Void   // HTTP回调

struct File {
    let name:   String!
    let url:    NSURL!
    
    init(name: String, url: NSURL) {
        self.name = name
        self.url = url
    }
}

class BBHTTPExcutor: NSObject, NSURLSessionDelegate {
    let boundary = "PitayaUGl0YXlh"
    
    let method: String!
    let params: Dictionary<String, AnyObject>
    let callback: HTTPCallback
    var files: Array<File>
    
    var session: NSURLSession!
    let url: String!
    var request: NSMutableURLRequest!
    var task: NSURLSessionTask!
    
    var localCerData: NSData!
    var sslValidateErrorCallBack: (() -> Void)?

    // MARK: - --------------------System--------------------
    
    init(url:       String,
        method:     String,
        params:     Dictionary<String, AnyObject> = Dictionary<String, AnyObject>(),
        files:      Array<File> = Array<File>(),
        callback:   HTTPCallback) {
            
        self.url = url
        self.request = NSMutableURLRequest(URL: NSURL(string: url)!)
        self.method = method
        self.params = params
        self.callback = callback
        self.files = files
        self.localCerData = NSData(contentsOfFile: NSBundle.mainBundle().pathForResource("BBServiceTest", ofType: "cer")!)!
            
        super.init()
            
        self.session = NSURLSession(configuration: NSURLSession.sharedSession().configuration, delegate: self, delegateQueue: NSURLSession.sharedSession().delegateQueue)
    }
    
    // MARK: - --------------------功能函数--------------------

    private func buildParams(parameters: [String: AnyObject]) -> String {
        var components: [(String, String)] = []
        for key in Array(parameters.keys).sort(<) {
            let value: AnyObject! = parameters[key]
            components += self.queryComponents(key, value)
        }
        
        return (components.map{"\($0)=\($1)"} as [String]).joinWithSeparator("&")
    }
    
    private func queryComponents(key: String, _ value: AnyObject) -> [(String, String)] {
        var components: [(String, String)] = []
        if let dictionary = value as? [String: AnyObject] {
            for (nestedKey, value) in dictionary {
                components += queryComponents("\(key)[\(nestedKey)]", value)
            }
        } else if let array = value as? [AnyObject] {
            for value in array {
                components += queryComponents("\(key)", value)
            }
        } else {
            components.appendContentsOf([(escape(key), escape("\(value)"))])
        }
        
        return components
    }
    
    private func escape(string: String) -> String {
//        let legalURLCharactersToBeEscaped: CFStringRef = ":&=;+!@#$()',*"
//        return CFURLCreateStringByAddingPercentEscapes(nil, string, nil, legalURLCharactersToBeEscaped, CFStringBuiltInEncodings.UTF8.rawValue) as String
        
        return string.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
    }
    
    func addSSLPinning(SSLValidateErrorCallBack: (()->Void)? = nil) {
        self.sslValidateErrorCallBack = SSLValidateErrorCallBack
    }

    // MARK: - --------------------代理方法--------------------

    // MARK: - NSURLSessionDelegate
    @objc func URLSession(session: NSURLSession, didReceiveChallenge challenge: NSURLAuthenticationChallenge, completionHandler: (NSURLSessionAuthChallengeDisposition, NSURLCredential?) -> Void) {
        if let localCertificateData = self.localCerData {
            if let serverTrust = challenge.protectionSpace.serverTrust,
                certificate = SecTrustGetCertificateAtIndex(serverTrust, 0),
                remoteCertificateData: NSData = SecCertificateCopyData(certificate) {
                    if localCertificateData.isEqualToData(remoteCertificateData) {
                        let credential = NSURLCredential(forTrust: serverTrust)
                        challenge.sender?.useCredential(credential, forAuthenticationChallenge: challenge)
                        completionHandler(NSURLSessionAuthChallengeDisposition.UseCredential, credential)
                    } else {
                        challenge.sender?.cancelAuthenticationChallenge(challenge)
                        completionHandler(NSURLSessionAuthChallengeDisposition.CancelAuthenticationChallenge, nil)
                        self.sslValidateErrorCallBack?()
                    }
            } else {
                debugPrint("Get RemoteCertificateData or LocalCertificateData error!")
            }
        } else {
            completionHandler(NSURLSessionAuthChallengeDisposition.UseCredential, nil)
        }
    }
    
    // MARK: - --------------------属性相关--------------------

    private func fireTask() {
        self.addSSLPinning() { () -> Void in
            debugPrint("SSL证书错误，遭受中间人攻击！")
        }
        
        task = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
            if let _ = error {
                NSLog(error!.description)
            } else {
                debugPrint("服务发送HTTP请求或是发送HTTPS请求验证证书正确！")
            }
            self.callback(data: data, response: response, error: error)
        })
        task.resume()
    }
    
    private func configHTTPHeader() {
        if self.method == BBServiceConfig().kHTTP_GET && !self.params.isEmpty {
            self.request = NSMutableURLRequest(URL: NSURL(string: url + "?" + buildParams(self.params))!)
        }
        
        request.HTTPMethod = self.method
        
        if !self.files.isEmpty {
            request.addValue("multipart/form-data; boundary=" + self.boundary, forHTTPHeaderField: "Content-Type")
        } else if !self.params.isEmpty {
            request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        }
    }
    
    private func configHTTPBody() {
        let data = NSMutableData()
        
        if !self.files.isEmpty {
            if self.method == BBServiceConfig().kHTTP_GET {
                log.info("The remote server may not accept GET method with HTTP body. But Pitaya will send it anyway.")
            }
            
            for (key, value) in self.params {
                data.appendData("--\(self.boundary)\r\n".encodingdata)
                data.appendData("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".encodingdata)
                data.appendData("\(value.description)\r\n".encodingdata)
            }
            
            for file in self.files {
                data.appendData("--\(self.boundary)\r\n".encodingdata)
                data.appendData("Content-Disposition: form-data; name=\"\(file.name)\"; filename=\"\(NSString(string: file.url.description).lastPathComponent)\"\r\n\r\n".encodingdata)
                if let a = NSData(contentsOfURL: file.url) {
                    data.appendData(a)
                    data.appendData("\r\n".encodingdata)
                }
            }
            data.appendData("--\(self.boundary)--\r\n".encodingdata)
            
        } else if !self.params.isEmpty && self.method != BBServiceConfig().kHTTP_GET {
            data.appendData(buildParams(self.params).encodingdata)
            
        }
        request.HTTPBody = data
    }
    
    // MARK: - --------------------接口API--------------------
    // MARK: 分块内接口函数注释

    func fire() {
        configHTTPHeader()
        configHTTPBody()
        fireTask()
    }
}
