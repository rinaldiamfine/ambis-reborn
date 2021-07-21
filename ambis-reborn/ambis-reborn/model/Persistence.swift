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
    
    func getInventoryDataById(id: NSManagedObjectID) -> Inventory? {
        do {
            return try container.viewContext.existingObject(with: id) as? Inventory
        } catch {
            return nil
        }
    }
    
    func getShoppingDataById(id: NSManagedObjectID) -> Shopping? {
        do {
            return try container.viewContext.existingObject(with: id) as? Shopping
        } catch {
            return nil
        }
    }
    
    func deleteInventoryData(inventory: Inventory) {
        container.viewContext.delete(inventory)
        saveData()
    }
    
    func deleteShoppingData(shopping: Shopping) {
        container.viewContext.delete(shopping)
        saveData()
    }
    
    func editInventoryData(inventory: Inventory, model: InventoryModel) {
        let context = container.viewContext
        print(model, "MODEL LIST")
        inventory.setValue(model.name, forKey: "name")
        inventory.setValue(model.total, forKey: "total")
        inventory.setValue(model.totalType, forKey: "totalType")
        inventory.setValue(model.purchaseDate, forKey: "purchaseDate")
        inventory.setValue(model.expiryDate, forKey: "expiryDate")
        inventory.setValue(model.foodCategory, forKey: "toFoodCategory")
        do {
            try context.save()
        } catch {
            
        }
    }
    
    func editShoppingData(shopping: Shopping, model: ShoppingModel) {
        let context = container.viewContext
        shopping.setValue(model.name, forKey: "name")
        shopping.setValue(model.total, forKey: "total")
        shopping.setValue(model.totalType, forKey: "totalType")
        shopping.setValue(model.foodCategory, forKey: "toFoodCategory")
        do {
            try context.save()
        } catch {
            
        }
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
    
    func getShoppingData() -> [Shopping] {
        let request: NSFetchRequest<Shopping> = Shopping.fetchRequest()
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
