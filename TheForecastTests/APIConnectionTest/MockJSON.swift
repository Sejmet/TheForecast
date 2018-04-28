//
//  MockJSON.swift
//  TheForecastTests
//
//  Created by Maria Belen Marañon on 27/4/18.
//  Copyright © 2018 IT Crowd Challenge. All rights reserved.
//

import Foundation
import UIKit

struct MockJSON {
    
    static let weatherJSON: String = """
    {
        "coord": {
            "lon": -78.5,
            "lat": -9.12
        },
        "weather": [
            {
                "id": 801,
                "main": "Clouds",
                "description": "few clouds",
                "icon": "02n"
            }
        ],
        "base": "stations",
        "main": {
            "temp": 293.559,
            "pressure": 994.51,
            "humidity": 91,
            "temp_min": 293.559,
            "temp_max": 293.559,
            "sea_level": 1025.24,
            "grnd_level": 994.51
        },
        "wind": {
            "speed": 2.66,
            "deg": 169.503
        },
        "clouds": {
            "all": 24
        },
        "dt": 1524872462,
        "sys": {
            "message": 0.0021,
            "country": "PE",
            "sunrise": 1524827840,
            "sunset": 1524870329
        },
        "id": 6559994,
        "name": "Buenos Aires",
        "cod": 200
    }
""";

}
