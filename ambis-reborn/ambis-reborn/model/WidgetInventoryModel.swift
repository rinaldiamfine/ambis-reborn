//
//  WidgetInventoryModel.swift
//  ambis-reborn
//
//  Created by Rinaldi LNU on 02/08/21.
//

import Foundation
import SwiftUI


struct WidgetInventoryModel: Identifiable , Encodable, Decodable {
    var id = UUID()
    var totalExpiry: Int
    var totalInventory: Int
    var progressBar: Float
}
