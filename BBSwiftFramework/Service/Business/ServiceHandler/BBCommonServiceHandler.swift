//
//  BBCommonServiceHandler.swift
//  BBSwiftFramework
//
//  Created by Bei Wang on 10/26/15.
//  Copyright © 2015 BooYah. All rights reserved.
//

import UIKit

@objc(BBCommonServiceHandler)
class BBCommonServiceHandler: BBServiceHandler {

    override func serviceHandlerRequest(succeeded: succeededBlock, failed: failedBlock) {
        
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
        
        super.serviceHandlerRequest(succeeded, failed: failed)
    }
    
    override func serviceHandlerResponse(data: NSData, response: NSURLResponse, succeeded: succeededBlock, failed: failedBlock) {

        switch serviceTag {
        case .kCommon_http:
            
            break
        case .kCommon_https:
            
            break
        case .kCommon_weather:

            break
        }
        
        super.serviceHandlerResponse(data, response: response, succeeded: succeeded, failed: failed)
    }
}
