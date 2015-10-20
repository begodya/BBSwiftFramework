//
//  BBRootViewController.swift
//  BBSwiftFramework
//
//  Created by Bei Wang on 9/30/15.
//  Copyright © 2015 Bei. All rights reserved.
//

import UIKit

class BBRootViewController: UIViewController, UINavigationControllerDelegate, UIGestureRecognizerDelegate {
    
    // MARK: - --------------------System--------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    
        configLeftBarButtonItem()
        
        self.navigationController?.delegate = self
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)

        self.navigationController?.delegate = nil
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - --------------------功能函数--------------------
    private func configLeftBarButtonItem() {
        if (self.navigationController != nil) {
            if (self.navigationController?.viewControllers.count > 1) {
                self.setBackBarButtonWithTarget(self, action: Selector("clickedBackBarButtonAction"))
            } else if (self.navigationController?.viewControllers.count == 1) {
                let applicationWindow: UIWindow! = (UIApplication.sharedApplication().delegate?.window)!
                var rootViewController = applicationWindow.rootViewController
                if ((rootViewController?.isKindOfClass(BBNavigationController)) != nil) {
                    let tempViewController: BBNavigationController = rootViewController as! BBNavigationController
                    rootViewController = tempViewController.topViewController
                    if (rootViewController?.presentedViewController != nil) {
                        self.setCloseBarButtonWithTarget(self, action: Selector("clickedCloseBarButtonAction"))
                    }
                }
            }
        } else {
            self.setCloseBarButtonWithTarget(self, action: Selector("clickedCloseBarButtonAction"))
        }
    }
    
    private func setLeftBarButtonItem(item: UIBarButtonItem) {
        self.navigationItem.leftBarButtonItem = item
    }
    
    private func setRightBarButtonItem(item: UIBarButtonItem) {
        self.navigationItem.rightBarButtonItem = item
    }
    
    // MARK: - --------------------手势事件--------------------
    // MARK: 各种手势处理函数注释
    
    // MARK: - --------------------按钮事件--------------------
    // MARK: 按钮点击函数注释
    
    func clickedBackBarButtonAction() {
        self.navigationController?.popViewControllerAnimated(true)
    }
            
    func clickedCloseBarButtonAction() {
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - --------------------代理方法--------------------
    
    // MARK: UINavigationControllerDelegate
    func navigationController(navigationController: UINavigationController, didShowViewController viewController: UIViewController, animated: Bool) {
        if (navigationController.respondsToSelector(Selector("interactivePopGestureRecognizer"))) {
            navigationController.interactivePopGestureRecognizer?.enabled = true
        }
    }
    
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
        
//        let titleLabel = UILabel(frame: CGRectMake(0, 0, BBDevice.deviceWidth(), kNavigationBarTitleViewMaxHeight))
//        local { () -> () in
//            titleLabel.textAlignment = NSTextAlignment.Center
//            titleLabel.font = BBFont.customFontWithSize(17)
//            titleLabel.textColor = BBColor.titleColor()
//            titleLabel.text = title as String
//            titleLabel.backgroundColor = BBColor.redColor()
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

    // MARK: 添加按钮
    func setAddBarButtonWithTarget(target: AnyObject?, action: Selector) {
        let backItem:UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "btn_add_normal"), style: UIBarButtonItemStyle.Plain, target: target, action: action)
        setRightBarButtonItem(backItem)
    }

    // MARK: 右边文字按钮
    func setRightBarButtonWithTitle(title: String, target: AnyObject?, action: Selector) {
        let rightItem:UIBarButtonItem = UIBarButtonItem(title: title, style: UIBarButtonItemStyle.Plain, target: self, action: action)
        setRightBarButtonItem(rightItem)
    }

}
