//
//  BBServiceConfigManager.swift
//  BBSwiftFramework
//
//  Created by Bei Wang on 10/20/15.
//  Copyright © 2015 BooYah. All rights reserved.
//

import UIKit

class BBAPIModel: BBObject {
    var url: String = ""
    var method: String = ""
    var output: String = ""
}

class BBServiceConfigModel: BBObject {
    var bean: String = ""
    var host: String = ""
    var apis: NSDictionary = NSDictionary()
}


class BBServiceConfigManager: NSObject {

    var configDict: NSMutableDictionary = NSMutableDictionary()
    
    // MARK: - --------------------System--------------------

    // MARK: Singleton
    class var sharedInstance : BBServiceConfigManager {
        struct Static {
            static let instance : BBServiceConfigManager = BBServiceConfigManager()
        }
        return Static.instance
    }
    
    // MARK: Init
    override init () {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - --------------------功能函数--------------------
    
    class func parseConfigPlist() {
        
        let plistPath: String = NSBundle.mainBundle().pathForResource(BBServiceConfig().kServiceConfigName, ofType: "plist")!
        let sourcesMap: NSDictionary = NSDictionary.init(contentsOfFile: plistPath)!
        
        for (key, value) in sourcesMap {
            let serviceMap: NSDictionary = value as! NSDictionary

            // bean & host
            let configModel: BBServiceConfigModel = BBServiceConfigModel()
            configModel.bean = serviceMap.objectForKey(BBServiceConfig().kService_bean) as! String
            configModel.host = serviceMap.objectForKey(BBServiceConfig().kService_host) as! String

            // api
            let tempAPIMap: NSMutableDictionary = NSMutableDictionary()
            let apiMap: NSDictionary = serviceMap.objectForKey(BBServiceConfig().kService_api) as! NSDictionary
            for (apiKey, apiValue) in apiMap {
                let apiModel: BBAPIModel = BBAPIModel()
                apiModel.url = apiValue.objectForKey(BBServiceConfig().kService_API_url) as! String
                apiModel.method = apiValue.objectForKey(BBServiceConfig().kService_API_method) as! String
                apiModel.output = apiValue.objectForKey(BBServiceConfig().kService_API_output) as! String
                
                tempAPIMap.setValue(apiModel, forKey: apiKey as! String)
            }
            
            configModel.apis = tempAPIMap
            self.sharedInstance.configDict.setValue(configModel, forKey: key as! String)
        }
    }
    // MARK: - --------------------属性相关--------------------
    // MARK: 属性操作函数注释
    
    // MARK: - --------------------接口API--------------------

    /**
    获取对应的服务类
    
    - parameter serviceTag: 服务标志
    
    - returns: 返回对应服务类
    */
    class func getApiModelByTag(serviceTag: eServiceTags) -> BBAPIModel {

        BBServiceConfigManager.parseConfigPlist()

        let keyArray: NSArray = serviceTag.rawValue.componentsSeparatedByString("_")
        let keyService: String = keyArray.firstObject as! String
        let keyApi: String = keyArray.lastObject as! String

        let configModel: BBServiceConfigModel = self.sharedInstance.configDict.objectForKey(keyService) as! BBServiceConfigModel
        let apiModel: BBAPIModel = configModel.apis.objectForKey(keyApi) as! BBAPIModel
        
        if !configModel.host.isEmpty {
            if apiModel.url.isEmpty {
                apiModel.url = configModel.host
            } else {
                apiModel.url = configModel.host + "/" + apiModel.url
            }
        }
        
        return apiModel
    }
}
