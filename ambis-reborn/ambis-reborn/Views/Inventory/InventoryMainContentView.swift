//
//  InventoryMainContentView.swift
//  ExpiRemind
//
//  Created by Rinaldi LNU on 23/02/22.
//

import SwiftUI

struct InventoryMainContentView: View {
    @Environment(\.isSearching) var isSearching
    @ObservedObject var inventoryViewModel: InventoryViewModel
    
    var body: some View {
        GeometryReader { geometry in
            if !isSearching {
                if inventoryViewModel.filterByCategory().isEmpty {
                    ScrollView {
                        HStack {
                            InventoryCategoryFilterView(
                                inventoryViewModel: inventoryViewModel)
                                .padding(.horizontal)
                        }
                        HStack {
                            InventoryEmptyStateView(
                                inventoryViewModel: inventoryViewModel,
                                icon: inventoryViewModel.filterCategory,
                                title: "",
                                subtitle: "Press the + button to add")
                        }
                        .frame(minHeight: geometry.size.height - 140)
                    }
                } else {
                    ScrollView {
                        VStack {
                            HStack {
                                InventoryCategoryFilterView(
                                    inventoryViewModel: inventoryViewModel)
                                    .padding(.horizontal)
                            }
                            ForEach (inventoryViewModel.filterByCategory(), id:\.id) {
                                inventory in
                                VStack(spacing: 10) {
                                    InventoryListContentView(
                                        inventory: inventory,
                                        inventoryViewModel: inventoryViewModel)
                                }
                                .padding(.horizontal)
                            }
                        }
                        .animation(.default)
                    }
                }
            } else {
                if inventoryViewModel.filterByQuery().isEmpty {
                    InventoryEmptyStateView(
                        inventoryViewModel: inventoryViewModel,
                        icon: inventoryViewModel.filterCategory,
                        title: "There are no items found",
                        subtitle: "Please try another keyword")
                } else {
                    ScrollView {
                        ForEach (inventoryViewModel.filterByQuery(), id:\.id) {
                            inventory in
                            VStack(spacing: 10) {
                                InventoryListContentView(
                                    inventory: inventory,
                                    inventoryViewModel: inventoryViewModel)
                            }
                            .padding(.horizontal)
                        }
                    }
                }
            }
        }
    }
}
