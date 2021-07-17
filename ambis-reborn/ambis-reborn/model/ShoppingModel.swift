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
    var purchaseDate: Date {
        return shopping.purchaseDate ?? Date()
    }
    var expiryDate: Date {
        return shopping.expiryDate ?? Date()
    }
    
    var remainingDays: Int {
        var remainingDays: Int = 0
        let currentDate = Date()
        let secondToDay: Double = 60 * 60 * 24
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        if dateFormatter.string(from: currentDate) == dateFormatter.string(from: expiryDate) {
            remainingDays = 0
        } else {
            let roundingDay = Int(round(currentDate.distance(to: expiryDate) / secondToDay))
            remainingDays = roundingDay
        }
        return remainingDays
    }
    
}
