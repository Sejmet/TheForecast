//
//  CityDetailViewModel.swift
//  TheForecast
//
//  Created by Maria Belen Marañon on 28/4/18.
//  Copyright © 2018 IT Crowd Challenge. All rights reserved.
//

import UIKit

class CityDetailViewModel: NSObject {

    private var cityObject: CityWeatherObject?
    private let forecastService: ForecastServices = ForecastServices()
    
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
    
    func cityId() -> Int? {
        guard let id = cityObject?.id else {
            return nil
        }
        
        return id
    }
    
    func cityName() -> String {
        guard let cityName = cityObject?.name else {
            return ""
        }
        
        return cityName
    }
    
    func longitudeCoordinate() -> Double? {
        guard let longitude = cityObject?.coord?.lon else {
            return nil
        }
        
        return longitude
    }
    
    func latitudeCoordinate() -> Double? {
        guard let latitude = cityObject?.coord?.lat else {
            return nil
        }
        
        return latitude
    }
    
    func mainWeather() -> String {
        guard let weather = cityObject?.weather else {
            return ""
        }
        
        if weather.count > 0 {
            guard let main = weather[0].main else {
                return ""
            }
            
            return main
        }
        
        return ""
    }
    
    func mainWeatherDescription() -> String {
        guard let weather = cityObject?.weather else {
            return ""
        }
        
        if weather.count > 0 {
            guard let description = weather[0].description else {
                return ""
            }
            
            return description
        }
        
        return ""
    }
    
    func temperature() -> Double? {
        guard let temp = cityObject?.main?.temp else {
            return nil
        }
        
        return temp
    }
    
    func pressure() -> Double? {
        guard let pressure = cityObject?.main?.pressure else {
            return nil
        }
        
        return pressure
    }
    
    func humidity() -> Double? {
        guard let pressure = cityObject?.main?.humidity else {
            return nil
        }
        
        return pressure
    }
    
    func minimumTemperature() -> Double? {
        guard let temp_min = cityObject?.main?.temp_min else {
            return nil
        }
        
        return temp_min
    }
    
    func maximumTemperature() -> Double? {
        guard let temp_max = cityObject?.main?.temp_max else {
            return nil
        }
        
        return temp_max
    }
}
