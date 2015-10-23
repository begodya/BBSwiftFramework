//
//  BBServiceHandler.swift
//  BBSwiftFramework
//
//  Created by Bei Wang on 10/23/15.
//  Copyright © 2015 Bei. All rights reserved.
//

import UIKit

class BBServiceHandler: NSObject {

    var isNeedLoadingView: Bool = true
    var isNeedErrorAlert: Bool = true
    
    var bean: BBBean = BBBean()
    var serviceTag: eServiceTags = eServiceTags.kCommon_http
    var apiModel: BBAPIModel = BBAPIModel()
    
    // MARK: - --------------------System--------------------
    override init() {
        super.init()
    }
    
    // MARK: - --------------------功能函数--------------------
    // MARK: 初始化
    
    // MARK: - --------------------属性相关--------------------
    // MARK: 属性操作函数注释
    
    // MARK: - --------------------接口API--------------------
    // MARK: 分块内接口函数注释

    func serviceHandlerRequest(succeeded: succeededBlock, failed: failedBlock) {

        if self.isNeedLoadingView {
            BBLoadingView.setGif("Loading.gif")
            BBLoadingView.showWithOverlay()
        }

        switch serviceTag {
        case .kCommon_http:
            bean.setValue(bean.foo, forKey: "foo")
            break
        case .kCommon_https:
            bean.setValue(bean.foo, forKey: "foo")
            break
        case .kCommon_weather:
            bean.setValue(bean.location, forKey: "location")
            bean.setValue(bean.output, forKey: "output")
            bean.setValue(bean.ak, forKey: "ak")
            break
        }
        
        // 服务分发
        BBServiceDispatch.serviceStart(self, succeeded: succeeded, failed: failed)
        
//        // 通过自定义网络库发送服务
//        BBHTTPExcutor(url: apiModel.url, method: apiModel.method, params: bean.propertyDictinory()) { (data, response, error) -> Void in
//            
//            dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                if self.isNeedLoadingView {
//                    BBLoadingView.dismiss()
//                }
//
//                if (response.isKindOfClass(NSHTTPURLResponse)) {
//                    let response: NSHTTPURLResponse = response as! NSHTTPURLResponse
//                    if (response.statusCode == 200 && error == nil) {
//                        let value = BBResult(json: NSString(data: data!, encoding: NSUTF8StringEncoding)! as String)
//                        succeeded(response: value)
//                    } else {
//                        failed(error: error)
//                    }
//                }
//
//            })
//
//        }.fire()
    }
    
    
    func serviceHandlerResponse(data: NSData, response: NSURLResponse, succeeded: succeededBlock, failed: failedBlock) {
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            if self.isNeedLoadingView {
                BBLoadingView.dismiss()
            }
            
            if (response.isKindOfClass(NSHTTPURLResponse)) {
                let response: NSHTTPURLResponse = response as! NSHTTPURLResponse
                if (response.statusCode == 200) {
                    let value = BBResult(json: NSString(data: data, encoding: NSUTF8StringEncoding)! as String)
                    succeeded(response: value)
                } else {
                    let userInfo = [NSLocalizedFailureReasonErrorKey: "HTTP statusCode != 200"]
                    failed(error: NSError(domain: "HTTP", code: 100, userInfo: userInfo))
                }
            }
        })
    }
    
}
