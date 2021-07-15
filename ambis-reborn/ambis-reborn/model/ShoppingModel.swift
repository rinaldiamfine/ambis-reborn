//
//  ShoppingModel.swift
//  ambis-reborn
//
//  Created by Muhammad Rizki Miftha Alhamid on 7/14/21.
//

import Foundation
import CoreData

struct ShoppingModel {
    let shopping: Shopping
    
    var id: NSManagedObjectID {
        return shopping.objectID
    }
    var foodCategory: FoodCategory {
        return shopping.toFoodCategory ?? FoodCategory()
    }
    var name: String {
        return shopping.name ?? ""
    }
    var total: Double {
        return Double(shopping.total)
    }
    var totalType: String {
        return shopping.totalType ?? ""
    }
    var isShowDetail: Bool {
        return true
    }
    
}
