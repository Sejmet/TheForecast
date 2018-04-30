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
    @IBOutlet weak var dayLabel: UILabel!
    
    func setupCellWith(weatherInformation: [WeatherObject]?, temperatureInformation: MainObject?, dateUnix: Double?) {
        if let minTemperature = temperatureInformation?.temp_min {
            minimumTemperatureLabel.text = "Min: \(round(minTemperature))°C"
        }
        
        if let maxTemperature = temperatureInformation?.temp_max {
            maximumTemperatureLabel.text = "Max: \(round(maxTemperature))°C"
        }
        
        if let unix = dateUnix {
            let day: Date = Date(timeIntervalSince1970: unix)
            let dateFormatter: DateFormatter = DateFormatter()
            dateFormatter.dateFormat = "eee dd"
            let dateString = dateFormatter.string(from: day)
            
            dayLabel.text = dateString
        }
        
        if weatherInformation != nil {
            if let weatherType = weatherInformation![0].main {
                switch weatherType {
                case .clear:
                    weatherImageView.image = UIImage(named: "Sunny_Icon")
                case .cloud:
                    weatherImageView.image = UIImage(named: "Cloudy_Icon")
                case .rain:
                    weatherImageView.image = UIImage(named: "Rainy_Icon")
                }
            }
        }
    }
}
