//
//  FiveDaysWeatherObject.swift
//  TheForecast
//
//  Created by Maria Belen Marañon on 29/4/18.
//  Copyright © 2018 IT Crowd Challenge. All rights reserved.
//

import UIKit

public struct FiveDaysWeatherObject: Decodable {
    public let city: CityObject?
    public let list: [WeatherListObject]?
}

public struct WeatherListObject: Decodable {
    public let dt: Int?
    public let main: MainObject?
    public let weather: WeatherObject?
}
