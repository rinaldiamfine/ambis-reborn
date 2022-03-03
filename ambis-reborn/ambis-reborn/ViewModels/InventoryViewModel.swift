//
//  InventoryViewModel.swift
//  ambis-reborn
//
//  Created by Rinaldi LNU on 10/07/21.
//

import Foundation
import CoreData
import UserNotifications

class InventoryViewModel: ObservableObject {
    @Published var inventoryId = UUID()
    @Published var watchIcon = ""
    @Published var filterCategory = "Expire Soon"
    @Published var filterQuery = ""
    
    @Published var id: NSManagedObjectID = NSManagedObjectID()
    @Published var name: String = ""
    @Published var total: String = ""
    @Published var totalType: String = "Kg"
    @Published var store: String = "Fridge"
    @Published var toFoodCategory: FoodCategory = FoodCategory()
    @Published var purchaseDate: Date = Date()
    @Published var expiryDate: Date = Date()
    
    @Published var inventory: [InventoryModel] = []
    @Published var foodCategories: [FoodCategoryModel] = []
    
    @Published var inventoryCount: Int = 0
    @Published var inventoryExpire: Int = 0
    @Published var progressBar: Float = 0.0
    
    @Published var isPresented: Bool = false
    @Published var selectedIndex: Int = 0
    @Published var status: String = ""
    
    @Published var previewSelectedCategory: String = "Choose Category"
    @Published var detailDisclaimer: String = ""
    @Published var expiryEstimation: Int = 0
    
    private var timeIntervalExpiry = 24*60*60*3 // 3 DAYS
    
    // NOT USED
    @Published var prepareSelectedInventory: [NSManagedObjectID] = []
        
    init() {
        setDefaultForm()
        fetchInventory()
    }
    
    func filterByQuery() -> [InventoryModel] {
        if !filterQuery.isEmpty {
            return inventory.filter { inventory in
                return inventory.name.localizedStandardContains(filterQuery)
            }
        } else {
            return inventory
        }
    }
    
    func filterByCategory() -> [InventoryModel] {
        if self.filterCategory == "Expire Soon" {
            return inventory.filter { inventory in
                if inventory.expiryDate <= Date().addingTimeInterval(TimeInterval(timeIntervalExpiry)) {
                    return true
                } else {
                    return false
                }
            }
        } else {
            return inventory.filter { inventory in
                if inventory.store == self.filterCategory {
                    return true
                }
                else {
                    return false
                }
            }
        }
    }
    func fetchInventory() {
        inventory = ExpiRemindCoreDataManager.shared.fetchInventory()
        foodCategories = ExpiRemindCoreDataManager.shared.fetchCategory()
    }
    func create() {
        let inventory = Inventory(context: ExpiRemindCoreDataManager.shared.viewContext)
        inventory.name = self.name
        inventory.total = Double(self.total) ?? Double(0)
        inventory.totalType = self.totalType
        inventory.purchaseDate = self.purchaseDate
        inventory.expiryDate = self.expiryDate
        inventory.store = store
        inventory.inventoryId = self.inventoryId
        if self.toFoodCategory != FoodCategory() {
            inventory.toFoodCategory = self.toFoodCategory
        }
        ExpiRemindCoreDataManager.shared.save()
        fetchInventory()
    }
    func setDefaultForm() {
        inventoryId = UUID()
        name = ""
        total = ""
        totalType = "Kg"
        store = "Fridge"
        expiryDate = Date()
        purchaseDate = Date()
        previewSelectedCategory = "Choose Category"
        detailDisclaimer = ""
        toFoodCategory = FoodCategory()
    }
    func fillForm(model: InventoryModel) {
        id = model.id
        name = model.name
        total = String(model.total)
        totalType = model.totalType
        inventoryId = model.inventoryId
        store = model.store
        expiryDate = model.expiryDate
        purchaseDate = model.purchaseDate
        if model.inventory.toFoodCategory != nil {
            toFoodCategory = model.foodCategory
            previewSelectedCategory = (model.foodCategory.imageString! + " " + model.foodCategory.name!)
            detailDisclaimer = model.foodCategory.estimation!
        }
        status = "edit"
        isPresented = true
    }
    func edit() {
        let inventory = ExpiRemindCoreDataManager.shared.getInventoryById(id: self.id)
        if let inventory = inventory {
            inventory.name = self.name
            inventory.name = self.name
            inventory.total = Double(self.total) ?? Double(0)
            inventory.totalType = self.totalType
            inventory.purchaseDate = self.purchaseDate
            inventory.expiryDate = self.expiryDate
            inventory.store = store
            inventory.inventoryId = self.inventoryId
            inventory.toFoodCategory = self.toFoodCategory
        }
        ExpiRemindCoreDataManager.shared.save()
    }
    func deleteById(model: InventoryModel) {
        let inventory = ExpiRemindCoreDataManager.shared.getInventoryById(id: model.id)
        if let inventory = inventory {
            ExpiRemindCoreDataManager.shared.viewContext.delete(inventory)
            ExpiRemindCoreDataManager.shared.save()
        }
        fetchInventory()
    }
    
}
