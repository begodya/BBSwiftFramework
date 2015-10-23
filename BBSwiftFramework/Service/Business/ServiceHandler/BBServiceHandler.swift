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
    
    // MARK: - --------------------手势事件--------------------
    // MARK: 各种手势处理函数注释
    
    // MARK: - --------------------按钮事件--------------------
    // MARK: 按钮点击函数注释
    
    // MARK: - --------------------代理方法--------------------
    // MARK: - 代理种类注释
    // MARK: 代理函数注释
    
    // MARK: - --------------------属性相关--------------------
    // MARK: 属性操作函数注释
    
    // MARK: - --------------------接口API--------------------
    // MARK: 分块内接口函数注释

    func serviceHandlerRequest(succeeded: succeededBlock, failed: failedBlock) {

        if self.isNeedLoadingView {
            BBLoadingView.setGif("Loading.gif")
            BBLoadingView.showWithOverlay()
        }

        
        let params: Dictionary<String, AnyObject>
        switch serviceTag {
        case .kCommon_http:
            params = ["foo": bean.foo]
            break
        case .kCommon_https:
            params = ["foo": bean.foo]
            break
        case .kCommon_weather:
            params = ["location": bean.location, "output": bean.output, "ak": bean.ak]
            break
        }
        
//        BBServiceDispatch.serviceStart(self, succeeded: succeeded, failed: failed)
        
        // 通过自定义网络库发送服务
        BBHTTPExcutor(url: apiModel.url, method: apiModel.method, params: params) { (data, response, error) -> Void in
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                if self.isNeedLoadingView {
                    BBLoadingView.dismiss()
                }
                
                if (response.isKindOfClass(NSHTTPURLResponse)) {
                    let response: NSHTTPURLResponse = response as! NSHTTPURLResponse
                    if (response.statusCode == 200 && error == nil) {
                        let value = BBResult(json: NSString(data: data!, encoding: NSUTF8StringEncoding)! as String)
                        succeeded(response: value)
                    } else {
                        failed(error: error)
                    }
                }
                
            })
            
        }.fire()
    }
    
    
}
