//
//  BBStartViewController.swift
//  BBSwiftFramework
//
//  Created by Bei Wang on 9/30/15.
//  Copyright © 2015 Bei. All rights reserved.
//

import UIKit

class BBStartViewController: BBRootViewController {
    
    @IBOutlet weak var contentTableView: BBTableView!
    var items = ["武汉","上海","北京","深圳","广州","重庆","香港","台海","天津"]
    
    // MARK: - --------------------System--------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.setCustomTitle("Just Start")
        
        self.contentTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
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

    // MARK: - UITableView Delegate
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int{
        return self.items.count
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!{
        
        let cell = tableView .dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        let row=indexPath.row as Int
        cell.textLabel!.text=self.items[row]
        return cell;
    }

    func tableView(tableView: UITableView!, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!){
        let index=indexPath.row as Int
        self.items.removeAtIndex(index)
        self.contentTableView?.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Top)
        NSLog("删除\(indexPath.row)")
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!){
        let alertController = UIAlertController(title: "标题", message: "你选择的是\(self.items[indexPath.row])", preferredStyle: UIAlertControllerStyle.Alert)
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: nil)
        let okAction = UIAlertAction(title: "好的", style: UIAlertActionStyle.Default, handler: nil)
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    // MARK: - --------------------属性相关--------------------
    // MARK: 属性操作函数注释
    
    // MARK: - --------------------接口API--------------------
    // MARK: 分块内接口函数注释

}
