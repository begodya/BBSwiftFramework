//
//  BBNetwork.swift
//  BBSwiftFramework
//
//  Created by Bei Wang on 10/20/15.
//  Copyright © 2015 BooYah. All rights reserved.
//

import UIKit
import Alamofire

class BBNetwork: BBObject {
    
    var isNeedLoadingView: Bool = true
    var isNeedErrorAlert: Bool = true

    // MARK: - --------------------System--------------------
    required init() {
        super.init()
    }
    
    // MARK: - --------------------功能函数--------------------

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
        succeeded:      succeededBlock,
        failed:         failedBlock) {
            
            let serviceHandler: BBServiceHandler = BBServiceHandler()
            serviceHandler.isNeedErrorAlert = BBNetwork().isNeedErrorAlert
            serviceHandler.isNeedLoadingView = BBNetwork().isNeedLoadingView
            serviceHandler.serviceTag = serviceTag
            serviceHandler.bean = bean
            serviceHandler.apiModel = BBServiceConfigManager.getApiModelByTag(serviceTag)
            serviceHandler.serviceHandlerRequest(succeeded, failed: failed)
            
            
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
