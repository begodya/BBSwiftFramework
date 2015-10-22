//
//  BBNetwork.swift
//  BBSwiftFramework
//
//  Created by Bei Wang on 10/20/15.
//  Copyright © 2015 Bei. All rights reserved.
//

import UIKit
import Alamofire

class BBNetwork: BBObject {

    /**
    通过Alamofire发送服务接口
    
    - parameter serviceTag:     服务对象
    - parameter bean:           服务参数
    - parameter succeededBlock: 成功回调
    - parameter failedBlock:    失败回调
    - parameter error:          失败信息
    */
    class func serverSend(
        serviceTag:     eServiceTags,
        bean:           BBBean,
        succeededBlock: (response: BBModel)->Void,
        failedBlock:    (error: NSError)->Void) {
            
        // Alamofire 服务
        let params: [String: AnyObject]?
        switch serviceTag {
            case .kCommon_http:
            params = ["foo": bean.foo]
            break
            case .kCommon_https:
            params = ["foo": bean.foo]
            break
        }
        
            
        BBLoadingView.setGif("Loading.gif")
        BBLoadingView.showWithOverlay()
            
        let apiModel: BBAPIModel = BBServiceConfigManager.getApiModelByTag(serviceTag)
        Alamofire.request(.GET, apiModel.url, parameters: params)
            .responseString { response in
                BBLoadingView.dismiss()

                if (response.result.isSuccess) {
                    let value = BBValue(json: response.result.value)
                    succeededBlock(response: value)
                } else {
                    failedBlock(error: response.result.error!)
                }
        }

    }
    
    /**
     通过自定义网络请求库发送服务接口
     
     - parameter serviceTag:     服务对象
     - parameter bean:           服务参数
     - parameter callback:       回调操作
     */
    class func serverSend(serviceTag: eServiceTags, bean: BBBean, callback: (data: NSData!, response: NSURLResponse!, error: NSError!) -> Void) {
        let apiModel: BBAPIModel = BBServiceConfigManager.getApiModelByTag(serviceTag)
        let manager = BBHTTPExcutor(url: apiModel.url, method: apiModel.method, callback: callback)
        manager.fire()
    }
    
    
}
