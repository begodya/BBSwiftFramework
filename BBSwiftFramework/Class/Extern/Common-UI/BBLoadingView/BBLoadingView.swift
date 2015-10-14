//
//  BBLoadingView.swift
//  BBSwiftFramework
//
//  Created by Bei Wang on 10/14/15.
//  Copyright © 2015 Bei. All rights reserved.
//

import UIKit

class BBLoadingView: BBRootView {
    
    // MARK: Constants
    
    let Size            : CGFloat           = 150
    let FadeDuration    : NSTimeInterval    = 0.3
    let GifSpeed        : CGFloat           = 0.3
    let OverlayAlpha    : CGFloat           = 0.3
    let Window          : UIWindow = (UIApplication.sharedApplication().delegate as! AppDelegate).window!
    
    
    // MARK: Variables
    
    var overlayView     : UIView?
    var imageView       : UIImageView?
    var shown           : Bool
    private var tapGesture: UITapGestureRecognizer?
    private var didTapClosure: (() -> Void)?
    private var swipeGesture: UISwipeGestureRecognizer?
    private var didSwipeClosure: (() -> Void)?
    
    // MARK: Singleton
    
    class var instance : BBLoadingView {
        struct Static {
            static let inst : BBLoadingView = BBLoadingView ()
        }
        return Static.inst
    }
    
    
    // MARK: Init
    
    init () {
        self.shown = false
        super.init(frame: CGRect (x: 0, y: 0, width: Size, height: Size))
        
        alpha = 0
        center = Window.center
        clipsToBounds = false
        layer.backgroundColor = UIColor (white: 0, alpha: 0.5).CGColor
        layer.cornerRadius = 10
        layer.masksToBounds = true
        
        imageView = UIImageView (frame: CGRectInset(bounds, 20, 20))
        addSubview(imageView!)
        
        Window.addSubview(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: HUD
    
    class func showWithOverlay () {
        dismiss ({
            self.instance.Window.addSubview(self.instance.overlay())
            self.show()
        })
    }
    
    class func show () {
        dismiss({
            
            if let anim = self.instance.imageView?.animationImages {
                self.instance.imageView?.startAnimating()
            } else {
                self.instance.imageView?.startAnimatingGif()
            }
            
            self.instance.Window.bringSubviewToFront(self.instance)
            self.instance.shown = true
            self.instance.fadeIn()
        })
    }
    
    class func showForSeconds (seconds: Double) {
        show()
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(seconds * Double(NSEC_PER_SEC)))
        dispatch_after(time, dispatch_get_main_queue(), {
            BBLoadingView.dismiss()
        })
    }
    
    class func dismissOnTap (didTap: (() -> Void)? = nil) {
        self.instance.tapGesture = UITapGestureRecognizer(target: self, action: "userTapped")
        self.instance.addGestureRecognizer(self.instance.tapGesture!)
        self.instance.didTapClosure = didTap
    }
    
    @objc private class func userTapped () {
        BBLoadingView.dismiss()
        self.instance.tapGesture = nil
        self.instance.didTapClosure?()
        self.instance.didTapClosure = nil
    }
    
    class func dismissOnSwipe (didTap: (() -> Void)? = nil) {
        self.instance.swipeGesture = UISwipeGestureRecognizer(target: self, action: "userSwiped")
        self.instance.addGestureRecognizer(self.instance.swipeGesture!)
    }
    
    @objc private class func userSwiped () {
        BBLoadingView.dismiss()
        self.instance.swipeGesture = nil
        self.instance.didSwipeClosure?()
        self.instance.didSwipeClosure = nil
    }
    
    class func dismiss () {
        if (!self.instance.shown) {
            return
        }
        
        self.instance.overlay().removeFromSuperview()
        self.instance.fadeOut()
        
        if let anim = self.instance.imageView?.animationImages {
            self.instance.imageView?.stopAnimating()
        } else {
            self.instance.imageView?.stopAnimatingGif()
        }
    }
    
    class func dismiss (complate: ()->Void) {
        if (!self.instance.shown) {
            return complate ()
        }
        
        self.instance.fadeOut({
            self.instance.overlay().removeFromSuperview()
            complate ()
        })
        
        if let anim = self.instance.imageView?.animationImages {
            self.instance.imageView?.stopAnimating()
        } else {
            self.instance.imageView?.stopAnimatingGif()
        }
    }
    
    
    // MARK: Effects
    
    func fadeIn () {
        imageView?.startAnimatingGif()
        UIView.animateWithDuration(FadeDuration, animations: {
            self.alpha = 1
        })
    }
    
    func fadeOut () {
        UIView.animateWithDuration(FadeDuration, animations: {
            self.alpha = 0
            }, completion: { (complate) in
                self.shown = false
                self.imageView?.stopAnimatingGif()
        })
    }
    
    func fadeOut (complated: ()->Void) {
        UIView.animateWithDuration(FadeDuration, animations: {
            self.alpha = 0
            }, completion: { (complate) in
                self.shown = false
                self.imageView?.stopAnimatingGif()
                complated ()
        })
    }
    
    func overlay () -> UIView {
        if (overlayView == nil) {
            overlayView = UIView (frame: Window.frame)
            overlayView?.backgroundColor = UIColor.blackColor()
            overlayView?.alpha = 0
            
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.overlayView!.alpha = self.OverlayAlpha
            })
        }
        
        return overlayView!
    }
    
    
    // MARK: Gif
    
    class func setGif (name: String) {
        self.instance.imageView?.animationImages = nil
        self.instance.imageView?.stopAnimating()
        
        self.instance.imageView?.image = GIFImage.imageWithName(name, delegate: self.instance.imageView)
    }
    
    class func setGifBundle (bundle: NSBundle) {
        self.instance.imageView?.animationImages = nil
        self.instance.imageView?.stopAnimating()
        
        self.instance.imageView?.image = GIFImage (data: NSData(contentsOfURL: bundle.resourceURL!)!, delegate: nil)
    }
    
    class func setGifImages (images: [UIImage]) {
        self.instance.imageView?.stopAnimatingGif()
        
        self.instance.imageView?.animationImages = images
        self.instance.imageView?.animationDuration = NSTimeInterval(self.instance.GifSpeed)
    }


    // MARK: - --------------------System--------------------
    
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
    // MARK: 分块内接口函数注释

}
