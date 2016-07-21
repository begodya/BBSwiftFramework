//
//  BBServiceDispatch.swift
//  BBSwiftFramework
//
//  Created by Bei Wang on 10/23/15.
//  Copyright © 2015 BooYah. All rights reserved.
//

import UIKit

class BBServiceDispatch: NSObject {

    var urlResponse: NSHTTPURLResponse!
    // MARK: - --------------------System--------------------

    override init() {
        super.init()
        
        urlResponse = NSHTTPURLResponse()
    }
    
    // MARK: - --------------------功能函数--------------------

    // MARK: Singleton
    class var sharedInstance : BBServiceDispatch {
        struct Static {
            static let instance : BBServiceDispatch = BBServiceDispatch()
        }
        return Static.instance
    }

    
    // MARK: - --------------------接口API--------------------
    
    class func serviceStart(handler: BBServiceHandler, succeeded: succeededBlock, failed: failedBlock) {
        // 通过自定义网络库发送服务
        BBHTTPExcutor(url: handler.apiModel.url, method: handler.apiModel.method, params: handler.bean.propertyDictinory()) { (data, response, error) -> Void in
            
            self.sharedInstance.urlResponse = response as! NSHTTPURLResponse
            
            let modelClass = NSClassFromString(handler.apiModel.output) as! BBModel.Type
            let responseJSONData = NSString(data: data, encoding: NSUTF8StringEncoding)! as String;
            let result = modelClass.init(json: responseJSONData)
//            let result = modelClass.init(json: NSString(data: data, encoding: NSUTF8StringEncoding)! as String)
            handler.serviceHandlerResponse(result, succeeded: succeeded, failed: failed)
            
            }.fire()
    }
    
}
