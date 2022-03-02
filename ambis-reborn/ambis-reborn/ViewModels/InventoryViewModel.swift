//
//  InventoryViewModel.swift
//  ambis-reborn
//
//  Created by Rinaldi LNU on 10/07/21.
//

import Foundation
import CoreData

class InventoryViewModel: ObservableObject {
    @Published var inventoryId = UUID()
    @Published var watchIcon = ""
    @Published var filterCategory = "Expire Soon"
    
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
        self.filterCategory = "Expire Soon"
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
    
    //        let existingInventory = ExpiRemindCoreDataManager.shared.getInventoryById(id: inventoryData.id)
    //        if let existingInventory = existingInventory {
    //            existingInventory.name = name
    //            existingInventory.total = Double(total)!
    //            existingInventory.totalType = totalType
    //            existingInventory.store = store
    //            existingInventory.purchaseDate = purchaseDate
    //            existingInventory.expiryDate = expiryDate
    //            existingInventory.toFoodCategory = toInventory.first
    //            PersistenceController.shared.editInventoryData(inventory: existingInventory, model: inventoryData)
    //            getData()
    
//    func deleteData(_ inventory: InventoryModel) {
//        let existingInventory = ExpiRemindCoreDataManager.shared.getInventoryById(id: inventory.id)
//        if let existingInventory = existingInventory {
//            ExpiRemindCoreDataManager.shared.viewContext.delete(existingInventory)
//        }
//    }
    
    
//    
//    //DATA FROM SHOPPING LIST
//    func readDataFromShopping(shopping: ShoppingModel, purchaseDate: Date ,expiryDate: Date, store: String) {
//        let inventory = Inventory(context: PersistenceController.shared.container.viewContext)
//        inventory.name = shopping.name
//        inventory.total = shopping.total
//        inventory.totalType = shopping.totalType
//        inventory.purchaseDate = purchaseDate
//        inventory.expiryDate = expiryDate
//        inventory.store = store
//        if shopping.shopping.toFoodCategory != nil {
//            toInventory = [shopping.foodCategory]
//            if toInventory.count > 0 {
//                inventory.toFoodCategory = toInventory.first
//            }
//        }
//        PersistenceController.shared.saveData()
//    }
//    
//    //EDIT
//    func editData(index: InventoryModel) {
//        var count = 0
//        for data in inventory {
//            if data.id == index.id {
//                prepareDataEdit(index: count)
//                break
//            }
//            count += 1
//        }
//        selectedIndex = count
//        status = "edit"
//        isPresented = true
//    }
//    func prepareDataEdit(index: Int) {
//        name = inventory[index].name
//        total = String(inventory[index].total)
//        totalType = inventory[index].totalType
//        store = inventory[index].store
//        expiryDate = inventory[index].expiryDate
//        purchaseDate = inventory[index].purchaseDate
//        if inventory[index].inventory.toFoodCategory != nil {
//            toInventory = [inventory[index].foodCategory]
//            previewSelectedCategory = (inventory[index].foodCategory.imageString! + " " + inventory[index].foodCategory.name!)
//            detailDisclaimer = inventory[index].foodCategory.estimation!
//        }
//    }
//    //EDIT
//    
//    
//    //DELETE
//    func deleteItemByContextMenu(index: InventoryModel) {
//        var count = 0
//        for data in inventory {
//            if data.id == index.id {
//                let inventory = inventory[count]
//                deleteData(inventory)
//                break
//            }
//            count += 1
//        }
//        getData()
//    }
//    func deleteData(_ inventory: InventoryModel) {
//        let existingInventory = PersistenceController.shared.getInventoryDataById(id: inventory.id)
//        if let existingInventory = existingInventory {
//            PersistenceController.shared.deleteInventoryData(inventory: existingInventory)
//        }
//    }
//    //DELETE
//    
//    //CREATE
//    func prepareCreateData() {
//        resetData()
//        isPresented.toggle()
//        status = "create"
//    }
//    //CREATE
//    
//    func resetData() {
//        inventoryId = UUID()
//        name = ""
//        total = ""
//        totalType = "Kg"
//        store = "Fridge"
//        expiryDate = Date()
//        purchaseDate = Date()
//        toInventory = []
//        previewSelectedCategory = "Choose Category"
//        detailDisclaimer = ""
//    }
//    
//    func loadList() {
//        inventory = PersistenceController.shared.getInventoryData().map(InventoryModel.init).sorted { $0.expiryDate < $1.expiryDate }
//        inventoryCount = inventory.count
//        let itemExpire = inventory.filter { inv in
//            if inv.expiryDate <= Date().addingTimeInterval(24 * 60 * 60 * 3) {
//                return true
//            } else {
//                return false
//            }
//        }
//        inventoryExpire = itemExpire.count
//        //
//        inventoryExpiry = itemExpire
//        inventoryFridge = inventory.filter({ index in
//            return index.store == "Fridge"
//        })
//        inventoryFreezer = inventory.filter({ index in
//            return index.store == "Freezer"
//        })
//        inventoryOther = inventory.filter({ index in
//            return index.store == "Other"
//        })
//        //
//        if inventory.count != 0 {
//            progressBar = Float(itemExpire.count)/Float(inventory.count)
//        }
//        foodCategories = PersistenceController.shared.getCategoryData().map(FoodCategoryModel.init)
//        foodCategoryCount = foodCategories.count
////        Notification.instance.requestAuthorization()
//    }
//    
//    func getData() {
//        inventory = PersistenceController.shared.getInventoryData().map(InventoryModel.init).sorted { $0.expiryDate < $1.expiryDate}
//        inventoryCount = inventory.count
//        let itemExpire = inventory.filter { inv in
//            if inv.expiryDate <= Date().addingTimeInterval(24 * 60 * 60 * 3) {
//                return true
//            } else {
//                return false
//            }
//        }
//        inventoryExpire = itemExpire.count
//        //
//        inventoryExpiry = itemExpire
//        inventoryFridge = inventory.filter({ index in
//            return index.store == "Fridge"
//        })
//        inventoryFreezer = inventory.filter({ index in
//            return index.store == "Freezer"
//        })
//        inventoryOther = inventory.filter({ index in
//            return index.store == "Other"
//        })
//        //
//        if inventory.count != 0 {
//            progressBar = Float(itemExpire.count)/Float(inventory.count)
//        }
//    }
//    
//    func editData(_ inventoryData: InventoryModel) {
//        let existingInventory = ExpiRemindCoreDataManager.shared.getInventoryById(id: inventoryData.id)
//        if let existingInventory = existingInventory {
//            existingInventory.name = name
//            existingInventory.total = Double(total)!
//            existingInventory.totalType = totalType
//            existingInventory.store = store
//            existingInventory.purchaseDate = purchaseDate
//            existingInventory.expiryDate = expiryDate
//            existingInventory.toFoodCategory = toInventory.first
//            PersistenceController.shared.editInventoryData(inventory: existingInventory, model: inventoryData)
//            getData()
//        }
//    }
//    
//    @objc func refresh() {
//        loadList()
//    }
//    
//    func saveData() {
//        let inventory = Inventory(context: PersistenceController.shared.container.viewContext)
//        inventory.name = name
//        inventory.total = Double(total) ?? Double(0)
//        inventory.totalType = totalType
//        inventory.purchaseDate = purchaseDate
//        inventory.expiryDate = expiryDate
//        inventory.store = store
//        inventory.inventoryId = inventoryId
//        if toInventory.count > 0 {
//            inventory.toFoodCategory = toInventory.first
//        }
//        PersistenceController.shared.saveData()
//    }
}
