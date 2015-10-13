//
//  BBH5ViewController.swift
//  BBSwiftFramework
//
//  Created by Bei Wang on 10/13/15.
//  Copyright © 2015 Bei. All rights reserved.
//

import UIKit

class BBH5ViewController: BBRootViewController {

    @IBOutlet weak var h5WebView: BBH5WebView!
    
    // MARK: - --------------------System--------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - --------------------功能函数--------------------
    // MARK: 初始化
    
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
    
    /**
    *  @param url 进入页面的URL地址
    *  @param viewController 进入的vc
    */
    func loadURL(url: NSURL, fromViewController: BBRootViewController) {
        loadURL(url, title: "", fromViewController: fromViewController)
    }

    /**
    *  @param url 进入页面的URL地址
    *  @param title H5页面的标题
    *  @param viewController 进入的vc
    */
    func loadURL(url: NSURL, title: String, fromViewController: BBRootViewController) {
        self.setCustomTitle(title)
//        self.h5WebView.loadRequest(NSURLRequest(URL: url))
        fromViewController.navigationController?.pushViewController(self, animated: true)
    }
}
