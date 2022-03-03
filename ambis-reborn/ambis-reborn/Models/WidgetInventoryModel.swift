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
    var totalExpiry: Int
    var totalInventory: Int
    var progressBar: Float
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
}
