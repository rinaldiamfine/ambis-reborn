//
//  InventoryViewModel.swift
//  ambis-reborn
//
//  Created by Rinaldi LNU on 10/07/21.
//

import Foundation
import UIKit
import CoreData

class InventoryViewModel: ObservableObject {
    var name: String = ""
    var total: String = ""
    var totalType: String = ""
    @Published var purchaseDate: Date = Date()
    @Published var expiryDate: Date = Date()
    
    @Published var inventory: [InventoryModel] = []
    @Published var inventoryCount: Int = 0
    
    func deleteData(_ inventory: InventoryModel) {
        let existingInventory = PersistenceController.shared.getInventoryDataById(id: inventory.id)
        if let existingInventory = existingInventory {
            PersistenceController.shared.deleteInventoryData(inventory: existingInventory)
        }
    }
    
    func getData() {
        inventory = PersistenceController.shared.getInventoryData().map(InventoryModel.init)
        inventoryCount = inventory.count
    }
    
    func saveData() {
        let inventory = Inventory(context: PersistenceController.shared.container.viewContext)
        inventory.name = name
        inventory.total = Double(total)!
        inventory.totalType = totalType
        inventory.purchaseDate = purchaseDate
        inventory.expiryDate = expiryDate
        PersistenceController.shared.saveData()
    }
    
}
