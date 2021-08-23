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
    let container: NSPersistentCloudKitContainer = {
        //data model
        let container = NSPersistentCloudKitContainer(name: "CoreData")
        container.loadPersistentStores { storeDescription, error in
            if let err = error as NSError? {
                print("Error \(err.userInfo)")
            }
        }
        return container
    }()
    
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
