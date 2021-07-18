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
    
    @State var isShowDetail = false
    @Binding var arrayExpiryDate: [Date]
    
    @Binding var shoppingToBeMoved: [NSManagedObjectID]
    
    
    func actionCancel() {
        
    }
    
    func actionDone() {
        var counter = 0
        for shopping in shoppingViewModel.shopping {
            if shoppingToBeMoved.contains(shopping.id) {
                print( shoppingViewModel.expiryDate, "TESST")
                inventoryViewModel.expiryDate = arrayExpiryDate[counter]
//                print(inventoryViewModel.purchaseDate, "LIST PURCH")
//                print(inventoryViewModel.expiryDate, "LIST EXp")
                
                //CREATE
//                inventoryViewModel.readDataFromShopping(shopping: shopping, expiryDate: inventoryViewModel.expiryDate)
            }
            counter += 1
        }
        
    }
    
    var body: some View {
        NavigationView {
            VStack {
                if shoppingViewModel.shoppingCount > 0 {
                    List {
                        ForEach(shoppingViewModel.shopping, id:\.id) { shopping in
                            if shoppingToBeMoved.contains(shopping.id) {
                                ShoppingToInventoryListView(shopping: shopping)
                                    .contentShape(Rectangle())
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
