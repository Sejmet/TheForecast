//
//  CitySearchViewModel.swift
//  TheForecast
//
//  Created by Maria Belen Marañon on 28/4/18.
//  Copyright © 2018 IT Crowd Challenge. All rights reserved.
//

import UIKit

class CitySearchViewModel: NSObject {

    var cityArray: [CityObject] = []
    var filteredCityArray: [CityObject] = []
    
    func populateCityArray() {
        cityArray.append(CityObject(id: 12345, name: "Hurzuf", country: "RU", coord: nil))
        cityArray.append(CityObject(id: 122335, name: "Gohuris", country: "RU", coord: nil))
        cityArray.append(CityObject(id: 12225, name: "Gorkhā", country: "RU", coord: nil))
        cityArray.append(CityObject(id: 123555, name: "Buenos Aires", country: "AR", coord: nil))
    }
    
    func filterCityByName(cityName: String) {
        filteredCityArray = cityArray.filter { ($0.name?.localizedCaseInsensitiveContains(cityName))! }
    }
}
