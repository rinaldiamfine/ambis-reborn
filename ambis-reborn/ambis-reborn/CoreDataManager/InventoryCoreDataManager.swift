//
//  InventoryCoreDataManager.swift
//  ExpiRemind
//
//  Created by Rinaldi LNU on 21/02/22.
//

import Foundation
import CoreData

class InventoryCoreDataManager {
    let persisntentContainer: NSPersistentContainer
    static let shared = InventoryCoreDataManager()
    var viewContext: NSManagedObjectContext {
        return persisntentContainer.viewContext
    }
    private init() {
        persisntentContainer = NSPersistentContainer(name: "CoreData")
        persisntentContainer.loadPersistentStores { (_, error) in
            if let error = error {
                fatalError("Unable to initialize coredata stack \(error)")
            }
        }
    }
    func save(completion: @escaping (Error?) -> () = {_ in}) {
        do {
            try viewContext.save()
        } catch {
            viewContext.rollback()
            print(error.localizedDescription)
        }
    }
    func delete(_ object: NSManagedObject, completion: @escaping (Error?) -> () = {_ in}) {
        viewContext.delete(object)
        save(completion: completion)
    }
    func fetch() -> [InventoryModel] {
        let request: NSFetchRequest<Inventory> = Inventory.fetchRequest()
        do {
            return try viewContext.fetch(request).map(InventoryModel.init)
        } catch {
            return []
        }
    }
}
