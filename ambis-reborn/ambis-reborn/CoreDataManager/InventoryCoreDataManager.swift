//
//  InventoryCoreDataManager.swift
//  ExpiRemind
//
//  Created by Rinaldi LNU on 21/02/22.
//

import Foundation
import CoreData

extension ExpiRemindCoreDataManager {
    func fetchInventory() -> [InventoryModel] {
        let request: NSFetchRequest<Inventory> = Inventory.fetchRequest()
        do {
            return try viewContext.fetch(request).map(InventoryModel.init)
        } catch {
            return []
        }
    }
    
    func getInventoryById(id: NSManagedObjectID) -> Inventory? {
        do {
            return try viewContext.existingObject(with: id) as? Inventory
        } catch {
            return nil
        }
    }
}
