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
        
        self.setBackBarButtonWithTarget(self, action: Selector("backBarButtonAction"))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - --------------------功能函数--------------------
    
    func setLeftBarButtonItem(item: UIBarButtonItem) {
        self.navigationItem.leftBarButtonItem = item
    }
    
    func setRightBarButtonItem(item: UIBarButtonItem) {
        self.navigationItem.rightBarButtonItem = item
    }
    
    // MARK: - --------------------手势事件--------------------
    // MARK: 各种手势处理函数注释
    
    // MARK: - --------------------按钮事件--------------------
    // MARK: 按钮点击函数注释
    
    func backBarButtonAction() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    // MARK: - --------------------代理方法--------------------
    // MARK: - 代理种类注释
    // MARK: 代理函数注释
    
    // MARK: - --------------------属性相关--------------------
    // MARK: 属性操作函数注释
    
    // MARK: - --------------------接口API--------------------
    // MARK: 局部代码分隔
    func local(closure: ()->()) {
        closure()
    }

    // MARK: 设置自定义标题
    func setCustomTitle(title: String) {
        self.title = title
        
//        let titleLabel = UILabel(frame: CGRectMake(0, 0, BBDevice().deviceWidth(), kNavigationBarTitleViewMaxHeight))
//        local { () -> () in
//            titleLabel.textAlignment = NSTextAlignment.Center
//            titleLabel.font = BBFont().customFontWithSize(17)
//            titleLabel.textColor = BBColor().titleColor()
//            titleLabel.text = title as String
//            titleLabel.backgroundColor = BBColor().redColor()
//        }
//        self.navigationItem.titleView = titleLabel
    }

    // MARK: 返回按钮
    func setBackBarButtonWithTarget(target: AnyObject?, action: Selector) {
        let backItem:UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "btn_back_arrow"), style: UIBarButtonItemStyle.Plain, target: target, action: action)
        setLeftBarButtonItem(backItem)
    }
    
    // MARK: 关闭按钮
    func setCloseBarButtonWithTarget(target: AnyObject?, action: Selector) {
        let backItem:UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "btn_close_cross"), style: UIBarButtonItemStyle.Plain, target: target, action: action)
        setLeftBarButtonItem(backItem)
    }
    
    // MARK: 更多按钮
    func setMoreBarButtonWithTarget(target: AnyObject?, action: Selector) {
        let backItem:UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "btn_more_normal"), style: UIBarButtonItemStyle.Plain, target: target, action: action)
        setLeftBarButtonItem(backItem)
    }

    // MARK: 消息按钮
    func setInboxBarButtonWithTarget(target: AnyObject?, action: Selector) {
        let backItem:UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "btn_inbox_normal"), style: UIBarButtonItemStyle.Plain, target: target, action: action)
        setRightBarButtonItem(backItem)
    }


    // MARK: 右边文字按钮
    func setRightBarButtonWithTitle(title: String, target: AnyObject?, action: Selector) {
        let rightItem:UIBarButtonItem = UIBarButtonItem(title: title, style: UIBarButtonItemStyle.Plain, target: self, action: action)
        setRightBarButtonItem(rightItem)
    }

}


