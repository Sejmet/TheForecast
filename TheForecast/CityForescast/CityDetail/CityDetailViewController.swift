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
    
    @IBOutlet weak var nextFiveDaysCollectionView: UICollectionView!
    @IBOutlet weak var nextFiveDaysSpinnerView: UIActivityIndicatorView!
    
    
    let detailViewModel: CityDetailViewModel = CityDetailViewModel()
    var cityObject: CityObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataFromViewModel()
        nextDaysForecast()
        setupCollectionView()
    }
    
    func dataFromViewModel() {
        loadingView.isHidden = false
        if let cityId = cityObject?.id {
            detailViewModel.cityWeatherById(cityId: cityId) { (error: Error?) in
                self.loadingView.isHidden = true
                if error == nil {
                    self.setupCityDetail()
                    self.setupMapView()
                }
            }
        }
    }
    
    func setupMapView() {
        guard let latitude = detailViewModel.latitudeCoordinate() else {
            return
        }
        
        guard let longitude = detailViewModel.longitudeCoordinate() else {
            return
        }
        
        let location = CLLocationCoordinate2DMake(latitude, longitude)
        let span = MKCoordinateSpanMake(1, 1)
        let region = MKCoordinateRegionMake(location, span)
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        cityMapView.setRegion(region, animated: true)
        cityMapView.addAnnotation(annotation)
    }
    
    func nextDaysForecast() {
        nextFiveDaysSpinnerView.isHidden = false
        if let cityId = cityObject?.id {
            detailViewModel.weatherForTheNextDays(cityId: cityId) { (error: Error?) in
                if error == nil {
                    self.nextFiveDaysCollectionView.reloadData()
                }
                self.nextFiveDaysSpinnerView.isHidden = true
            }
        }
    }
    
    func setupCollectionView() {
        nextFiveDaysCollectionView.delegate = self
        nextFiveDaysCollectionView.dataSource = self
        
        nextFiveDaysCollectionView.register(UINib(nibName: "NextDayCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "NextDayCollectionViewCell")
    }
    
    func setupCityDetail() {
        self.title = detailViewModel.cityName()
        
        if let temperature = detailViewModel.temperature() {
            temperatureLabel.text = "\(String(describing: round(temperature)))"
            celsiusTextLabel.text = "°C"
        }
        
        if let minTemperature = detailViewModel.minimumTemperature() {
            minimumTemperatureTextLabel.text = "\(NSLocalizedString("Minimum", comment: "")):"
            minimumTemperatureLabel.text = "\(String(describing: round(minTemperature))) C"
        }

        if let maxTemperature = detailViewModel.maximumTemperature() {
            maximumTemperatureTextLabel.text = "\(NSLocalizedString("Maximum", comment: "")):"
            maximumTemperatureLabel.text = "\(String(describing: round(maxTemperature))) C"
        }
        
        if let humidity = detailViewModel.humidity() {
            humidityTextLabel.text = "\(NSLocalizedString("Humidity", comment: "")):"
            humidityLabel.text = "\(String(describing: humidity))%"
        }
        
        if let pressure = detailViewModel.pressure() {
            pressureTextLabel.text = "\(NSLocalizedString("Pressure", comment: "")):"
            pressureLabel.text = "\(String(describing: pressure))mbar"
        }
        
        if let weatherType = detailViewModel.mainWeather() {
            switch weatherType {
            case .clear:
                weatherImageView.image = UIImage(named: "Sunny_Icon")
            case .cloud:
                weatherImageView.image = UIImage(named: "Cloudy_Icon")
            case .rain:
                weatherImageView.image = UIImage(named: "Rainy_Icon")
            }
        }
    }
}

extension CityDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NextDayCollectionViewCell", for: indexPath) as! NextDayCollectionViewCell
        if let dayOfTheWeather = detailViewModel.nextFiveDaysWeather?.list?[indexPath.row] {
            cell.setupCellWith(weatherInformation: dayOfTheWeather.weather, temperatureInformation: dayOfTheWeather.main, dateUnix: dayOfTheWeather.dt)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let days = detailViewModel.nextFiveDaysWeather?.list?.count {
            return days
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
}
