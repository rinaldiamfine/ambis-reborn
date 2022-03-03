//
//  InventoryMainView.swift
//  ExpiRemind
//
//  Created by Rinaldi LNU on 20/02/22.
//

import SwiftUI

struct InventoryMainView: View {
    @EnvironmentObject var inventoryViewModel: InventoryViewModel
    
    func getIconNameActive() -> Image {
        return Image("TabBarInventoryActive")
    }
    func getIconName() -> Image {
        return Image("TabBarInventory")
    }
    func gettabName() -> Text {
        return Text("Inventory")
    }
    
    var body: some View {
        NavigationView {
            Group {
                if inventoryViewModel.inventory.isEmpty {
                    InventoryEmptyStateView(
                        inventoryViewModel: inventoryViewModel,
                        icon: "plus",
                        title: "There are no items in your inventory",
                        subtitle: "Press the + button to add")
                }
                else {
                    VStack {
                        InventoryMainContentView(
                            inventoryViewModel: inventoryViewModel)
                    }
                    .searchable(
                        text: $inventoryViewModel.filterQuery,
                        prompt: "Search Inventory")
                    .background(Color("AppBackground"))
                }
            }
            .navigationTitle("Inventory")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button {
                        inventoryViewModel.setDefaultForm()
                        inventoryViewModel.status = "create"
                        inventoryViewModel.isPresented.toggle()
                    } label: {
                        Image(systemName: "plus")
                            .imageScale(.large)
                            .foregroundColor(Color("BackgroundInverse"))
                    }
                }
            }
            .sheet(isPresented: $inventoryViewModel.isPresented) {
                InventoryModalFormView(
                    inventoryViewModel: inventoryViewModel,
                    isPresented: $inventoryViewModel.isPresented)
            }
        }
    }
}

struct InventoryMainView_Previews: PreviewProvider {
    static var previews: some View {
        InventoryMainView()
    }
}