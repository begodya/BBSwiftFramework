//
//  BBServiceConfigManager.swift
//  BBSwiftFramework
//
//  Created by Bei Wang on 10/20/15.
//  Copyright © 2015 Bei. All rights reserved.
//

import UIKit

class BBServiceConfigManager: NSObject {

    var configModel: NSMutableDictionary = NSMutableDictionary()
    
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
        
        self.parseServiceConfig(BBServiceConfig().kServiceConfigName)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - --------------------功能函数--------------------
    
    private func parseServiceConfig(fileName: String) {
        
    }
    // MARK: - --------------------属性相关--------------------
    // MARK: 属性操作函数注释
    
    // MARK: - --------------------接口API--------------------
    // MARK: 分块内接口函数注释

}
