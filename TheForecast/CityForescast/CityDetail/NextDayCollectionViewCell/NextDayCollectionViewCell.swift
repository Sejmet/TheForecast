//
//  NextDayCollectionViewCell.swift
//  TheForecast
//
//  Created by Maria Belen Marañon on 29/4/18.
//  Copyright © 2018 IT Crowd Challenge. All rights reserved.
//

import UIKit

class NextDayCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var minimumTemperatureLabel: UILabel!
    @IBOutlet weak var maximumTemperatureLabel: UILabel!
    
    func setupCellWith(weatherInformation: WeatherObject, temperatureInformation: MainObject) {
        if let minTemperature = temperatureInformation.temp_min {
            minimumTemperatureLabel.text = "Min.:\(minTemperature)°C"
        }
        
        if let maxTemperature = temperatureInformation.temp_max {
            maximumTemperatureLabel.text = "Max.:\(maxTemperature)°C"
        }
    }
}
