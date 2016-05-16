//
//  BBHomeViewController.swift
//  BBSwiftFramework
//
//  Created by Bei Wang on 9/30/15.
//  Copyright © 2015 BooYah. All rights reserved.
//

import UIKit

class BBHomeViewController: BBRootViewController {

    @IBOutlet weak var contentTableView: BBTableView!
    var viewModel: BBHomeCellsModel?
    
    // MARK: - --------------------System--------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.setCustomTitle("BooYah")
        
//        self.setMoreBarButtonWithTarget(self, action: Selector("clickedMoreAction"))
        self.setInboxBarButtonWithTarget(self, action: #selector(BBHomeViewController.clickedInboxAction))
        
        self.setupView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.contentTableView.addPullToRefresh { [weak self] in
            let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(2 * Double(NSEC_PER_SEC)))
            dispatch_after(delayTime, dispatch_get_main_queue()) {
                self?.requestService()
            }
        }
        self.contentTableView.startRefreshing()        
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.contentTableView.removePullToRefresh(self.contentTableView.pullToRefresh!)
    }
    
    // MARK: - --------------------功能函数--------------------
    // MARK: 初始化
    
    private func setupView() {
        self.setupViewModel()
    }
    
    private func setupViewModel() {
        self.viewModel = BBHomeCellsModel()
        self.viewModel?.createTableData()
    }
    
    private func requestService() {
        let bean: BBBean = BBBean.init()
        bean.location = "上海"
        bean.output = "json"
        bean.ak = "wl82QREF9dNMEEGYu3LAGqdU"
    
        let network: BBNetwork = BBNetwork()
        network.isNeedLoadingView = false
        network.serverSend(eServiceTags.kCommon_weather, bean: bean, succeeded: { (task) -> Void in
            let model: BBResult = bean.resultModel
            self.viewModel?.dataModel = model
            log.info("response BBResult: \n\(model)\n\n")

            self.viewModel!.reloadTableData()
            self.contentTableView.reloadData()
            self.contentTableView.endRefreshing()
            }) { (task, error) -> Void in
            self.contentTableView.endRefreshing()
        }
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
        cell?.setGroupPositionForIndexPath(indexPath, tableView: tableView)
        
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
