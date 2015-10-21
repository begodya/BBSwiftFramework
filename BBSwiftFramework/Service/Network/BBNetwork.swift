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
    发送服务接口
    
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
        failedBlock:    (task: NSHTTPURLResponse, error: NSError)->Void) {
            
        BBLoadingView.setGif("Loading.gif")
        BBLoadingView.showWithOverlay()

        let apiModel: BBAPIModel = BBServiceConfigManager.getApiModelByTag(serviceTag)
        let parameters: [String: AnyObject]?
        
        switch serviceTag {
            case .kCommon_test:
            parameters = ["foo": bean.foo]
            break
        }
        
        Alamofire.request(.GET, apiModel.url, parameters: parameters)
            .responseString { response in
                BBLoadingView.dismiss()

                if (response.result.isSuccess) {
                    let value = BBValue(json: response.result.value)
                    succeededBlock(response: value)
                } else {
                    failedBlock(task: response.response!, error: response.result.error!)
                }
        }
    }
    
}
