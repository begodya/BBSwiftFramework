//
//  BBHomeViewController.swift
//  BBSwiftFramework
//
//  Created by Bei Wang on 9/30/15.
//  Copyright © 2015 Bei. All rights reserved.
//

import UIKit
import Alamofire

class BBHomeViewController: BBRootViewController {

    @IBOutlet weak var contentTableView: BBTableView!
    
    var items = ["武汉","上海","北京","深圳","广州","重庆","香港","台海","天津"]
    
    // MARK: - --------------------System--------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.setCustomTitle("BB Swift")
        
        self.setMoreBarButtonWithTarget(self, action: Selector("clickedMoreAction"))
        self.setInboxBarButtonWithTarget(self, action: Selector("clickedInboxAction"))
        
        self.setupView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - --------------------功能函数--------------------
    // MARK: 初始化
    
    func setupView() {
        // config tableView
        self.contentTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        BBLoadingView.setGif("Loading.gif")
        BBLoadingView.showWithOverlay()

        
        Alamofire.request(.GET, "https://api.500px.com/v1/photos").responseJSON { response in
            BBLoadingView.dismiss()
            debugPrint(response)
            
            let nameJson: String = "{\"id\": 24, \"name\": \"Bob\"}"
            let name = Name(json: nameJson)
            log.info("Object from json string: \n\(name)\n\n")
        }
        
    }
    
    // MARK: - --------------------手势事件--------------------
    // MARK: 各种手势处理函数注释
    
    // MARK: - --------------------按钮事件--------------------
    // MARK: 按钮点击函数注释
    
    func clickedMoreAction() {
        self.navigationController?.pushViewController(BBMenuViewController(), animated: true)
        
//        self.navigationController?.presentViewController(BBMenuViewController(), animated: true, completion: nil)
    }
    
    func clickedInboxAction() {
        let alertController = BBAlertController.initWithMessage("响应右边按钮")
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    // MARK: - --------------------代理方法--------------------
    
    // MARK: UITableView Delegate
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cell = tableView .dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel!.text = self.items[indexPath.row as Int]
        return cell;
    }
    
    func tableView(tableView: UITableView!, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {
        self.items.removeAtIndex(indexPath.row as Int)
        self.contentTableView?.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Top)
        NSLog("删除\(indexPath.row)")
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        BBH5ViewController().loadURL(NSURL(string: "https://github.com/")!, fromViewController: self)
        
        log.debug("Clicked Cell: \(indexPath.row)")
    }
    
    // MARK: - --------------------属性相关--------------------
    // MARK: 属性操作函数注释
    
    // MARK: - --------------------接口API--------------------
    // MARK: 分块内接口函数注释

}
