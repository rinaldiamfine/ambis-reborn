//
//  InventoryModel.swift
//  ambis-reborn
//
//  Created by Rinaldi LNU on 10/07/21.
//

import Foundation
import CoreData

struct InventoryModel {
    let inventory: Inventory
    
    var id: NSManagedObjectID {
        return inventory.objectID
    }
    
    var name: String {
        return inventory.name ?? ""
    }
}
