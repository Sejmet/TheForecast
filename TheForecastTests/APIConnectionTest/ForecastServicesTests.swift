//
//  ForecastServicesTests.swift
//  TheForecastTests
//
//  Created by Maria Belen Marañon on 27/4/18.
//  Copyright © 2018 IT Crowd Challenge. All rights reserved.
//

import XCTest

class ForecastServicesTests: XCTestCase {

    func testParseCityWeatherObject() {
        if let data = MockJSON.weatherJSON.data(using: String.Encoding.utf8) {
            do {
                let result = try JSONDecoder().decode(CityWeatherObject.self, from: data)
                print("Success: \(result)")
            } catch {
                XCTFail("Error parsing a CityWeatherObject \(error)")
            }
        }
    }
    
}
