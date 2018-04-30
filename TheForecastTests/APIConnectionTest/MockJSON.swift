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
"""
    
    static let citiesJSON: String = """
    {
        "city": [
            {
                "id": 707860,
                "name": "Hurzuf",
                "country": "UA",
                "coord": {
                "lon": 34.283333,
                "lat": 44.549999
                }
            },
            {
                "id": 519188,
                "name": "Novinki",
                "country": "RU",
                "coord": {
                "lon": 37.666668,
                "lat": 55.683334
                }
            },
            {
                "id": 1283378,
                "name": "Gorkhā",
                "country": "NP",
                "coord": {
                "lon": 84.633331,
                "lat": 28
                }
            },
            {
                "id": 1270260,
                "name": "State of Haryāna",
                "country": "IN",
                "coord": {
                "lon": 76,
                "lat": 29
                }
            }
    ]
}
"""
    
    static let nextDaysWeatherJSON: String = """
{
    "cod": "200",
    "message": 0.017,
    "cnt": 40,
    "list": [
        {
            "dt": 1525046400,
            "main": {
                "temp": 9.49,
                "temp_min": 9.24,
                "temp_max": 9.49,
                "pressure": 1026.14,
                "sea_level": 1027.83,
                "grnd_level": 1026.14,
                "humidity": 80,
                "temp_kf": 0.26
            },
            "weather": [
                {
                    "id": 500,
                    "main": "Rain",
                    "description": "light rain",
                    "icon": "10n"
                }
            ],
            "clouds": {
                "all": 0
            },
            "wind": {
                "speed": 5.57,
                "deg": 296
            },
            "rain": {
                "3h": 0.12515
            },
            "sys": {
                "pod": "n"
            },
            "dt_txt": "2018-04-30 00:00:00"
        }
    ],
    "city": {
        "id": 5108955,
        "name": "Bethpage",
        "coord": {
            "lat": 40.7443,
            "lon": -73.4821
        },
        "country": "US"
    }
}

"""

}
