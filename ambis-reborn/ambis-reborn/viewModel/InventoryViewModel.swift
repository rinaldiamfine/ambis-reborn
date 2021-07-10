//
//  InventoryViewModel.swift
//  ambis-reborn
//
//  Created by Rinaldi LNU on 10/07/21.
//

import Foundation
import UIKit
import CoreData

class InventoryViewModel: ObservableObject {
    var name: String = ""
    @Published var inventory: [InventoryModel] = []
    @Published var inventoryCount: Int = 0
    
    func getData() {
        inventory = PersistenceController.shared.getInventoryData().map(InventoryModel.init)
        inventoryCount = inventory.count
        print("CURRENT INVENT", inventoryCount)
    }
    
    func saveData() {
        let inventory = Inventory(context: PersistenceController.shared.container.viewContext)
        inventory.name = name
        PersistenceController.shared.saveData()
    }
}
