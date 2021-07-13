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
    var toInventory: [FoodCategory] = []
    @Published var selectedInventory = 0
    
    @Published var purchaseDate: Date = Date()
    @Published var expiryDate: Date = Date()
    
    @Published var inventory: [InventoryModel] = []
    @Published var inventoryCount: Int = 0
    
    func prepareDataCreate() {
        name = ""
        total = ""
        totalType = ""
        expiryDate = Date()
        purchaseDate = Date()
    }
    
    func resetData() {
        name = ""
        total = ""
        totalType = ""
        expiryDate = Date()
        purchaseDate = Date()
        toInventory = []
    }
    
    func prepareDataEdit(index: Int) {
        name = inventory[index].name
        total = String(inventory[index].total)
        totalType = inventory[index].totalType
        expiryDate = inventory[index].expiryDate
        purchaseDate = inventory[index].purchaseDate
        toInventory = [inventory[index].foodCategory]
    }
    
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
    
    func editData(_ inventory: InventoryModel) {
        let existingInventory = PersistenceController.shared.getInventoryDataById(id: inventory.id)
        if let existingInventory = existingInventory {
            existingInventory.name = name
            existingInventory.total = Double(total)!
            existingInventory.totalType = totalType
            existingInventory.purchaseDate = purchaseDate
            existingInventory.expiryDate = expiryDate
            existingInventory.toFoodCategory = toInventory.first
            PersistenceController.shared.editInventoryData(inventory: existingInventory, model: inventory)
        }
    }
    
    func saveData() {
        let inventory = Inventory(context: PersistenceController.shared.container.viewContext)
        inventory.name = name
        inventory.total = Double(total)!
        inventory.totalType = totalType
        inventory.purchaseDate = purchaseDate
        inventory.expiryDate = expiryDate
        if toInventory.count > 0 {
            inventory.toFoodCategory = toInventory.first
        }
        PersistenceController.shared.saveData()
    }
}
