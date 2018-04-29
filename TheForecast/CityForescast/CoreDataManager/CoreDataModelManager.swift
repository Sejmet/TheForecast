//
//  CoreDataModelManager.swift
//  TheForecast
//
//  Created by Maria Belen Marañon on 29/4/18.
//  Copyright © 2018 IT Crowd Challenge. All rights reserved.
//

import UIKit
import CoreData

class CoreDataModelManager: NSObject {

    /**
     Persist city selected by user.
     */
    func persistCity(cityObject: CityObject, forEntityName entityName: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        if !isPersisted(cityObject: cityObject, forEntityName: entityName) {
            checkFivePersistObject(forEntityName: entityName)
            
            let cityEntity = NSEntityDescription.entity(forEntityName: entityName, in: context)
            let newCity = NSManagedObject(entity: cityEntity!, insertInto: context)
            newCity.setValue(cityObject.id, forKey: "id")
            newCity.setValue(cityObject.name, forKey: "name")
            newCity.setValue(cityObject.country, forKey: "country")
            
            saveCoreDataContext()
        }
    }

    /**
     Check if the city is persisted in core data model to no add the same city twice.
     */
    private func isPersisted(cityObject: CityObject, forEntityName entityName: String) -> Bool {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return false
        }
        
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
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
    
    /**
     The core data limit to save cities is 5.
     So if the user select a new city that it is not in the core data model,
     delete the oldest one to add the new one.
     */
    private func checkFivePersistObject(forEntityName entityName: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
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
    
    func deleteCityFromPersistedModel(cityObject: CityObject, forEntityName entityName: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
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
            print("Fail trying to save context")
        }
    }
}
