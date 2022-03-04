//
//  WidgetInventoryModel.swift
//  ambis-reborn
//
//  Created by Rinaldi LNU on 02/08/21.
//

import Foundation
import SwiftUI


struct WidgetInventoryModel: Identifiable, Decodable, Encodable {
    var id = UUID()
    var totalExpiry: Int {
        var total = 0
        if !inventory.isEmpty {
            let expiry = inventory.filter { inventory in
                if inventory.remainingDate <= 0 {
                    return true
                } else {
                    return false
                }
            }
            total = expiry.count
        }
        return total
    }
    var totalInventory: Int {
        var total = 0
        if !inventory.isEmpty {
            total = inventory.count
        }
        return total
    }
    var progressBar: Float {
        var total: Float = 0
        if totalInventory != 0 {
            total = Float(totalExpiry)/Float(totalInventory)
        }
        print(total, "TOTAL PROGRESS")
        return total
    }
    var inventory: [WidgetInventoryModelList]
}

struct WidgetInventoryModelList: Identifiable, Decodable, Encodable {
    var id = UUID()
    var name: String
    var store: String
    var total: Double
    var totalType: String
    var icon: String
    var remainingDate : Int
    
    var formatSubtitle : String {
        var format = ""
        format = store + "・" + String(total) + " " + totalType
        return format
    }
}
