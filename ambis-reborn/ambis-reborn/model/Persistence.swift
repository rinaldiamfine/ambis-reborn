//
//  Persistence.swift
//  ambis-reborn
//
//  Created by Rinaldi LNU on 10/07/21.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "CoreData")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
    
    func getInventoryData() -> [Inventory] {
        let request: NSFetchRequest<Inventory> = Inventory.fetchRequest()
        do {
            return try container.viewContext.fetch(request)
        } catch {
            return []
        }
    }
    func getCategoryData() -> [FoodCategory] {
        let request: NSFetchRequest<FoodCategory> = FoodCategory.fetchRequest()
        do {
            return try container.viewContext.fetch(request)
        } catch {
            return []
        }
    }
    
    func saveData(completion: @escaping (Error?) -> () = {_ in}) {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
                completion(nil)
            } catch {
                completion(error)
            }
        }
    }
    
    func deleteData(_ object: NSManagedObject, completion: @escaping (Error?) -> () = {_ in}) {
        let context = container.viewContext
        context.delete(object)
        saveData(completion: completion)
    }
}
