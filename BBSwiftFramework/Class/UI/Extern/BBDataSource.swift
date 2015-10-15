//
//  BBDataSource.swift
//  BBSwiftFramework
//
//  Created by Bei Wang on 10/15/15.
//  Copyright © 2015 Bei. All rights reserved.
//

import UIKit

class BBDataSource: NSObject {

    var version:    String!
    var platform:   String!
    var deviceToken: String!

    // MARK: - --------------------System--------------------

    // MARK: Singleton
    class var sharedInstance : BBDataSource {
        struct Manager {
            static let instance : BBDataSource = BBDataSource()
        }
        return Manager.instance
    }

    class func initDataSource() {
        self.sharedInstance.version = BBDevice.appVersion()
        self.sharedInstance.platform = BBDevice.deviceName()
    }
    
    // MARK: - --------------------功能函数--------------------
    // MARK: 初始化
    
    // MARK: - --------------------手势事件--------------------
    // MARK: 各种手势处理函数注释
    
    // MARK: - --------------------按钮事件--------------------
    // MARK: 按钮点击函数注释
    
    // MARK: - --------------------代理方法--------------------
    // MARK: - 代理种类注释
    // MARK: 代理函数注释
    
    // MARK: - --------------------属性相关--------------------
    // MARK: 属性操作函数注释
    
    // MARK: - --------------------接口API--------------------
    // MARK: 分块内接口函数注释
    
    class func setDeviceToken(deviceToken: String) {
        self.sharedInstance.deviceToken = deviceToken
    }
    
    class func getDeviceToken() -> String {
        return self.sharedInstance.deviceToken
    }
}
