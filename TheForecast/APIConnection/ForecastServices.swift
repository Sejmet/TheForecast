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
    private var apiHost: String = "https://api.openweathermap.org/data/2.5/"
    private var forecastFactory: ForecastModelsFactory = ForecastModelsFactory()
    
    public func cityWeatherById(cityId: Int, completion: @escaping (_ cityObject: CityWeatherObject?, _ error: Error?) -> Void) {
        let urlString: String = "\(apiHost)weather?id=\(cityId)&appid=\(openWeatherApiKey)&units=metric"
        if let url: URL = URL(string: urlString) {
            Alamofire.request(url).responseJSON { (response: DataResponse<Any>) in
                if let data = response.data {
                    let cityWeatherObject = self.forecastFactory.makeCityWeatherObject(json: data)
                    completion(cityWeatherObject, response.error)
                } else {
                    completion(nil, response.error)
                }
            }
        }
    }
    
    public func cityWeatherForNextDaysById(cityId: Int, completion: @escaping (_ fiveDaysWeatherObject: NextDaysWeatherObject?, _ error: Error?) -> Void) {
        let urlString: String = "\(apiHost)forecast?id=\(cityId)&appid=\(openWeatherApiKey)&units=metric"
        if let url: URL = URL(string: urlString) {
            Alamofire.request(url).responseJSON { (response: DataResponse<Any>) in
                if let data = response.data {
                    let fiveDaysWeatherObject = self.forecastFactory.makeNextDaysWeatherObject(json: data)
                    completion(fiveDaysWeatherObject, response.error)
                } else {
                    completion(nil, response.error)
                }
            }
        }
    }
}
