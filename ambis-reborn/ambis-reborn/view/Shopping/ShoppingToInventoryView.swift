//
//  ShoppingToInventoryView.swift
//  ambis-reborn
//
//  Created by Muhammad Rizki Miftha Alhamid on 7/15/21.
//

import SwiftUI
import CoreData

struct ShoppingToInventoryView: View {
    @ObservedObject var shoppingViewModel = ShoppingViewModel()
    @ObservedObject var foodCategoryViewModel = FoodCategoryViewModel()
    
    @State var isShowDetail = false
    
    
    @State var activeShopping: [NSManagedObjectID]
    
    func actionCancel() {
        
    }
    func actionDone() {
        
    }
    
    var body: some View {
        NavigationView {
            VStack {
                if shoppingViewModel.shoppingCount > 0 {
                    List {
                        ForEach(shoppingViewModel.shopping, id:\.id) {
                            shopping in ShoppingToInventoryListView(shopping: shopping, testDate: Date(), activeShopping: $activeShopping)
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    if activeShopping.contains(shopping.id) {
                                       activeShopping = activeShopping.filter{$0 != shopping.id}
                                    } else {
                                        activeShopping.append(shopping.id)
                                    }
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
