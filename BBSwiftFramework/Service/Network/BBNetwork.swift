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
        
        BBLoadingView.setGif("Loading.gif")
        BBLoadingView.showWithOverlay()
        let apiModel: BBAPIModel = BBServiceConfigManager.getApiModelByTag(serviceTag)
            
        // 通过自定义网络库发送服务
        BBHTTPExcutor(url: apiModel.url, method: apiModel.method, params: params) { (data, response, error) -> Void in

            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                BBLoadingView.dismiss()
            })
            
            if (response.isKindOfClass(NSHTTPURLResponse)) {
                let response: NSHTTPURLResponse = response as! NSHTTPURLResponse
                if (response.statusCode == 200 && error == nil) {

                    let value = BBResult(json: NSString(data: data!, encoding: NSASCIIStringEncoding)! as String)
                    succeededBlock(response: value)
                } else {
                    failedBlock(error: error)
                }
            }
            
        }.fire()
            
            
        // 通过Alamofire发送服务
//        Alamofire.request(.GET, apiModel.url, parameters: params)
//            .responseString { response in
//                BBLoadingView.dismiss()
//
//                if (response.result.isSuccess) {
//                    let value = BBValue(json: response.result.value)
//                    succeededBlock(response: value)
//                } else {
//                    failedBlock(error: response.result.error!)
//                }
//        }

    }
    
}
