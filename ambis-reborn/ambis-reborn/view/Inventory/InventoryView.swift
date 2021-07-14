//
//  InventoryView.swift
//  ambis-reborn
//
//  Created by Rinaldi LNU on 05/07/21.
//

import SwiftUI
import UIKit
import CoreData
import UserNotifications

struct InventoryView: View {
    @StateObject private var inventoryViewModel = InventoryViewModel()
    @StateObject private var foodCategoryViewModel = FoodCategoryViewModel()
    @ObservedObject var searchBar: SearchBar = SearchBar()
    
    func getIconName() -> Image {
        return Image(systemName: "list.dash")
    }
    func gettabName() -> Text {
        return Text("List")
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 50) {
                if inventoryViewModel.inventoryCount > 0 {
                    List {
                        ForEach (inventoryViewModel.inventory.filter {
                            searchBar.text.isEmpty ||
                                $0.name.localizedStandardContains(searchBar.text)
                        }, id:\.id) {
                            inventory in InventoryListView(inventory: inventory)
                                .environmentObject(InventoryViewModel())
                                .contextMenu {
                                    Button {
                                        inventoryViewModel.editData(index: inventory)
                                    } label: {
                                        Label("Update Inventory", systemImage: "square.and.pencil")
                                    }
                                    
                                    Button {
                                        print("share")
                                    } label: {
                                        Label("Share", systemImage: "arrowshape.turn.up.forward")
                                    }
                                    
                                    Divider()
                                    Button {
                                        inventoryViewModel.deleteItemByContextMenu(index: inventory)
                                    } label: {
                                        Text("Remove")
                                        Image(systemName: "trash")
                                    }
                                }
                        }
                    }
                    .listStyle(InsetGroupedListStyle())
                } else {
                    InventoryListEmptyView()
                }
            }
            .navigationBarTitle("Inventory")
            .navigationBarItems(trailing: Button(action: inventoryViewModel.prepareCreateData, label: {
                Image(systemName: "plus")
            }))
            .add(self.searchBar)
        }
        .sheet(isPresented: $inventoryViewModel.isPresented) {
            InventoryFormView(inventoryViewModel: inventoryViewModel, foodCategoryViewModel: foodCategoryViewModel, isPresented: $inventoryViewModel.isPresented)
        }
        .onAppear(perform: {
            inventoryViewModel.loadList()
            foodCategoryViewModel.getData()
        })
        .onDisappear(perform: {
            inventoryViewModel.loadList()
            foodCategoryViewModel.getData()
        })
    }
}

//struct InventoryView_Previews: PreviewProvider {
//    static var previews: some View {
//        InventoryView()
//    }
//}
