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



public class Clothes: BBModel {
    var title: String = ""
    var zs: String = ""
    var tipt: String = ""
    var des: String = ""
}

public class Weather: BBModel {
    var date: String = ""
    var dayPictureUrl: String = ""
    var nightPictureUrl: String = ""
    var weather: String = ""
    var wind: String = ""
    var temperature: String = ""
}

public class City: BBModel {
    var currentCity: String = ""
    var pm25: String = ""
    var index: [Clothes] = []
    var weather_data: [Weather] = []
}

public class BBResult: BBModel {
    var error: String = ""
    var status: String = ""
    var date: String = ""
    var results: [City] = []
}
