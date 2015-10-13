//
//  BBH5WebView.swift
//  BBSwiftFramework
//
//  Created by Bei Wang on 10/13/15.
//  Copyright © 2015 Bei. All rights reserved.
//

import UIKit

class BBH5WebView: UIWebView {

    var mDelegate: UIWebViewDelegate!
    
    // MARK: - --------------------System--------------------
    
    // MARK: - --------------------功能函数--------------------
    // MARK: 初始化
    
    // MARK: - --------------------手势事件--------------------
    // MARK: 各种手势处理函数注释
    
    // MARK: - --------------------按钮事件--------------------
    // MARK: 按钮点击函数注释
    
    // MARK: - --------------------代理方法--------------------
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        if (self.mDelegate.respondsToSelector(Selector("webView: request: navigationType:"))) {
            return self.mDelegate.webView!(webView, shouldStartLoadWithRequest: request, navigationType: navigationType)
        }
        
        return true
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        if (self.mDelegate.respondsToSelector(Selector("webViewDidStartLoad:"))) {
            self.mDelegate.webViewDidFinishLoad!(webView)
        }
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        if (self.mDelegate.respondsToSelector(Selector("webViewDidFinishLoad:"))) {
            self.mDelegate.webViewDidFinishLoad!(webView)
        }
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        if (self.mDelegate.respondsToSelector(Selector("webView: didFailLoadWithError:"))) {
            self.mDelegate.webView!(webView, didFailLoadWithError: error)
        }
    }
    
    // MARK: - --------------------属性相关--------------------
    // MARK: 属性操作函数注释
    
    // MARK: - --------------------接口API--------------------
    // MARK: 分块内接口函数注释

}
