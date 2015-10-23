//
//  BBServiceDispatch.swift
//  BBSwiftFramework
//
//  Created by Bei Wang on 10/23/15.
//  Copyright © 2015 Bei. All rights reserved.
//

import UIKit

class BBServiceDispatch: NSObject {

    // MARK: - --------------------System--------------------

    // MARK: Singleton
    class var sharedInstance : BBServiceDispatch {
        struct Static {
            static let instance : BBServiceDispatch = BBServiceDispatch()
        }
        return Static.instance
    }
    
    // MARK: - --------------------功能函数--------------------

    
    
    // MARK: - --------------------接口API--------------------
    
    class func serviceStart(handler: BBServiceHandler, succeeded: succeededBlock, failed: failedBlock) {
        // 通过自定义网络库发送服务
        BBHTTPExcutor(url: handler.apiModel.url, method: handler.apiModel.method, params: handler.bean.propertyDictinory()) { (data, response, error) -> Void in
            handler.serviceHandlerResponse(data, response: response, succeeded: succeeded, failed: failed)
            
            }.fire()
    }
    
}
