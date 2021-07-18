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
    @State private var defaultFilter = "Expiry Soon"
    @Environment(\.colorScheme) var colorScheme
    
    var storeAvailable = AppGlobalData.generateDataStore()
    
    func getIconName() -> Image {
        return Image(systemName: "list.dash")
    }
    func gettabName() -> Text {
        return Text("List")
    }
    
//    searchBar.text.isEmpty || $0.name.localizedStandardContains(searchBar.text) && $0.store.localizedStandardContains(defaultFilter)
    init() {
//        UINavigationBar.appearance().backgroundColor = .red
        let nav = UINavigationBarAppearance()
        nav.backgroundColor = .red
    }
    
    var body: some View {
        NavigationView {
            VStack {
                if inventoryViewModel.inventoryCount > 0 {
                    InventoryFilterView(defaultFilter: $defaultFilter)
                    List {
                        Section(header: Text(defaultFilter).font(.system(size: 20, weight: .semibold)).foregroundColor(colorScheme == .dark ? Color.white : Color.black)) {
                            ForEach (inventoryViewModel.inventory.filter {
                                if defaultFilter == "Expiry Soon" {
                                    return true
                                } else {
                                    if searchBar.text.isEmpty {
                                        return $0.store.localizedStandardContains(defaultFilter)
                                    } else {
                                        return $0.name.localizedStandardContains(searchBar.text) && $0.store.localizedStandardContains(defaultFilter)
                                    }
                                }
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
                        }.textCase(nil)
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
