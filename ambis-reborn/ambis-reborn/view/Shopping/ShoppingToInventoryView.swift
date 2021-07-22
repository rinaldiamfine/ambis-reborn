//
//  ShoppingToInventoryView.swift
//  ambis-reborn
//
//  Created by Muhammad Rizki Miftha Alhamid on 7/15/21.
//

import SwiftUI
import CoreData

struct ShoppingToInventoryView: View {
    @ObservedObject var inventoryViewModel = InventoryViewModel()
    @ObservedObject var shoppingViewModel = ShoppingViewModel()
    @ObservedObject var foodCategoryViewModel = FoodCategoryViewModel()
    
    //@State var isShowDetail = false
    
    @Binding var isMovedToInventory: Bool
    
    func actionCancel() {
        //shoppingViewModel.resetData()
        //POP VIEW
        isMovedToInventory = false
    }
    
    func actionDone() {
        var counter = 0
        for shopping in shoppingViewModel.shopping {
            if shoppingViewModel.shoppingToBeMoved.contains(shopping.id) {
                shoppingViewModel.purchaseDate = shoppingViewModel.arrayPurchaseDate[counter]
                shoppingViewModel.expiryDate = shoppingViewModel.arrayExpiryDate[counter]
                shoppingViewModel.store = shoppingViewModel.arrayStore[counter]
                print( shoppingViewModel.expiryDate, "TESST")
                
                //CREATE
                inventoryViewModel.readDataFromShopping(shopping: shopping, purchaseDate: shoppingViewModel.arrayPurchaseDate[counter], expiryDate: shoppingViewModel.arrayExpiryDate[counter], store: shoppingViewModel.arrayStore[counter])
            }
            counter += 1
        }
        isMovedToInventory = false
        shoppingViewModel.status = "move"
    }
    
    var body: some View {
        NavigationView {
            VStack {
                if shoppingViewModel.shoppingCount > 0 {
                    List {
                        ForEach(0..<shoppingViewModel.shopping.count) { i in
                            if shoppingViewModel.shoppingToBeMoved.contains(shoppingViewModel.shopping[i].id) {
                                ShoppingToInventoryListView(shopping: shoppingViewModel.shopping[i], expiryDate: $shoppingViewModel.arrayExpiryDate[i], purchaseDate: $shoppingViewModel.arrayPurchaseDate[i], store: $shoppingViewModel.arrayStore[i])
                                    .contentShape(Rectangle())
                            } else {
                                
                            }
                        }
                    }
                    .listStyle(InsetGroupedListStyle())
                }
            }
            .navigationBarTitle("Add to Inventory", displayMode: .inline)
            .navigationBarItems(
                leading:
                    Button(action: actionCancel, label: {
                        Text("Cancel")
                    }),
                trailing:
                    Button(action: actionDone, label: {
                        Text("Done")
                    })
            )
        }
        .onDisappear() {
            print("Dissappear")
            if shoppingViewModel.status == "move" {
                shoppingViewModel.deleteMovedShoppingList(ids: shoppingViewModel.shoppingToBeMoved)
                shoppingViewModel.shoppingToBeMoved = []
            }
        }
        
    }
}

//struct ShoppingToInventoryView_Previews: PreviewProvider {
//    static var previews: some View {
//        ShoppingToInventoryView()
//    }
//}
