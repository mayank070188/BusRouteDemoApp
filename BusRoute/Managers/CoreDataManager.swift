//
//  CoreDataManager.swift
//  BusRoute
//
//  Created by Mayank Mathur on 26/02/21.
//  Copyright © 2021 Mayank Mathur. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager: NSObject {
    
    static let shared: CoreDataManager = CoreDataManager()
   
    var managedContext: NSManagedObjectContext {
        return self.persistentContainer.viewContext
    }
    
    func saveDataToCoreData(routeListModelArray: [BusRouteListModel]) {
        let entity = NSEntityDescription.entity(forEntityName: "BusRouteList", in: managedContext)!
        
            for info in routeListModelArray {
                
                let routeItem = NSManagedObject(entity: entity,
                                               insertInto: managedContext)
                
                routeItem.setValue(info.id, forKey: "id")
                routeItem.setValue(info.name, forKey: "name")
                routeItem.setValue(info.source, forKey: "source")
                routeItem.setValue(info.destination, forKey: "destination")
                routeItem.setValue(info.tripDuration, forKey: "tripDuration")
                routeItem.setValue(info.available, forKey: "available")
                routeItem.setValue(info.tripStartTime, forKey: "tripStartTime")
                routeItem.setValue(info.totalSeats, forKey: "totalSeats")
                
            }
            
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Couldn't save data in CoreData = \(error.localizedDescription)")
            }
        
    }
    
    func fetchDataFromCoreData() -> [NSManagedObject] {
        
        var routeArray:[NSManagedObject] = []
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "BusRouteList")
        
        let sortDescriptors = NSSortDescriptor(key: "tripStartTime", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptors]
        
        do {
            routeArray = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Couldn't fetch data from CoreData = \(error.localizedDescription)")
        }
        return routeArray
    }
    
    func deleteAllData() {
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "BusRouteList")
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let routes = try managedContext.fetch(fetchRequest)
            for route in routes {
                managedContext.delete(route)
            }
            try managedContext.save()
        } catch let error as NSError {
            print("Couldn't delete data from CoreData = \(error.localizedDescription)")
        }
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "BusRoute")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        
        if managedContext.hasChanges {
            do {
                try managedContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
