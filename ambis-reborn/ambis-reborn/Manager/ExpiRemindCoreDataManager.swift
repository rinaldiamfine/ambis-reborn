//
//  ExpiRemindCoreDataManager.swift
//  ExpiRemind
//
//  Created by Rinaldi LNU on 23/02/22.
//

import Foundation
import CoreData

class ExpiRemindCoreDataManager {
    let persisntentContainer: NSPersistentContainer
    static let shared = ExpiRemindCoreDataManager()
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
}
