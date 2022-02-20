//
//  FoodCategoryCoreDataManager.swift
//  ExpiRemind
//
//  Created by Rinaldi LNU on 21/02/22.
//

import Foundation
import CoreData

class FoodCategoryCoreDataManager {
    let persisntentContainer: NSPersistentContainer
    static let shared = FoodCategoryCoreDataManager()
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
    func fetch() -> [FoodCategoryModel] {
        let request: NSFetchRequest<FoodCategory> = FoodCategory.fetchRequest()
        do {
            return try viewContext.fetch(request).map(FoodCategoryModel.init)
        } catch {
            return []
        }
    }
}
