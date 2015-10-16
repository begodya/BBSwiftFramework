//
//  BBMenuCellsModel.swift
//  BBSwiftFramework
//
//  Created by Bei Wang on 10/16/15.
//  Copyright © 2015 Bei. All rights reserved.
//

import UIKit

class BBMenuCellsModel: NSObject {
    
    enum eSectionType: Int {
        case Section_0
        case Section_1
        case Section_2
        case Section_3
        case Section_4
    }
    
    enum eCellType: Int {
        case Cell_0
        case Cell_1
        case Cell_2
        case Cell_3
        case Cell_4
    }
    
    var sectionArray: NSMutableArray = NSMutableArray()
    // MARK: - --------------------System--------------------
    
    // MARK: - --------------------功能函数--------------------
    // MARK: 初始化
    private func addCellsToSection(sectionType: eSectionType) -> NSDictionary {
        let dictionary: NSMutableDictionary = NSMutableDictionary()
        let cells: NSMutableArray = NSMutableArray()
        switch sectionType {
            case .Section_0:
                cells.addObject(eCellType.Cell_0.rawValue)
            case .Section_1:
                cells.addObject(eCellType.Cell_1.rawValue)
            case .Section_2:
                cells.addObject(eCellType.Cell_2.rawValue)
            case .Section_3:
                cells.addObject(eCellType.Cell_3.rawValue)
            case .Section_4:
                cells.addObject(eCellType.Cell_4.rawValue)
        }
        
        dictionary.setObject(cells, forKey: sectionType.rawValue)
        return dictionary
    }
    
    private func getCellType(indexPath: NSIndexPath) -> eCellType {
        let dictionary = self.sectionArray.objectAtIndex(indexPath.section) as! NSDictionary
        let key = dictionary.allKeys as NSArray
        let cells = dictionary.objectForKey(key.firstObject!) as! NSArray
//        let cellType = cells.objectAtIndex(indexPath.row) as! eCellType
        
        var cellType: eCellType = .Cell_0
        switch(cells.objectAtIndex(indexPath.row).unsignedIntegerValue) {
            case 0:
                cellType = eCellType.Cell_0
            case 1:
                cellType = eCellType.Cell_1
            case 2:
                cellType = eCellType.Cell_2
            case 3:
                cellType = eCellType.Cell_3
            case 4:
                cellType = eCellType.Cell_4
            default:
                break
        }
        
        return cellType
    }
    
    private func getIdentifierWithType(type: eCellType) -> String {
        var identifier: String
        switch (type) {
            case .Cell_0:
                identifier = "BBMenuButtonCell"
            case .Cell_1:
                identifier = "BBMenuButtonCell"
            case .Cell_2:
                identifier = "BBMenuButtonCell"
            case .Cell_3:
                identifier = "BBMenuButtonCell"
            case .Cell_4:
                identifier = "BBMenuButtonCell"
        }
        return identifier
    }
    
    private func getCellWithType(type: eCellType) -> BBTableViewCell {
        let cell: BBMenuButtonCell = BBTableViewCell.cellFromXib("BBMenuButtonCell") as! BBMenuButtonCell
        switch (type) {
            case .Cell_0:break
            case .Cell_1:break
            case .Cell_2:break
            case .Cell_3:break
            case .Cell_4:break
        }
    
        return cell
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
    // MARK: 分块内接口函数注释

    func createTableData() {
        self.sectionArray.addObject(self.addCellsToSection(eSectionType.Section_0))
        self.sectionArray.addObject(self.addCellsToSection(eSectionType.Section_1))
        self.sectionArray.addObject(self.addCellsToSection(eSectionType.Section_2))
        self.sectionArray.addObject(self.addCellsToSection(eSectionType.Section_3))
        self.sectionArray.addObject(self.addCellsToSection(eSectionType.Section_4))
    }
    
    func getIdentifierByCellIndex(indexPath: NSIndexPath) -> String {
        return self.getIdentifierWithType(self.getCellType(indexPath))
    }
    
    func configCell(cell: BBTableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        let customCell: BBMenuButtonCell = cell as! BBMenuButtonCell
        let cellType: eCellType = self.getCellType(indexPath)
        switch (cellType) {
            case .Cell_0:
                customCell.menuImageView.image = UIImage(named: "icon-1")
            case .Cell_1:
                customCell.menuImageView.image = UIImage(named: "icon-2")
            case .Cell_2:
                customCell.menuImageView.image = UIImage(named: "icon-3")
            case .Cell_3:
                customCell.menuImageView.image = UIImage(named: "icon-4")
            case .Cell_4:
                customCell.menuImageView.image = UIImage(named: "icon-5")
        }
    }

    func cellForRowAtIndexPath(indexPath: NSIndexPath) -> BBTableViewCell {
        return self.getCellWithType(self.getCellType(indexPath))
    }

    func heightForRowAtIndexPath(indexPath: NSIndexPath) -> CGFloat {
        return 70;
    }
}
