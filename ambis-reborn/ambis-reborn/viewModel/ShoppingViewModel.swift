//
//  ShoppingViewModel.swift
//  ambis-reborn
//
//  Created by Muhammad Rizki Miftha Alhamid on 7/14/21.
//

import Foundation
import UIKit
import CoreData

class ShoppingViewModel: ObservableObject{
    @Published var name: String = ""
    @Published var total: String = ""
    @Published var totalType: String = "Kg"
    @Published var store: String = "Fridge"
    
    @Published var toShopping: [FoodCategory] = []
    @Published var selectedShopping = 0
    
    @Published var purchaseDate: Date = Date()
    @Published var expiryDate: Date = Date()
    
    @Published var shopping: [ShoppingModel] = []
    @Published var shoppingCount: Int = 0
    @Published var foodCategories: [FoodCategoryModel] = []
    @Published var foodCategoryCount: Int = 0
    
    @Published var isPresented = false
    @Published var selectedIndex = 0
    @Published var status = ""
    
    @Published var previewSelectedCategory = "Choose Category"
    @Published var detailDisclaimer = ""
    
    //For moving to inventory
    @Published var shoppingToBeMoved: [NSManagedObjectID] = []
    @Published var arrayPurchaseDate: [Date] = []
    @Published var arrayExpiryDate: [Date] = []
    @Published var arrayStore: [String] = []
    
    
    //UPDATE (before moving to inventory)
    func updateShoppingDetails(shoppingItem: ShoppingModel) {
        let shopping = Shopping(context: PersistenceController.shared.container.viewContext)
        shopping.name = shoppingItem.name
        shopping.total = shoppingItem.total
        shopping.totalType = shoppingItem.totalType
        shopping.purchaseDate = shoppingItem.purchaseDate
        shopping.expiryDate = shoppingItem.expiryDate
        if toShopping.count > 0 {
            shopping.toFoodCategory = toShopping.first
        }
        PersistenceController.shared.saveData()
    }
    
    //DELETE
    func deleteItemByContextMenu(index: ShoppingModel) {
        var count = 0
        for data in shopping {
            if data.id == index.id {
                let shopping = shopping[count]
                deleteData(shopping)
                break
            }
            count += 1
        }
        getData()
    }
    
    func deleteData(_ shopping: ShoppingModel) {
        let existingShopping = PersistenceController.shared.getShoppingDataById(id: shopping.id)
        if let existingShopping = existingShopping {
            PersistenceController.shared.deleteShoppingData(shopping: existingShopping)
        }
    }
    
    func deleteMovedShoppingList(ids: [NSManagedObjectID]) {
        for data in shopping {
            for id in ids {
                if data.id == id {
                    deleteData(data)
                }
            }
        }
        getData()
    }
    
    //EDIT
    func editData(index: ShoppingModel) {
        var count = 0
        for data in shopping {
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
        name = shopping[index].name
        total = String(shopping[index].total)
        totalType = shopping[index].totalType
        toShopping = [shopping[index].foodCategory]
        previewSelectedCategory = (shopping[index].foodCategory.imageString! + " " + shopping[index].foodCategory.name!)
        detailDisclaimer = shopping[index].foodCategory.estimation!
    }
    func editData(_ shopping: ShoppingModel) {
        let existingShopping = PersistenceController.shared.getShoppingDataById(id: shopping.id)
        if let existingShopping = existingShopping {
            existingShopping.name = name
            existingShopping.total = Double(total)!
            existingShopping.totalType = totalType
            existingShopping.toFoodCategory = toShopping.first
            PersistenceController.shared.editShoppingData(shopping: existingShopping, model: shopping)
            getData()
        }
    }
    
    //CREATE
    func prepareCreateData() {
        resetData()
        isPresented.toggle()
        status = "create"
    }
    
    func resetData() {
        name = ""
        total = ""
        totalType = "Kg"
        toShopping = []
        previewSelectedCategory = "Choose Category"
        detailDisclaimer = ""
    }
    
    
    func saveData() {
        let shopping = Shopping(context: PersistenceController.shared.container.viewContext)
        shopping.name = name
        shopping.total = Double(total) ?? Double(0)
        shopping.totalType = totalType
        if toShopping.count > 0 {
            shopping.toFoodCategory = toShopping.first
        }
        PersistenceController.shared.saveData()
    }
    
    func loadList() {
        shopping = PersistenceController.shared.getShoppingData().map(ShoppingModel.init)
        shoppingCount = shopping.count
        
        foodCategories = PersistenceController.shared.getCategoryData().map(FoodCategoryModel.init)
        foodCategoryCount = foodCategories.count
        
    }
    
    func getData() {
        shopping = PersistenceController.shared.getShoppingData().map(ShoppingModel.init)
        shoppingCount = shopping.count
    }
    
}
