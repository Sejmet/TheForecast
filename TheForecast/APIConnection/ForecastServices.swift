//
//  ForecastServices.swift
//  TheForecast
//
//  Created by Maria Belen Marañon on 27/4/18.
//  Copyright © 2018 IT Crowd Challenge. All rights reserved.
//

import UIKit
import Alamofire

class ForecastServices: NSObject {

    private var openWeatherApiKey: String = "4222c0a1f7e408da4efdf0b691a662a4"
    private var apiHost: String = "api.openweathermap.org/data/2.5/weather?"
    
    public func cityWeatherById(cityId: String) {
        let urlString: String = "\(apiHost)/id=\(cityId)&appid=\(openWeatherApiKey)"
        if let url: URL = URL(string: urlString) {
            Alamofire.request(url).responseJSON { (response: DataResponse<Any>) in
                if let json = response.result.value {
                    
                }
            }
        }
    }
}
