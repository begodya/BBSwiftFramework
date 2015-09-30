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
    func deviceString() -> NSString {
        return "test"
    }

    // MARK: - 获取设备宽和高
    func deviceWidth() -> CGFloat {
        return UIScreen.mainScreen().bounds.size.width
    }
    
    func deviceHeight() -> CGFloat {
        return UIScreen.mainScreen().bounds.size.height
    }

}
