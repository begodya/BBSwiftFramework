//
//  BBServiceCallback.swift
//  BBSwiftFramework
//
//  Created by Bei Wang on 10/23/15.
//  Copyright © 2015 BooYah. All rights reserved.
//

import Foundation

typealias succeededBlock = (task: NSHTTPURLResponse!) -> Void               // 成功回调
typealias failedBlock = (task: NSHTTPURLResponse!, error: NSError!) -> Void // 失败回调
