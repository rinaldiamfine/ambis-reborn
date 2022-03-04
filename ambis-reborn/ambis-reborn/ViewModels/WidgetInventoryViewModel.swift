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
    
    init() {
        inventoryModel = []
    }
}
