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
    @Published var totalType: String = "Kg"
    @Published var store: String = "Fridge"
    
    @Published var toInventory: [FoodCategory] = []
    @Published var selectedInventory = 0
    
    @Published var purchaseDate: Date = Date()
    @Published var expiryDate: Date = Date()
    
    @Published var inventory: [InventoryModel] = []
    @Published var inventoryCount: Int = 0
    @Published var foodCategories: [FoodCategoryModel] = []
    @Published var foodCategoryCount: Int = 0
    
    @Published var isPresented: Bool = false
    @Published var selectedIndex: Int = 0
    @Published var status: String = ""
    
    @Published var previewSelectedCategory: String = "Choose Category"
    @Published var detailDisclaimer: String = ""
    @Published var expiryEstimation: Int = 0
    
    //DATA FROM SHOPPING LIST
    func readDataFromShopping(shopping: ShoppingModel, expiryDate: Date) {
        let inventory = Inventory(context: PersistenceController.shared.container.viewContext)
        inventory.name = shopping.name
        inventory.total = shopping.total
        inventory.totalType = shopping.totalType
        inventory.purchaseDate = shopping.purchaseDate
        inventory.expiryDate = expiryDate
        //
        inventory.store = ""
        //
        toInventory = [shopping.foodCategory]
        if toInventory.count > 0 {
            inventory.toFoodCategory = toInventory.first
        }
        PersistenceController.shared.saveData()
    }
    
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
        store = inventory[index].store
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
        totalType = "Kg"
        store = "Fridge"
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
            existingInventory.store = store
            existingInventory.purchaseDate = purchaseDate
            existingInventory.expiryDate = expiryDate
            existingInventory.toFoodCategory = toInventory.first
            PersistenceController.shared.editInventoryData(inventory: existingInventory, model: inventory)
            getData()
        }
    }
    
    func saveData() {
        let inventory = Inventory(context: PersistenceController.shared.container.viewContext)
        inventory.name = name
        inventory.total = Double(total) ?? Double(0)
        inventory.totalType = totalType
        inventory.purchaseDate = purchaseDate
        inventory.expiryDate = expiryDate
        inventory.store = store
        if toInventory.count > 0 {
            inventory.toFoodCategory = toInventory.first
        }
        PersistenceController.shared.saveData()
    }
}
