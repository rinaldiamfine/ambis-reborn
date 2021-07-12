//
//  InventoryModel.swift
//  ambis-reborn
//
//  Created by Rinaldi LNU on 10/07/21.
//

import Foundation
import CoreData

struct InventoryModel {
    let inventory: Inventory
    
    var id: NSManagedObjectID {
        return inventory.objectID
    }
    
    var name: String {
        return inventory.name ?? ""
    }
    var total: Double {
        return Double(inventory.total)
    }
    var totalType: String {
        return inventory.totalType ?? ""
    }
    var purchaseDate: Date {
        return inventory.purchaseDate ?? Date()
    }
    var expiryDate: Date {
        return inventory.expiryDate ?? Date()
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
