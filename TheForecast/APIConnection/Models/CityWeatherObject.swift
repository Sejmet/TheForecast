//
//  CityWeatherObject.swift
//  TheForecast
//
//  Created by Maria Belen Marañon on 27/4/18.
//  Copyright © 2018 IT Crowd Challenge. All rights reserved.
//

import Foundation
import UIKit

public struct CityWeatherObject: Decodable {
    public let id: Int?
    public let name: String?
    public let coord: CoordinateObject?
    public let weather: [WeatherObject]?
    public let main: MainObject?
}

public struct CoordinateObject: Decodable {
    public let lon: Double?
    public let lat: Double?
}

public struct WeatherObject: Decodable {
    public let id: Int?
    public let main: String?
    public let description: String?
}

public struct MainObject: Decodable {
    public let temp: Double?
    public let pressure: Double?
    public let humidity: Double?
    public let temp_min: Double?
    public let temp_max: Double?
}
