//
//  BBHomeCellsModel.swift
//  BBSwiftFramework
//
//  Created by Bei Wang on 10/22/15.
//  Copyright © 2015 Bei. All rights reserved.
//

import UIKit

class BBHomeCellsModel: NSObject {

    var dataModel: BBResult?
    
    enum eSectionType: Int {
        case Section_0
    }
    
    enum eCellType: Int {
        case Cell_0
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
            
            if self.dataModel != nil {
                let cities: [City] = self.dataModel!.results
                let city: City = cities.first!
                let clotheses: [Clothes] = city.index
                for _ in 0..<clotheses.count {
                    cells.addObject(eCellType.Cell_0.rawValue)
                }
            }
        }
        
        dictionary.setObject(cells, forKey: sectionType.rawValue)
        return dictionary
    }
    
    private func getCellType(indexPath: NSIndexPath) -> eCellType {
        let dictionary = self.sectionArray.objectAtIndex(indexPath.section) as! NSDictionary
        let key = dictionary.allKeys as NSArray
        let cells = dictionary.objectForKey(key.firstObject!) as! NSArray
//        let cellType = cells.objectAtIndex(indexPath.row) as! eCellType
        
        // WARNING: cellType
        var cellType: eCellType = .Cell_0
        switch(cells.objectAtIndex(indexPath.row).unsignedIntegerValue) {
        case 0:
            cellType = .Cell_0
        default:
            break
        }
        
        return cellType
    }
    
    private func getIdentifierWithType(type: eCellType) -> String {
        var identifier: String
        switch (type) {
        case .Cell_0:
            identifier = "BBHomeClothesCell"
        }
        return identifier
    }
    
    private func getCellWithType(type: eCellType) -> BBTableViewCell {
        let cell: BBHomeClothesCell = BBTableViewCell.cellFromXib("BBHomeClothesCell") as! BBHomeClothesCell
        switch (type) {
        case .Cell_0:break
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
    }
    
    func getIdentifierByCellIndex(indexPath: NSIndexPath) -> String {
        return self.getIdentifierWithType(self.getCellType(indexPath))
    }
    
    func configCell(cell: BBTableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if self.dataModel != nil {
            let customCell: BBHomeClothesCell = cell as! BBHomeClothesCell
            let cellType: eCellType = self.getCellType(indexPath)
            switch (cellType) {
            case .Cell_0:
                let cities: [City] = self.dataModel!.results
                let city: City = cities.first!
                
                let clotheses: [Clothes] = city.index
                let clothes = clotheses[indexPath.row]
                
                customCell.titleLabel.text = clothes.title
                customCell.zsLabel.text = clothes.zs
                customCell.tiptLabel.text = clothes.title
                customCell.desLabel.text = clothes.des
            }
        }
    }
    
    func cellForRowAtIndexPath(indexPath: NSIndexPath) -> BBTableViewCell {
        return self.getCellWithType(self.getCellType(indexPath))
    }
    
    func heightForRowAtIndexPath(indexPath: NSIndexPath) -> CGFloat {
        return 120;
    }

    func reloadTableData() {
        self.sectionArray.removeAllObjects()
        createTableData()
    }
}
