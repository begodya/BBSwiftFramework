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

    class func serverSend(serviceTage: eServiceTags, bean: BBBean) {
        BBLoadingView.setGif("Loading.gif")
        BBLoadingView.showWithOverlay()
        
        Alamofire.request(.GET, "http://httpbin.org/get", parameters: ["foo": bean.foo])
            .responseString { response in
                BBLoadingView.dismiss()
                
                let value = BBValue(json: response.result.value)
                log.info("Object from json string: \n\(value)\n\n")
        }
    }
    
}
