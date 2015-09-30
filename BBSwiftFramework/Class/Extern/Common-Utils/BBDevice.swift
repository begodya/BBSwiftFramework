//
//  BBDevice.swift
//  BBSwiftFramework
//
//  Created by Bei Wang on 9/30/15.
//  Copyright © 2015 Bei. All rights reserved.
//

import UIKit

class BBDevice: NSObject {
    
    // MARK: - 获取设备版本号
    func iOSString() -> NSString {
        return UIDevice.currentDevice().systemVersion;
    }

    // MARK: - 获取设备型号
    func deviceString() -> NSString {
        return UIDevice.currentDevice().systemName;
    }
    
    // MARK: - 获取App Version
    func appVersion() -> NSString {
        let infoDict:NSDictionary = NSBundle.mainBundle().infoDictionary!
        return infoDict.objectForKey("CFBundleShortVersionString") as! String;
    }

    // MARK: - 获取App Build
    func appBuild() -> NSString {
        let infoDict:NSDictionary = NSBundle.mainBundle().infoDictionary!
        return infoDict.objectForKey("CFBundleVersion") as! String;
    }


    // MARK: - 获取设备宽和高
    func deviceWidth() -> CGFloat {
        return UIScreen.mainScreen().bounds.size.width
    }
    
    func deviceHeight() -> CGFloat {
        return UIScreen.mainScreen().bounds.size.height
    }

}
