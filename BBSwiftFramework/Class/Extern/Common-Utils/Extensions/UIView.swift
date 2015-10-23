//
//  UIView.swift
//  BBSwiftFramework
//
//  Created by Bei Wang on 10/23/15.
//  Copyright © 2015 Bei. All rights reserved.
//

import UIKit

extension UIView {
    // MARK: 局部代码分隔
    func local(closure: ()->()) {
        closure()
    }
}

