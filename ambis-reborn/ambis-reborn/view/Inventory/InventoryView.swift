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
    @State var isPresented = false
    @State var selectedIndex = 0
    @State var status = ""
    @ObservedObject var searchBar: SearchBar = SearchBar()
    
    func loadList() {
        inventoryViewModel.getData()
        foodCategoryViewModel.getData()
        Notification.instance.requestAuthorization()
    }
    func getIconName() -> Image {
        return Image(systemName: "list.dash")
    }
    func gettabName() -> Text {
        return Text("List")
    }
    func editData(index: InventoryModel) {
        var count = 0
        for data in inventoryViewModel.inventory {
            if data.id == index.id {
                break
            }
            count += 1
        }
        self.selectedIndex = count
        self.status = "edit"
        self.isPresented = true
    }
    func createData() {
        self.status = "create"
        self.isPresented = true
    }
    
//    func deleteItem(at offsets: IndexSet) {
//        offsets.forEach { index in
//            let inventory = inventoryViewModel.inventory[index]
//            inventoryViewModel.deleteData(inventory)
//        }
//        inventoryViewModel.getData()
//        foodCategoryViewModel.getData()
//    }
    
    func deleteItemByContextMenu(index: InventoryModel) {
        var count = 0
        for data in inventoryViewModel.inventory {
            if data.id == index.id {
                let inventory = inventoryViewModel.inventory[count]
                inventoryViewModel.deleteData(inventory)
                break
            }
            count += 1
        }
        inventoryViewModel.getData()
        foodCategoryViewModel.getData()
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
                                .contextMenu {
                                    Button {
                                        editData(index: inventory)
                                        print("edit")
                                        
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
                                        deleteItemByContextMenu(index: inventory)
                                    } label: {
                                        Text("Remove")
                                        Image(systemName: "trash")
                                    }
                                }
                        }
//                        .onDelete(perform: deleteItem)
                    }
                    .listStyle(InsetGroupedListStyle())
                } else {
                    InventoryListEmptyView()
                }
            }
            .navigationBarTitle("Inventory")
            .navigationBarItems(trailing: Button(action: createData, label: {
                Image(systemName: "plus")
            }))
            .add(self.searchBar)
        }
        .sheet(isPresented: $isPresented) {
            InventoryFormView(inventoryViewModel: self.inventoryViewModel, isPresented: $isPresented, status: $status, selectedIndex: $selectedIndex, foodCategoryViewModel: self.foodCategoryViewModel)
        }
        .onAppear(perform: {
            loadList()
        })
    }
}

struct InventoryView_Previews: PreviewProvider {
    static var previews: some View {
        InventoryView()
    }
}
