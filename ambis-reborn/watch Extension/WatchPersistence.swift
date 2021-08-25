//
//  WatchPersistence.swift
//  watch Extension
//
//  Created by Rinaldi LNU on 20/08/21.
//

import Foundation
import CoreData
import SwiftUI
import WatchKit
import WatchConnectivity

//class HostingController : WKHostingController<AnyView> {
//    override var body: AnyView {
//        return AnyView(ContentView().environmentObject(Inventory()))
//    }
//}

struct WatchPersistenceController {
    static let shared = PersistenceController()
    let container: NSPersistentContainer = {
        //data model
        let container = NSPersistentContainer(name: "CoreData")
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

class WatchManager: NSObject {
    var watchSession: WCSession?
    static let shared: WatchManager = WatchManager()
    
    override init() {
        super.init()
        watchSession = WCSession.default
        watchSession?.delegate = self
        watchSession?.activate()
    }
}

extension WatchManager: WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("Session did complete")
    }
    
    func saveData(context: [String: Any]) {
//        let status = false
//        var get = InventoryViewModel().loadList()
//        
//        let container: NSPersistentContainer = {
//            let container = NSPersistentContainer(name: "CoreData")
//            container.loadPersistentStores { storeDescription, error in
//                if let err = error as NSError? {
//                    print("Error \(err.userInfo)")
//                }
//            }
//            return container
//        }()
        
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd hh:mm:ss"
        let formatDate = dateFormater.date(from: context["expiredDate"] as! String)
        let formatTotal = Double(context["total"] as! String)
        let formatInventoryId = context["inventoryId"] as! String
        
        
//        let InventData = PersistenceController.shared.getInventoryData()
        
        let inventory = Inventory(context: PersistenceController.shared.container.viewContext)
        inventory.inventoryId = UUID(uuidString: formatInventoryId)
        inventory.watchIcon = context["categoryIcon"] as? String
        inventory.name = context["name"] as? String
        inventory.total = formatTotal ?? Double(0)
        inventory.totalType = context["totalType"] as? String
        inventory.expiryDate = formatDate
        inventory.store = context["store"] as? String
        PersistenceController.shared.saveData()
        print("FINISH CREATED")
    }
    
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        let context = applicationContext
        if context["action"] as! String == "create" {
            print("CREATE RECORD")
            saveData(context: context)
        } else if context["action"] as! String == "edit" {
            print("EDIT RECORD")
        } else {
            print("REMOVE RECORD")
        }
        
    }
}
