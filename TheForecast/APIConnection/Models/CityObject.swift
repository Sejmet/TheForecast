//
//  CityObject.swift
//  TheForecast
//
//  Created by Maria Belen Marañon on 28/4/18.
//  Copyright © 2018 IT Crowd Challenge. All rights reserved.
//

import UIKit

public struct CityObject: Decodable {

    public let id: Int?
    public let name: String?
    public let country: String?
    public let coord: CoordinateObject?
}

public struct CityListResponse: Decodable {
    public let city: [CityObject]?
}
