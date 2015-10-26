//
//  BBServiceHandler.swift
//  BBSwiftFramework
//
//  Created by Bei Wang on 10/23/15.
//  Copyright © 2015 BooYah. All rights reserved.
//

import UIKit

@objc(BBServiceHandler)
class BBServiceHandler: NSObject {

    var isNeedLoadingView: Bool = true
    var isNeedErrorAlert: Bool = true
    
    var bean: BBBean = BBBean()
    var serviceTag: eServiceTags = eServiceTags.kCommon_http
    var apiModel: BBAPIModel = BBAPIModel()
    
    // MARK: - --------------------System--------------------
    required override init() {
        super.init()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        
        // 服务分发
        BBServiceDispatch.serviceStart(self, succeeded: succeeded, failed: failed)
    }
    
    
    // MARK: 服务应答
    func serviceHandlerResponse(data: NSData, response: NSURLResponse, succeeded: succeededBlock, failed: failedBlock) {
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            if self.isNeedLoadingView {
                BBLoadingView.dismiss()
            }
        
            if ((response as! NSHTTPURLResponse).statusCode == 200) {
                let modelClass = NSClassFromString(self.apiModel.output) as! BBModel.Type
                let value = modelClass.init(json: NSString(data: data, encoding: NSUTF8StringEncoding)! as String)
                
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
