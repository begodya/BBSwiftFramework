//
//  BBHomeWeatherCell.swift
//  BBSwiftFramework
//
//  Created by Bei Wang on 10/23/15.
//  Copyright © 2015 BooYah. All rights reserved.
//

import UIKit

class BBHomeWeatherCell: BBTableViewCell {

    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var dayImageView: UIImageView!
    @IBOutlet weak var nightImageView: UIImageView!
    
    override func awakeFromNib() {
        
    }
}
