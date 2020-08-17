//
//  DataBaseHandler.swift
//  DataUsage
//
//  Created by Pere-Dev on 17/08/20.
//  Copyright © 2020 Perennial System. All rights reserved.
//

import Foundation
import CoreData

class DataBaseHandler: NSObject {
     static let shared = DataBaseHandler()
     private override init() {}
    
    func createManagedObject(tableName : String) -> NSManagedObject {
        
        return NSEntityDescription.insertNewObject(forEntityName: tableName, into: self.getManagedObjectContext())
    }
    
    func fetchData(tableName : String,predicate : NSPredicate?,sortDiscriptor :NSSortDescriptor? ) -> [AnyObject]? {
        
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: tableName)
        if predicate != nil {
            fetchRequest.predicate = predicate
        }
        
        if sortDiscriptor != nil{
            fetchRequest.sortDescriptors = [sortDiscriptor!]
        }
        do{
            let result = try self.getManagedObjectContext().fetch(fetchRequest)
            return result as [AnyObject]?
        }catch{
            return nil
        }
    }
    
    func deleteRecord(tableName : String,predicate : NSPredicate?) -> Bool {
        
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: tableName)
        if(predicate != nil){
            fetchRequest.predicate = predicate
        }
        do{
            let result = try self.getManagedObjectContext().fetch(fetchRequest)
            for obj in result{
                if let manageObject = obj as? NSManagedObject{
                    self.getManagedObjectContext().delete(manageObject)
                }
            }
            return true
        }catch{
            return false
        }
    }
    
    func getManagedObjectContext() -> NSManagedObjectContext {
        return self.persistentContainer.viewContext
    }
    
    // MARK:- Core Data stack
    
    @available(iOS 10.0, *)
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "DataUsage")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext () -> Bool {
        // Fallback on earlier versions
        var context = self.managedObjectContext
        if #available(iOS 10.0, *) {
            
            context = persistentContainer.viewContext
        }
        if context.hasChanges {
            do {
                try context.save()
                return true
            } catch {
                return false
            }
        }
        return false
    }
    
    lazy var applicationDocumentsDirectory: NSURL = {

        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count-1] as NSURL
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {

        let modelURL = Bundle.main.url(forResource: "DataUsage", withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {

        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.appendingPathComponent("SingleViewCoreData.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            let myOptions = [NSMigratePersistentStoresAutomaticallyOption: true,
                             NSInferMappingModelAutomaticallyOption: true]
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: myOptions)
        } catch {
            abort()
        }
        return coordinator
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext = {

        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
}
