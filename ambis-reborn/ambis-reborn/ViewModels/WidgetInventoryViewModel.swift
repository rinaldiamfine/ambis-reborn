//
//  WidgetInventoryViewModel.swift
//  ambis-reborn
//
//  Created by Rinaldi LNU on 02/08/21.
//

import Foundation
import UIKit
import CoreData

class WidgetInventoryViewModel: ObservableObject {
    @Published var inventoryModel = [WidgetInventoryModel]()
    @Published var totalExpiry : Int = 0
    @Published var totalInventory : Int = 0
    @Published var progressBar : Double = 0.0
    
    init() {
        inventoryModel = []
    }
}
