//
//  InventoryView.swift
//  ambis-reborn
//
//  Created by Rinaldi LNU on 05/07/21.
//

import SwiftUI
import CoreData

struct InventoryView: View {
    @StateObject private var inventoryViewModel = InventoryViewModel()
    @StateObject private var foodCategoryViewModel = FoodCategoryViewModel()
    @State var isPresented = false
    @ObservedObject var searchBar: SearchBar = SearchBar()
    
    func loadList() {
        inventoryViewModel.getData()
        foodCategoryViewModel.getData()
    }
    func getIconName() -> Image {
        return Image(systemName: "list.dash")
    }
    func gettabName() -> Text {
        return Text("List")
    }
    func createData() {
        self.isPresented = true
    }
    
    func deleteItem(at offsets: IndexSet) {
        offsets.forEach { index in
            let inventory = inventoryViewModel.inventory[index]
            inventoryViewModel.deleteData(inventory)
        }
        inventoryViewModel.getData()
    }
    
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
    }
    
    var body: some View {
        NavigationView {
            VStack {
                if inventoryViewModel.inventoryCount > 0 {
                    List {
                        ForEach (inventoryViewModel.inventory.filter {
                            searchBar.text.isEmpty ||
                                $0.name.localizedStandardContains(searchBar.text)
                        }, id:\.id) {
                            inventory in InventoryListView(inventory: inventory)
                                .contextMenu {
                                    Button {
                                        print("edit")
                                    } label: {
                                        Label("Update Inventory", systemImage: "square.and.pencil")
                                    }
                                    Button {
                                        print("share")
                                    } label: {
                                        Label("Share", systemImage: "arrowshape.turn.up.forward")
                                    }
                                    Button {
                                        print("delete", inventory.id)
                                        deleteItemByContextMenu(index: inventory)
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                }
                        }
                        .onDelete(perform: deleteItem)
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
            InventoryFormView(inventoryViewModel: self.inventoryViewModel, isPresented: $isPresented, foodCategoryViewModel: self.foodCategoryViewModel)
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
