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
//    var inventory: [String]
    var inventory: [WidgetInventoryModelList]
    
//    enum CodingKeys: String, CodingKey {
//        case totalExpiry, totalInventory, progressBar, inventory
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        totalExpiry = try values.decode(Int.self, forKey: .totalExpiry)
//        totalInventory = try values.decode(Int.self, forKey: .totalInventory)
//        progressBar = try values.decode(Float.self, forKey: .totalExpiry)
//    }

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
