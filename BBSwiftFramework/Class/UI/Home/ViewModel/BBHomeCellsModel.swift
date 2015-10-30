//
//  BBHomeCellsModel.swift
//  BBSwiftFramework
//
//  Created by Bei Wang on 10/22/15.
//  Copyright © 2015 BooYah. All rights reserved.
//

import UIKit
import Haneke

class BBHomeCellsModel: NSObject {

    var dataModel: BBResult?
    
    enum eSectionType: Int {
        case Section_0
        case Section_1
    }
    
    enum eCellType: Int {
        case Cell_0
        case Cell_1
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
            break
        case .Section_1:
            
            if self.dataModel != nil {
                let cities: [City] = self.dataModel!.results
                let city: City = cities.first!
                let weatheres: [Weather] = city.weather_data
                for _ in 0..<weatheres.count {
                    cells.addObject(eCellType.Cell_1.rawValue)
                }
            }
            break
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
            break
        case 1:
            cellType = .Cell_1
            break
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
            break
        case .Cell_1:
            identifier = "BBHomeWeatherCell"
            break
        }
        
        return identifier
    }
    
    private func getCellWithType(type: eCellType) -> BBTableViewCell {
        var cell: BBTableViewCell
        switch (type) {
        case .Cell_0:
            cell = BBTableViewCell.cellFromXib("BBHomeClothesCell") as! BBHomeClothesCell
            break
        case .Cell_1:
            cell = BBTableViewCell.cellFromXib("BBHomeWeatherCell") as! BBHomeWeatherCell
            break
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
    }
    
    func getIdentifierByCellIndex(indexPath: NSIndexPath) -> String {
        return self.getIdentifierWithType(self.getCellType(indexPath))
    }
    
    func configCell(cell: BBTableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if self.dataModel != nil {

            let cellType: eCellType = self.getCellType(indexPath)
            switch (cellType) {
            case .Cell_0:
                let customCell: BBHomeClothesCell = cell as! BBHomeClothesCell
                let cities: [City] = self.dataModel!.results
                let city: City = cities.first!
                
                let clotheses: [Clothes] = city.index
                let clothes = clotheses[indexPath.row]
                
                customCell.titleLabel.text = clothes.title
                customCell.zsLabel.text = clothes.zs
                customCell.tiptLabel.text = clothes.tipt
                customCell.desLabel.text = clothes.des
                break
            case .Cell_1:
                let customCell: BBHomeWeatherCell = cell as! BBHomeWeatherCell
                let cities: [City] = self.dataModel!.results
                let city: City = cities.first!
                
                let weatheres: [Weather] = city.weather_data
                let weather = weatheres[indexPath.row]
                
                customCell.dateLabel.text = weather.date
                customCell.weatherLabel.text = weather.weather
                customCell.windLabel.text = weather.wind
                customCell.temperatureLabel.text = weather.temperature
                customCell.dayImageView.hnk_setImageFromURL(NSURL(string: weather.dayPictureUrl)!)
                customCell.nightImageView.hnk_setImageFromURL(NSURL(string: weather.nightPictureUrl)!)
                
                break
            }
        }
    }
    
    func cellForRowAtIndexPath(indexPath: NSIndexPath) -> BBTableViewCell {
        return self.getCellWithType(self.getCellType(indexPath))
    }
    
    func heightForRowAtIndexPath(indexPath: NSIndexPath) -> CGFloat {
        return 120;
    }
    
    func heightForHeaderInSection(section: NSInteger) -> CGFloat {
        var height: CGFloat = 0.0
        if self.dataModel != nil {
            switch section {
            case eSectionType.Section_0.rawValue:
                height = 25.0
                break
            case eSectionType.Section_1.rawValue:
                height = 25.0
                break
            default:
                    break
            }
        }
        
        return height
    }
    
    func viewForHeaderInSection(section: NSInteger) -> UIView {
        let headerView: BBRootView = BBRootView()
        headerView.local { () -> () in
            headerView.backgroundColor = BBColor.defaultColor()
            let sectionLabel: UILabel = UILabel.init(frame: CGRectMake(15, self.heightForHeaderInSection(section)-25, BBDevice.deviceWidth()-15, 25.0))
            headerView.addSubview(sectionLabel)
            
            switch section {
            case eSectionType.Section_0.rawValue:
                sectionLabel.text = "穿衣指数"
                break
            case eSectionType.Section_1.rawValue:
                sectionLabel.text = "天气指数"
                break

            default:
                break
            }
        }
        
        return headerView
    }

    func reloadTableData() {
        self.sectionArray.removeAllObjects()
        createTableData()
    }
}
