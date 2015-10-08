//
//  BBRootViewController.swift
//  BBSwiftFramework
//
//  Created by Bei Wang on 9/30/15.
//  Copyright © 2015 Bei. All rights reserved.
//

import UIKit

class BBRootViewController: UIViewController {
    
    
    // MARK: - --------------------System--------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - --------------------功能函数--------------------
    // MARK: 局部代码分隔
    func local(closure: ()->()) {
        closure()
    }
    
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
    // MARK: 设置标题
    func setCustomTitle(title: NSString) {
        
        let titleLabel = UILabel(frame: CGRectMake(0, 0, BBDevice.deviceWidth(BBDevice())(), BBDevice.deviceHeight(BBDevice())()))
        local { () -> () in
            titleLabel.textAlignment = NSTextAlignment.Center
            titleLabel.font = BBFont.customFontWithSize(BBFont())(17)
            titleLabel.textColor = BBColor.titleColor(BBColor())()
            titleLabel.text = title as String
        }
        self.navigationItem.titleView = titleLabel
    }

}


