//
//  InventoryMainView.swift
//  ExpiRemind
//
//  Created by Rinaldi LNU on 20/02/22.
//

import SwiftUI

struct InventoryMainView: View {
    @ObservedObject var inventoryViewModel = InventoryViewModel()
    @State var filterCategory = "Expire Soon"
    
    @State private var query = ""
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack(alignment: .leading) {
                    if inventoryViewModel.inventory.isEmpty {
                        InventoryEmptyStateView(
                            inventoryViewModel: inventoryViewModel, icon: "plus",
                            title: "There are no items in your inventory",
                            subtitle: "Press the + button to add")
                    }
                    else {
                        ScrollView {
                            VStack {
                                InventoryCategoryFilterView(
                                    inventoryViewModel: inventoryViewModel)
                                    .padding(.horizontal)
                                if inventoryViewModel.filterByCategory().isEmpty {
                                    InventoryEmptyStateView(
                                        inventoryViewModel: inventoryViewModel, icon: inventoryViewModel.filterCategory,
                                        title: "",
                                        subtitle: "Press the + button to add")
                                        .frame(height: geometry.self.size.height)
                                } else {
                                    ForEach (inventoryViewModel.filterByCategory(), id:\.id) {
                                        inventory in
                                        VStack(spacing: 10) {
                                            InventoryMainContentView(
                                                inventory: inventory,
                                                inventoryViewModel: inventoryViewModel)
                                        }
                                        .padding(.horizontal)
                                    }
                                }
                            }
                            .searchable(text: $query, prompt: "Search Inventory")
                        }
                        .background(Color("AppBackground"))
                    }
                }
                .animation(.default)
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
}

struct InventoryMainView_Previews: PreviewProvider {
    static var previews: some View {
        InventoryMainView()
    }
}
