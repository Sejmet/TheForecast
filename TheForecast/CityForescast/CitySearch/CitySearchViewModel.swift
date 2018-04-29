//
//  CitySearchViewModel.swift
//  TheForecast
//
//  Created by Maria Belen Marañon on 28/4/18.
//  Copyright © 2018 IT Crowd Challenge. All rights reserved.
//

import UIKit
import CoreData

class CitySearchViewModel: NSObject {

    var cityArray: [CityObject] = []
    var filteredCityArray: [CityObject] = []
    var coreDataCityArray: [CityObject] = []
    
    private var forecastFactory: ForecastModelsFactory = ForecastModelsFactory()
    
    func populateCityArray() {
        cityArray = []
        if let path = Bundle.main.path(forResource: "LittleCityList", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                
                if let cityResponse = forecastFactory.makeCityResponseObject(json: data) {
                    if let cities = cityResponse.city {
                        cityArray = cities
                    }
                }
            } catch {
                print("Error trying to find Little City List json file")
            }
        }
    }
    
    func filterCityByName(cityName: String) {
        filteredCityArray = cityArray.filter { ($0.name?.localizedCaseInsensitiveContains(cityName))! }
    }
    
    func populateCoreDataCityArray() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "City")
        request.returnsObjectsAsFaults = false
        
        self.coreDataCityArray = []
        
        do {
            let result = try context.fetch(request)
            if let resultArray = result as? [CityObject] {
                for city in resultArray {
                    self.coreDataCityArray.append(city)
                }
            }
        } catch {
            print("Failed")
        }
    }
    
    func persistCity(cityObject: CityObject) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        checkFivePersistObject()
        
        let cityEntity = NSEntityDescription.entity(forEntityName: "City", in: context)
        let newCity = NSManagedObject(entity: cityEntity!, insertInto: context)
        newCity.setValue(cityObject.id, forKey: "id")
        newCity.setValue(cityObject.name, forKey: "name")
        newCity.setValue(cityObject.country, forKey: "country")
        
        saveCoreDataContext()
    }
    
    func checkFivePersistObject() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "City")
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request)
            if let resultArray = result as? [NSManagedObject] {
                if resultArray.count == 5 {
                    context.delete(resultArray[0])
                }
            }
        } catch {
            print("Failed")
        }
        
        saveCoreDataContext()
    }
    
    func saveCoreDataContext() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
    }
}
