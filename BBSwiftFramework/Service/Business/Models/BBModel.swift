//
//  BBModel.swift
//  BBSwiftFramework
//
//  Created by Bei Wang on 10/19/15.
//  Copyright © 2015 Bei. All rights reserved.
//

import UIKit

public class BBModel: BBObject {

}



public class Args: BBModel {
    var foo: String = ""
}

public class Headers: BBModel {
    var Accept: String = ""
    var Host: String = ""
//    var Accept-Encoding: String
//    var Accept-Language: String
//    var User-Agent: String
}

public class BBValue: BBModel {
    var args: Args?
    var headers: Headers?
    var origin: String = ""
    var url: String = ""
}
