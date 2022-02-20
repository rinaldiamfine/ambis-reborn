//
//  InventoryMainView.swift
//  ExpiRemind
//
//  Created by Rinaldi LNU on 20/02/22.
//

import SwiftUI

struct InventoryMainView: View {
    @ObservedObject var inventoryViewModel = InventoryViewModel()
    @ObservedObject var foodCategoryViewModel = FoodCategoryViewModel()
    @State var filterCategory = "Expire Soon"
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack(alignment: .leading) {
                    if inventoryViewModel.inventory.isEmpty {
                        InventoryEmptyStateView(
                            title: "There are no items in your inventory",
                            subtitle: "Press the + button to add")
                    }
                    else {
                        ScrollView {
                            InventoryCategoryFilterView(
                                filterCategory: $filterCategory,
                                inventoryViewModel: inventoryViewModel)
                                .padding(.horizontal)
                            ForEach (inventoryViewModel.inventory, id:\.id) {
                                inventory in
                                VStack(spacing: 10) {
                                    InventoryListView(
                                        inventory: inventory,
                                        inventoryViewModel: inventoryViewModel)
                                }
                                .padding(.horizontal)
                            }
                        }
                        .background(Color("AppBackground"))
                    }
                }
                .navigationTitle("Inventory")
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        Button {
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
                        foodCategoryViewModel: foodCategoryViewModel,
                        isPresented: $inventoryViewModel.isPresented,
                        filterCategory: $filterCategory)
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
