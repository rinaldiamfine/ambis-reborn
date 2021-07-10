//
//  InventoryFormView.swift
//  ambis-reborn
//
//  Created by Rinaldi LNU on 10/07/21.
//

import SwiftUI

struct InventoryFormView: View {
    @ObservedObject var inventoryViewModel: InventoryViewModel
    @Binding var isPresented: Bool
    
    var body: some View {
        TextField("Enter Inventory Name", text: $inventoryViewModel.name).textFieldStyle(RoundedBorderTextFieldStyle())
        Button("Save") {
            inventoryViewModel.saveData()
            inventoryViewModel.getData()
            isPresented = false
        }
    }
}
