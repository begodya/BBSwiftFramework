//
//  BBMenuButtonCell.swift
//  BBSwiftFramework
//
//  Created by Bei Wang on 10/16/15.
//  Copyright © 2015 BooYah. All rights reserved.
//

import UIKit

class BBMenuButtonCell: BBTableViewCell {

    @IBOutlet weak var menuImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.backgroundColor = BBColor.redColor()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
