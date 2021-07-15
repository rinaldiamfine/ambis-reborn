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
    @ObservedObject var inventoryViewModel = InventoryViewModel()
    @ObservedObject var foodCategoryViewModel = FoodCategoryViewModel()
    @ObservedObject var searchBar: SearchBar = SearchBar()
    
    var storeAvailable = AppGlobalData.generateDataStore()
    @State private var selectedStore = "Fridge"
    
    func getIconName() -> Image {
        return Image(systemName: "list.dash")
    }
    func gettabName() -> Text {
        return Text("List")
    }
    
    var body: some View {
        NavigationView {
            VStack {
                if inventoryViewModel.inventoryCount > 0 {
                    List {
                        Picker("", selection: $selectedStore) {
                            ForEach(storeAvailable, id: \.self.name) {
                                Text($0.name)
                            }
                        }.pickerStyle(SegmentedPickerStyle())
                        
                        //Fridge
                        Section(header: Text(selectedStore)) {
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
                        
                    }
                    .listStyle(InsetGroupedListStyle())
                } else {
                    InventoryListEmptyView()
                }
            }
            .navigationBarTitle("Inventory")
            .navigationBarItems(
                trailing: Button(action: inventoryViewModel.prepareCreateData, label: {
                    Image(systemName: "plus").imageScale(.large)
                }).contentShape(Circle())
            )
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
