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
    
    func deleteCityFromCoreDataCityArray(cityIndex: Int) {
        coreDataCityArray.remove(at: cityIndex)
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
            if let resultArray = result as? [NSManagedObject] {
                for city in resultArray {
                    let id = city.value(forKey: "id") as? Int
                    let name = city.value(forKey: "name") as? String
                    let country = city.value(forKey: "country") as? String
                    let cityObject = CityObject(id: id, name: name, country: country, coord: nil)
                    
                    coreDataCityArray.append(cityObject)
                }
            }
        } catch {
            print("Fail trying to read Core Data")
        }
    }
    
    func persistCity(cityObject: CityObject) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        if !isPersisted(cityObject: cityObject) {
            checkFivePersistObject()
            
            let cityEntity = NSEntityDescription.entity(forEntityName: "City", in: context)
            let newCity = NSManagedObject(entity: cityEntity!, insertInto: context)
            newCity.setValue(cityObject.id, forKey: "id")
            newCity.setValue(cityObject.name, forKey: "name")
            newCity.setValue(cityObject.country, forKey: "country")
            
            saveCoreDataContext()
        }
    }
    
    private func isPersisted(cityObject: CityObject) -> Bool {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return false
        }
        
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "City")
        request.returnsObjectsAsFaults = false

        do {
            let result = try context.fetch(request)
            if let resultArray = result as? [NSManagedObject] {
                for city in resultArray {
                    if cityObject.id == city.value(forKey: "id") as? Int {
                        return true
                    }
                }
            }
        } catch {
            print("Fail trying to read Core Data")
        }
        
        return false
    }
    
    private func checkFivePersistObject() {
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
            print("Fail trying to read Core Data")
        }
        
        saveCoreDataContext()
    }
    
    func deleteCityFromPersistedModel(cityIndex: Int) {
        let cityObject = coreDataCityArray[cityIndex]
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "City")
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request)
            if let resultArray = result as? [NSManagedObject] {
                for city in resultArray {
                    if cityObject.id == city.value(forKey: "id") as? Int {
                        context.delete(city)
                    }
                }
            }
        } catch {
            print("Fail trying to read Core Data")
        }
        
        saveCoreDataContext()
    }
    
    private func saveCoreDataContext() {
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
