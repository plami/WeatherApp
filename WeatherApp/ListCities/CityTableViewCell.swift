//
//  CityTableViewCell.swift
//  IOSTask
//
//  Created by macbook on 21.02.19.
//  Copyright © 2019 macbook. All rights reserved.
//

import UIKit

class CityTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(_ model: CityWeatherModel) {
        self.textLabel?.text = model.title
    }
    
}
