//
//  BBTableViewCell.swift
//  BBSwiftFramework
//
//  Created by Bei Wang on 10/8/15.
//  Copyright © 2015 BooYah. All rights reserved.
//

import UIKit

class BBTableViewCell: UITableViewCell {

    var separatorLength: CGFloat! = BBDevice.deviceWidth() - 15.0
    var separatorColor: UIColor! = BBColor.defaultColor()
    
    // MARK: - --------------------System--------------------
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

    // MARK: - --------------------功能函数--------------------
    // MARK: 初始化
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        let separatorView: BBRootView = BBRootView.init(frame: CGRectMake(BBDevice.deviceWidth()-separatorLength, self.bounds.size.height-0.5, separatorLength, 0.5))
        separatorView.backgroundColor = separatorColor
        self.addSubview(separatorView)
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
    
    /**
    *  从XIB获取cell对象
    *
    *  @param xibName xib名称
    */
    class func cellFromXib(xibName: String) -> BBTableViewCell {
        let array = NSBundle.mainBundle().loadNibNamed(xibName, owner: nil, options: nil)
        var cell: BBTableViewCell!
        if (array.count > 0) {
            cell = array[0] as! BBTableViewCell
        }
        if (cell == nil) {
            cell = BBTableViewCell.init(style: UITableViewCellStyle.Default, reuseIdentifier: nil)
        }
        
        return cell;
    }
    
    
    /**
    *  从XIB获取第index个对象cell
    *
    *  @param xibName xib名称
    *  @param index 对象索引
    */
    class func cellFromXib(xibName: String, index: NSInteger) -> BBTableViewCell {
        let array = NSBundle.mainBundle().loadNibNamed(xibName, owner: nil, options: nil)
        var cell: BBTableViewCell!
        if (array.count > index) {
            cell = array[index] as! BBTableViewCell
        }
        if (cell == nil) {
            cell = BBTableViewCell.init(style: UITableViewCellStyle.Default, reuseIdentifier: nil)
        }
        
        return cell;
    }

    
    /**
    *  从XIB获取identifier对象cell
    *
    *  @param xibName xib名称
    *  @param identifier 对象标识
    */
    class func cellFromXib(xibName: String, identifier: String) -> BBTableViewCell {
        let array = NSBundle.mainBundle().loadNibNamed(xibName, owner: nil, options: nil)
        var cell: BBTableViewCell!
        for var i=0; i<array.count; ++i {
            let view = array[i]
            if ((view as? BBTableViewCell) != nil) {
                cell = view as! BBTableViewCell
            }
        }
        if (cell == nil) {
            cell = BBTableViewCell.init(style: UITableViewCellStyle.Default, reuseIdentifier: nil)
        }

        return cell
    }
    
}
