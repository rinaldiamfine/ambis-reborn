//
//  InventoryView.swift
//  ambis-reborn
//
//  Created by Rinaldi LNU on 05/07/21.
//

import SwiftUI

struct InventoryView: View {
    @StateObject private var inventoryViewModel = InventoryViewModel()
    @State var isPresented = false
    
    func loadList() {
        inventoryViewModel.getData()
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
    
    var body: some View {
        NavigationView {
            VStack {
                if inventoryViewModel.inventoryCount > 0 {
                    List {
                        ForEach (inventoryViewModel.inventory, id:\.id) {
                            inventory in InventoryListView(title: inventory.name, subtitle: "")
                        }
                    }.listStyle(InsetGroupedListStyle())
                } else {
                    InventoryListEmptyView()
                }
            }
            .navigationBarTitle("Inventory")
            .navigationBarItems(trailing: Button(action: createData, label: {
                Image(systemName: "plus")
            }))
        }
        .sheet(isPresented: $isPresented) {
            InventoryFormView(inventoryViewModel: self.inventoryViewModel, isPresented: $isPresented)
        }
        .onAppear(perform: {
            inventoryViewModel.getData()
        })
    }
}

struct InventoryView_Previews: PreviewProvider {
    static var previews: some View {
        InventoryView()
    }
}
