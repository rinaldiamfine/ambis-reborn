//
//  WatchPersistence.swift
//  watch Extension
//
//  Created by Rinaldi LNU on 20/08/21.
//

import Foundation
import CoreData
import SwiftUI

//class HostingController : WKHostingController<AnyView> {
//    override var body: AnyView {
//        return AnyView(ContentView().environmentObject(Inventory()))
//    }
//}

struct WatchPersistenceController {
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
}
