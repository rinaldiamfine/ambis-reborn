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
    @Published var name: String = ""
    @Published var total: String = ""
    @Published var totalType: String = ""
    @Published var toInventory: [FoodCategory] = []
    @Published var selectedInventory = 0
    
    @Published var purchaseDate: Date = Date()
    @Published var expiryDate: Date = Date()
    
    @Published var inventory: [InventoryModel] = []
    @Published var inventoryCount: Int = 0
    @Published var foodCategories: [FoodCategoryModel] = []
    @Published var foodCategoryCount: Int = 0
    
    @Published var isPresented = false
    @Published var selectedIndex = 0
    @Published var status = ""
    
    @Published var previewSelectedCategory = "Choose Category"
    @Published var detailDisclaimer = ""
    @Published var expiryEstimation: Int = 0
    
    //EDIT
    func editData(index: InventoryModel) {
        var count = 0
        for data in inventory {
            if data.id == index.id {
                prepareDataEdit(index: count)
                break
            }
            count += 1
        }
        selectedIndex = count
        status = "edit"
        isPresented = true
    }
    func prepareDataEdit(index: Int) {
        name = inventory[index].name
        total = String(inventory[index].total)
        totalType = inventory[index].totalType
        expiryDate = inventory[index].expiryDate
        purchaseDate = inventory[index].purchaseDate
        toInventory = [inventory[index].foodCategory]
        previewSelectedCategory = (inventory[index].foodCategory.imageString! + " " + inventory[index].foodCategory.name!)
        detailDisclaimer = inventory[index].foodCategory.estimation!
    }
    //EDIT
    
    //DELETE
    func deleteItemByContextMenu(index: InventoryModel) {
        var count = 0
        for data in inventory {
            if data.id == index.id {
                let inventory = inventory[count]
                deleteData(inventory)
                break
            }
            count += 1
        }
        getData()
    }
    func deleteData(_ inventory: InventoryModel) {
        let existingInventory = PersistenceController.shared.getInventoryDataById(id: inventory.id)
        if let existingInventory = existingInventory {
            PersistenceController.shared.deleteInventoryData(inventory: existingInventory)
        }
    }
    //DELETE
    
    //CREATE
    func prepareCreateData() {
        resetData()
        isPresented.toggle()
        status = "create"
    }
    //CREATE
    
    func resetData() {
        name = ""
        total = ""
        totalType = ""
        expiryDate = Date()
        purchaseDate = Date()
        toInventory = []
        previewSelectedCategory = "Choose Category"
        detailDisclaimer = ""
    }
    
    func loadList() {
        inventory = PersistenceController.shared.getInventoryData().map(InventoryModel.init)
        inventoryCount = inventory.count
        
        foodCategories = PersistenceController.shared.getCategoryData().map(FoodCategoryModel.init)
        foodCategoryCount = foodCategories.count
        
        Notification.instance.requestAuthorization()
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
