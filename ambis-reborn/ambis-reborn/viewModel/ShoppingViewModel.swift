//
//  ShoppingViewModel.swift
//  ambis-reborn
//
//  Created by Muhammad Rizki Miftha Alhamid on 7/14/21.
//

import Foundation
import UIKit
import CoreData
import SwiftUI

class ShoppingViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var total: String = ""
    @Published var totalType: String = ""
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
    
    //CREATE
    func prepareCreateData() {
        resetData()
        isPresented.toggle()
        status = "create"
    }
    
    func resetData() {
        name = ""
        total = ""
        totalType = ""
        toShopping = []
        previewSelectedCategory = "Choose Category"
        detailDisclaimer = ""
    }
    
    
    func saveData() {
        let shopping = Shopping(context: PersistenceController.shared.container.viewContext)
        shopping.name = name
        shopping.total = Double(total)!
        shopping.totalType = totalType
        if toShopping.count > 0 {
            shopping.toFoodCategory = toShopping.first
        }
        PersistenceController.shared.saveData()
    }
    
    func loadList() {
        getData()
    }
    
    func getData() {
        shopping = PersistenceController.shared.getShoppingData().map(ShoppingModel.init)
        shoppingCount = shopping.count
        
        foodCategories = PersistenceController.shared.getCategoryData().map(FoodCategoryModel.init)
        foodCategoryCount = foodCategories.count
    }
    
}
