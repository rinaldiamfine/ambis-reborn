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
    
    @Binding var shoppingToBeMoved: [NSManagedObjectID]
    @Binding var isMovedToInventory: Bool
    @Binding var arrayExpiryDate: [Date]
    @Binding var arrayPurchaseDate: [Date]
    @Binding var arrayStore: [String]
    
    @State var indexToRemove: [Int] = []
    
    func actionCancel() {
        //shoppingViewModel.resetData()
        //POP VIEW
        isMovedToInventory = false
    }
    
    func actionDone() {
        var counter = 0
        for shopping in shoppingViewModel.shopping {
            if shoppingToBeMoved.contains(shopping.id) {
                shoppingViewModel.purchaseDate = arrayPurchaseDate[counter]
                shoppingViewModel.expiryDate = arrayExpiryDate[counter]
                shoppingViewModel.store = arrayStore[counter]
                print( shoppingViewModel.expiryDate, "TESST")
                
                //CREATE
                inventoryViewModel.readDataFromShopping(shopping: shopping, purchaseDate: arrayPurchaseDate[counter], expiryDate: arrayExpiryDate[counter], store: arrayStore[counter])
                
//                shoppingViewModel.deleteItemByContextMenu(index: shopping)
//                shoppingToBeMoved.remove(at: counter)
//                arrayPurchaseDate.remove(at: counter)
//                arrayExpiryDate.remove(at: counter)
//                arrayStore.remove(at: counter)
                indexToRemove.append(counter)
            }
            counter += 1
        }
        isMovedToInventory = false
    }
    
    var body: some View {
        NavigationView {
            VStack {
                if shoppingViewModel.shoppingCount > 0 {
                    List {
                        ForEach(0..<shoppingViewModel.shopping.count) { i in
                            if shoppingToBeMoved.contains(shoppingViewModel.shopping[i].id) {
                                ShoppingToInventoryListView(shopping: shoppingViewModel.shopping[i], expiryDate: $arrayExpiryDate[i], purchaseDate: $arrayPurchaseDate[i], store: $arrayStore[i])
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
        
    }
}

//struct ShoppingToInventoryView_Previews: PreviewProvider {
//    static var previews: some View {
//        ShoppingToInventoryView()
//    }
//}
