//
//  CityDetailViewModel.swift
//  TheForecast
//
//  Created by Maria Belen Marañon on 28/4/18.
//  Copyright © 2018 IT Crowd Challenge. All rights reserved.
//

import UIKit

class CityDetailViewModel: NSObject {

    var cityObject: CityWeatherObject?
    var forecastService: ForecastServices = ForecastServices()
    
    func cityWeatherById(cityId: String, completion: @escaping (_ error: Error?) -> Void) {
        forecastService.cityWeatherById(cityId: cityId) { (cityWeatherObject: CityWeatherObject?, error: Error?) in
            if error == nil {
                self.cityObject = cityWeatherObject
            } else {
                print(error!)
            }
            
            completion(error)
        }
    }
    
    
}
