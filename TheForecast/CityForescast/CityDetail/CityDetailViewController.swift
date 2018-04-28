//
//  CityDetailViewController.swift
//  TheForecast
//
//  Created by Maria Belen Marañon on 28/4/18.
//  Copyright © 2018 IT Crowd Challenge. All rights reserved.
//

import UIKit
import MapKit
import Foundation

class CityDetailViewController: UIViewController {

    @IBOutlet weak var dataContainerView: UIView!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var celsiusTextLabel: UILabel!
    @IBOutlet weak var minimumTemperatureTextLabel: UILabel!
    @IBOutlet weak var minimumTemperatureLabel: UILabel!
    @IBOutlet weak var maximumTemperatureTextLabel: UILabel!
    @IBOutlet weak var maximumTemperatureLabel: UILabel!
    @IBOutlet weak var humidityTextLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var pressureTextLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var cityMapView: MKMapView!
    @IBOutlet weak var loadingView: UIView!
    
    let detailViewModel: CityDetailViewModel = CityDetailViewModel()
    var cityId: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataFromViewModel()
    }
    
    func dataFromViewModel() {
        loadingView.isHidden = false
        detailViewModel.cityWeatherById(cityId: cityId) { (error: Error?) in
            if error == nil {
                self.setupCityDetail()
            }
        }
    }
    
    func setupCityDetail() {
        self.loadingView.isHidden = false
        if let temperature = detailViewModel.temperature() {
            temperatureLabel.text = "\(String(describing: round(temperature)))"
            celsiusTextLabel.text = "°C"
        }
        
        if let minTemperature = detailViewModel.minimumTemperature() {
            minimumTemperatureTextLabel.text = "Minima:"
            minimumTemperatureLabel.text = "\(String(describing: minTemperature)) C"
        }

        if let maxTemperature = detailViewModel.maximumTemperature() {
            maximumTemperatureTextLabel.text = "Maxima:"
            maximumTemperatureLabel.text = "\(String(describing: maxTemperature)) C"
        }
        
        if let humidity = detailViewModel.humidity() {
            humidityTextLabel.text = "Humedad:"
            humidityLabel.text = "\(String(describing: humidity))%"
        }
        
        if let pressure = detailViewModel.pressure() {
            pressureTextLabel.text = "Presion:"
            pressureLabel.text = "\(String(describing: pressure))mbar"
        }
    }
}
