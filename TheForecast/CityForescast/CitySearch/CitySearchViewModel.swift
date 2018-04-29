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
        
    }
    
    func filterCityByName(cityName: String) {
        filteredCityArray = cityArray.filter { return ($0.name?.localizedCaseInsensitiveContains("cityName"))! }
    }
}
