//
//  CitySearchTableViewCell.swift
//  TheForecast
//
//  Created by Maria Belen Marañon on 28/4/18.
//  Copyright © 2018 IT Crowd Challenge. All rights reserved.
//

import UIKit

class CitySearchTableViewCell: UITableViewCell {

    @IBOutlet weak var cityNameLabel: UILabel!
    
    func setupCellWith(cityName: String?) {
        cityNameLabel.text = cityName
    }
    
}
