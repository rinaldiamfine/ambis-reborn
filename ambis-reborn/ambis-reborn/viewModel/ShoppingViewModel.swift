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
    var name: String = ""
    var total: String = ""
    var totalType: String = ""
    var toInventory: [FoodCategory] = []
    
    @Published var selectedShopping = 0
    
    @Published var shopping: [ShoppingModel] = []
    @Published var shoppingCount: Int = 0
    
    func deleteData(_ shopping: ShoppingModel) {
        let existingShopping = PersistenceController.shared.getShoppingDataById(id: shopping.id)
        if let existingShopping = existingShopping {
            PersistenceController.shared.deleteShoppingData(shopping: existingShopping)
        }
    }
    
    func saveData() {
        let shopping = Shopping(context: PersistenceController.shared.container.viewContext)
        shopping.name = name
        shopping.total = Double(total)!
        shopping.totalType = totalType
        if toInventory.count > 0 {
            shopping.toFoodCategory = toInventory.first
        }
        PersistenceController.shared.saveData()
    }
    
    
}
