//
//  InventoryMainView.swift
//  ExpiRemind
//
//  Created by Rinaldi LNU on 20/02/22.
//

import SwiftUI

struct InventoryMainView: View {
    @ObservedObject var viewModel = InventoryViewModel()
    @State var isPresented = false
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack(alignment: .leading) {
                    if viewModel.inventory.isEmpty {
                        InventoryEmptyStateView(
                            title: "There are no items in your inventory",
                            subtitle: "Press the + button to add")
                    }
                    else {
                        ScrollView {
                            InventoryCategoryFilterView(viewModel: viewModel)
                                .padding(.horizontal)
                            
                            ForEach (viewModel.inventory, id:\.id) {
                                inventory in
                                VStack(spacing: 10) {
                                    InventoryListView(
                                        inventory: inventory,
                                        inventoryViewModel: viewModel)
                                }
                                .padding(.horizontal)
                            }
                        }
                        .background(Color("AppBackground"))
                    }
                }
            }
            .navigationTitle("Inventory")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button {
                        isPresented.toggle()
                    } label: {
                        Image(systemName: "plus")
                            .imageScale(.large)
                            .foregroundColor(Color("BackgroundInverse"))
                    }
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
