//
//  BBServiceCallback.swift
//  BBSwiftFramework
//
//  Created by Bei Wang on 10/23/15.
//  Copyright © 2015 Bei. All rights reserved.
//

import Foundation

typealias succeededBlock = (response: BBModel!)->Void    // 成功回调
typealias failedBlock = (error: NSError!)->Void          // 失败回调
