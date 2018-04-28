//
//  CityDetailViewController.swift
//  TheForecast
//
//  Created by Maria Belen Marañon on 28/4/18.
//  Copyright © 2018 IT Crowd Challenge. All rights reserved.
//

import UIKit
import MapKit

class CityDetailViewController: UIViewController {

    @IBOutlet weak var dataContainerView: UIView!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var minimumTemperatureLabel: UILabel!
    @IBOutlet weak var maximumTemperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var cityMapView: MKMapView!
    
    let detailViewModel: CityDetailViewModel = CityDetailViewModel()
    var cityId: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataFromViewModel()
    }
    
    func dataFromViewModel() {
        detailViewModel.cityWeatherById(cityId: cityId) { (error: Error?) in
            if error == nil {
                self.setupCityDetail()
            }
        }
    }
    
    func setupCityDetail() {
        
    }
}
