//
//  BBHomeViewController.swift
//  BBSwiftFramework
//
//  Created by Bei Wang on 9/30/15.
//  Copyright © 2015 Bei. All rights reserved.
//

import UIKit
import SwiftyJSON

class BBHomeViewController: BBRootViewController {

    @IBOutlet weak var contentTableView: BBTableView!
    
    var items = ["武汉","上海","北京","深圳","广州","重庆","香港","台海","天津"]
    var viewModel: BBHomeCellsModel?
    // MARK: - --------------------System--------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.setCustomTitle("BB Swift")
        
        self.setMoreBarButtonWithTarget(self, action: Selector("clickedMoreAction"))
        self.setInboxBarButtonWithTarget(self, action: Selector("clickedInboxAction"))
        
        // config tableView
        self.contentTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        self.setupView()
        
        self.setupViewModel()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - --------------------功能函数--------------------
    // MARK: 初始化
    
    func setupViewModel() {
        self.viewModel = BBHomeCellsModel()
        self.viewModel?.createTableData()
    }
    
    func setupView() {
        
        let bean: BBBean = BBBean.init()
        bean.location = "上海"
        bean.output = "json"
        bean.ak = "wl82QREF9dNMEEGYu3LAGqdU"
//        bean.foo = "bar"

        // 第一种方法：调用Alamofire
        BBNetwork.serverSend(eServiceTags.kCommon_weather, bean: bean, succeeded: { (response) -> Void in
            
            let model: BBResult = response as! BBResult
            self.viewModel?.dataModel = model
            log.info("response model: \n\(model)\n\n")
            self.viewModel!.reloadTableData()
            self.contentTableView.reloadData()            

            }) { (error) -> Void in
                
        }

        // 第一种方法：调用自定义网络请求库
//        BBNetwork.serverSend(eServiceTags.kCommon_http, bean: bean) { (data, response, error) -> Void in
//            
//            let result = NSString(data: data!, encoding: NSASCIIStringEncoding)!
//            let value = BBValue(json: result as String)
//            log.info("response model: \n\(value)\n\n")
//        }
        
    }
    
    // MARK: - --------------------手势事件--------------------
    // MARK: 各种手势处理函数注释
    
    // MARK: - --------------------按钮事件--------------------
    // MARK: 按钮点击函数注释
    
    func clickedMoreAction() {
        self.navigationController?.pushViewController(BBMenuViewController(), animated: true)
    }
    
    func clickedInboxAction() {
        BBH5ViewController().loadURL(NSURL(string: "https://github.com/")!, fromViewController: self)
    }
    
    // MARK: - --------------------代理方法--------------------
    
    // MARK: UITableView Delegate

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return (self.viewModel?.sectionArray.count)!
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return (self.viewModel?.heightForHeaderInSection(section))!
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return self.viewModel?.viewForHeaderInSection(section)
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        let dictionary = self.viewModel?.sectionArray.objectAtIndex(section) as! NSDictionary
        let key = dictionary.allKeys as NSArray
        let cells = dictionary.objectForKey(key.firstObject!)
        return cells!.count;
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return (self.viewModel?.heightForRowAtIndexPath(indexPath))!
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let identifier: String! = self.viewModel?.getIdentifierByCellIndex(indexPath)
        var cell: BBTableViewCell? = tableView.dequeueReusableCellWithIdentifier(identifier) as? BBTableViewCell
        if cell == nil {
            cell = self.viewModel?.cellForRowAtIndexPath(indexPath)
        }
        self.viewModel?.configCell(cell!, forRowAtIndexPath: indexPath)
        
        return cell;
    }

    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        
        let alertController = BBAlertController.initWithMessage("点击选择第\(indexPath.section)组的第\(indexPath.row)行")
        self.presentViewController(alertController, animated: true, completion: nil)
    }

    // MARK: - --------------------属性相关--------------------
    // MARK: 属性操作函数注释
    
    // MARK: - --------------------接口API--------------------
    // MARK: 分块内接口函数注释

}
