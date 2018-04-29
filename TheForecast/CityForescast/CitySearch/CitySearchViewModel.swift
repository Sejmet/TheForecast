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
    var recentCityArray: [CityObject] = []
    
    private var forecastFactory: ForecastModelsFactory = ForecastModelsFactory()
    private var coreDataManager: CoreDataModelManager = CoreDataModelManager()
    
    /**
     Read json file and populate an array with city objects.
     */
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
    
    func deleteCityFromRecentCityArray(cityIndex: Int) {
        recentCityArray.remove(at: cityIndex)
    }
    
    /**
     Read core data model and populate an array with city objects.
     */
    func populateRecentCityArray() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "City")
        request.returnsObjectsAsFaults = false
        
        self.recentCityArray = []
        
        do {
            let result = try context.fetch(request)
            if let resultArray = result as? [NSManagedObject] {
                for city in resultArray {
                    let id = city.value(forKey: "id") as? Int
                    let name = city.value(forKey: "name") as? String
                    let country = city.value(forKey: "country") as? String
                    let cityObject = CityObject(id: id, name: name, country: country, coord: nil)
                    
                    recentCityArray.append(cityObject)
                }
            }
        } catch {
            print("Fail trying to read Core Data")
        }
    }
    
    func persistCity(cityObject: CityObject) {
        coreDataManager.persistCity(cityObject: cityObject, forEntityName: "City")
    }
    
    func deleteCityFromPersistedModel(cityIndex: Int) {
        let cityObject = recentCityArray[cityIndex]
        coreDataManager.deleteCityFromPersistedModel(cityObject: cityObject, forEntityName: "City")
    }
}
