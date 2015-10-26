//
//  BBObject.swift
//  BBSwiftFramework
//
//  Created by Bei Wang on 10/19/15.
//  Copyright © 2015 BooYah. All rights reserved.
//

import UIKit
import EVReflection

public class BBObject: EVObject {

    func propertyDictinory() -> Dictionary<String, AnyObject> {
        return self.toDictionary(true) as! Dictionary<String, AnyObject>
    }
}
