//
//  BBMenuViewController.swift
//  BBSwiftFramework
//
//  Created by Bei Wang on 10/15/15.
//  Copyright © 2015 BooYah. All rights reserved.
//

import UIKit

class BBMenuViewController: BBRootViewController {

    @IBOutlet weak var contentTableView: BBTableView!
    var viewModel: BBMenuCellsModel?

    // MARK: - --------------------System--------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupViewModel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - --------------------功能函数--------------------
    // MARK: 初始化
    
    func setupViewModel() {
        self.viewModel = BBMenuCellsModel()
        self.viewModel?.createTableData()
    }
    
    // MARK: - --------------------手势事件--------------------
    // MARK: 各种手势处理函数注释
    
    // MARK: - --------------------按钮事件--------------------
    // MARK: 按钮点击函数注释
    
    // MARK: - --------------------代理方法--------------------

    // MARK: - UITableView Delegate
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return (self.viewModel?.sectionArray.count)!
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
    
    // MARK: - --------------------属性相关--------------------
    // MARK: 属性操作函数注释
    
    // MARK: - --------------------接口API--------------------
    // MARK: 分块内接口函数注释

}
