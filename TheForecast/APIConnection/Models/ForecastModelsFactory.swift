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
    
    public func makeCityObject(json: Data) -> CityObject? {
        do {
            let result = try JSONDecoder().decode(CityObject.self, from: json)
            return result
        } catch {
            print("Error parsing a CityObject", error)
            return nil
        }
    }
    
    public func makeCityResponseObject(json: Data) -> CityListResponse? {
        do {
            let result = try JSONDecoder().decode(CityListResponse.self, from: json)
            return result
        } catch {
            print("Error parsing a CityListResponse", error)
            return nil
        }
    }
    
    public func makeFiveDaysWeatherObject(json: Data) -> FiveDaysWeatherObject? {
        do {
            let result = try JSONDecoder().decode(FiveDaysWeatherObject.self, from: json)
            return result
        } catch {
            print("Error parsing a FiveDaysWeatherObject", error)
            return nil
        }
    }
}
