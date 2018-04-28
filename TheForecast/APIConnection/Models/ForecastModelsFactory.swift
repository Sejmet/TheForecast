//
//  ForecastModelsFactory.swift
//  TheForecast
//
//  Created by Maria Belen Marañon on 27/4/18.
//  Copyright © 2018 IT Crowd Challenge. All rights reserved.
//

import UIKit

class ForecastModelsFactory: NSObject {

    public func makeCityWeatherObject(json: Data) -> CityWeatherObject? {
        do {
            let result = try JSONDecoder().decode(CityWeatherObject.self, from: json)
            return result
        } catch {
            print("Error parsing a CityWeatherObject", error)
            return nil
        }
    }
    
}
