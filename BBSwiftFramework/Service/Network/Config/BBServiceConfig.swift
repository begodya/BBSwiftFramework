//
//  BBServiceConfig.swift
//  BBSwiftFramework
//
//  Created by Bei Wang on 10/20/15.
//  Copyright © 2015 Bei. All rights reserved.
//

import Foundation

struct BBServiceConfig {

    // MARK: - Plist Name
    let kServiceConfigName      = "BBServiceConfig"

    // MARK: - Plist Structure
    let kService_bean           = "bean"
    let kService_api            = "api"
    let kService_host           = "host"
    
    let kService_API_url        = "url"
    let kService_API_method     = "method"
    let kService_API_output     = "output"

    // MARK: - HTTP Method
    let kHTTP_GET               = "GET"
    let kHTTP_POST              = "POST"
}
