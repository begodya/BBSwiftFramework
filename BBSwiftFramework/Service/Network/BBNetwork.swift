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

    class func serverSend(serviceTag: eServiceTags, bean: BBBean) {
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
            
            let value = BBValue(json: response.result.value)
            log.info("Object from json string: \n\(value)\n\n")
        }
    }
    
}
