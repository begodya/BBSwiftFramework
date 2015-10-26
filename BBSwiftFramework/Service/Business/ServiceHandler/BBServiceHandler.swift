//
//  BBServiceHandler.swift
//  BBSwiftFramework
//
//  Created by Bei Wang on 10/23/15.
//  Copyright © 2015 BooYah. All rights reserved.
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
    
    // MARK: 服务请求
    func serviceHandlerRequest(succeeded: succeededBlock, failed: failedBlock) {

        if self.isNeedLoadingView {
            BBLoadingView.setGif("Loading.gif")
            BBLoadingView.showWithOverlay()
        }

        switch serviceTag {
        case .kCommon_http:
            break
        case .kCommon_https:
            break
        case .kCommon_weather:
            bean.setValue(bean.location, forKey: "location")
            bean.setValue(bean.output, forKey: "output")
            bean.setValue(bean.ak, forKey: "ak")
            break
        }
        
        // 服务分发
        BBServiceDispatch.serviceStart(self, succeeded: succeeded, failed: failed)
    }
    
    
    
    // MARK: 服务回答    
    func serviceHandlerResponse(data: NSData, response: NSURLResponse, succeeded: succeededBlock, failed: failedBlock) {
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            if self.isNeedLoadingView {
                BBLoadingView.dismiss()
            }

            if ((response as! NSHTTPURLResponse).statusCode == 200) {
                var value = BBModel()
                switch self.serviceTag {
                case .kCommon_http:
                    value = BBValue(json: NSString(data: data, encoding: NSUTF8StringEncoding)! as String)
                    break
                case .kCommon_https:
                    value = BBModel(json: NSString(data: data, encoding: NSUTF8StringEncoding)! as String)
                    break
                case .kCommon_weather:
                    value = BBResult(json: NSString(data: data, encoding: NSUTF8StringEncoding)! as String)
                    break
                }
                
                succeeded(response: value)
            } else {
                
                if (self.isNeedErrorAlert) {
                    let alertController = BBAlertController.initWithMessage("HTTP层解析有误！！")
                    BBRootViewController.getCurrentViewController().presentViewController(alertController, animated: true, completion: nil)
                }
                failed(error: NSError(domain: "HTTP", code: 100, userInfo: [NSLocalizedFailureReasonErrorKey: "HTTP statusCode != 200"]))
            }
        })
    }
    
}
