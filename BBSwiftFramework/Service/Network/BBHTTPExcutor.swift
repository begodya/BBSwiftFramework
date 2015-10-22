//
//  BBHTTPExcutor.swift
//  BBSwiftFramework
//
//  Created by Bei Wang on 10/22/15.
//  Copyright © 2015 Bei. All rights reserved.
//

import UIKit

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
    let callback: (data: NSData!, response: NSURLResponse!, error: NSError!) -> Void
    var files: Array<File>
    
    var session: NSURLSession!
    let url: String!
    var request: NSMutableURLRequest!
    var task: NSURLSessionTask!
    
    var localCertData: NSData!

    // MARK: - --------------------System--------------------
    
    init(url:       String,
        method:     String,
        params:     Dictionary<String, AnyObject> = Dictionary<String, AnyObject>(),
        files:      Array<File> = Array<File>(),
        callback:   (data: NSData!, response: NSURLResponse!, error: NSError!) -> Void) {
            
        self.url = url
        self.request = NSMutableURLRequest(URL: NSURL(string: url)!)
        self.method = method
        self.params = params
        self.callback = callback
        self.files = files
        
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
        let legalURLCharactersToBeEscaped: CFStringRef = ":&=;+!@#$()',*"
        return CFURLCreateStringByAddingPercentEscapes(nil, string, nil, legalURLCharactersToBeEscaped, CFStringBuiltInEncodings.UTF8.rawValue) as String
        
//        return string.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
    }

    
    // MARK: - --------------------代理方法--------------------

    // MARK: - NSURLSessionDelegate
    @objc func URLSession(session: NSURLSession, didReceiveChallenge challenge: NSURLAuthenticationChallenge, completionHandler: (NSURLSessionAuthChallengeDisposition, NSURLCredential?) -> Void) {
        if(challenge.protectionSpace.authenticationMethod == "NSURLAuthenticationMethodServerTrust"){
            challenge.sender!.useCredential(NSURLCredential(forTrust: challenge.protectionSpace.serverTrust!), forAuthenticationChallenge: challenge)
            challenge.sender!.continueWithoutCredentialForAuthenticationChallenge(challenge)
        }
    }
    
    // MARK: - --------------------属性相关--------------------

    func fireTask() {
        task = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
            self.callback(data: data, response: response, error: error)
        })
        task.resume()
    }
    
    func configHTTPHeader() {
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
    
    func configHTTPBody() {
        let data = NSMutableData()
        
        if self.files.count > 0 {
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
            
        } else if self.params.count > 0 && self.method != "GET" {
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
