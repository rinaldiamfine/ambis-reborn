//
//  InventoryView.swift
//  ambis-reborn
//
//  Created by Rinaldi LNU on 05/07/21.
//

import SwiftUI

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
        print("Yuk create data inventory", self.isPresented)
        self.isPresented = true
    }
    
    func deleteItem(at offsets: IndexSet) {
        offsets.forEach { index in
            let inventory = inventoryViewModel.inventory[index]
            inventoryViewModel.deleteData(inventory)
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
