//
//  ShoppingView.swift
//  ambis-reborn
//
//  Created by Muhammad Rizki Miftha Alhamid on 7/14/21.
//

import SwiftUI
import UIKit
import CoreData

struct ShoppingView: View {
    @StateObject private var shoppingViewModel = ShoppingViewModel()
    @StateObject private var foodCategoryViewModel = FoodCategoryViewModel()
    
    @State var isMovedToInventory = false
    
    func getIconName() -> Image {
        return Image(systemName: "bag.fill")
    }
    func gettabName() -> Text {
        return Text("Shopping List")
    }
        
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                if shoppingViewModel.shoppingCount > 0 {
                    List {
                        ForEach(shoppingViewModel.shopping, id:\.id) {
                            shopping in ShoppingListView(shopping: shopping)
                                .contextMenu {
                                    Button {
                                        
                                    } label: {
                                        Label("Update Inventory", systemImage: "square.and.pencil")
                                    }
                                    
                                    Divider()
                                    Button {
                                        shoppingViewModel.deleteItemByContextMenu(index: shopping)
                                    } label: {
                                        Text("Remove")
                                        Image(systemName: "trash")
                                    }
                                }
                            
                        }
                    }
                    .listStyle(InsetGroupedListStyle())
                    
                    //Spacer()
                    
                    Button {
                        isMovedToInventory = true
                    } label: {
                        Text("Move all to inventory")
                            .font(.system(size: 18))
                            .foregroundColor(.white)
                    }
                    .frame(width: 350, height: 50, alignment: .center)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding()

                    
                } else {
                    ShoppingListEmptyView()
                }
            }
            .navigationBarTitle("Shopping List")
            .navigationBarItems(trailing: Button(action: shoppingViewModel.prepareCreateData, label: {
                Image(systemName: "plus")
            }))
        }
        .sheet(isPresented: $shoppingViewModel.isPresented) {
            ShoppingFormView(shoppingViewModel: self.shoppingViewModel, foodCategoryViewModel: self.foodCategoryViewModel, isPresented: $shoppingViewModel.isPresented)
        }
        .sheet(isPresented: $isMovedToInventory, content: {
            ShoppingToInventoryView(shoppingViewModel: self.shoppingViewModel, foodCategoryViewModel: self.foodCategoryViewModel, isShowDetail: false, activeShopping: [])
        })
        .onAppear(perform: {
            shoppingViewModel.loadList()
            foodCategoryViewModel.getData()
        })
        .onDisappear {
            shoppingViewModel.loadList()
            foodCategoryViewModel.getData()
        }
    }
    
    
}

//struct ShoppingView_Previews: PreviewProvider {
//    static var previews: some View {
//        ShoppingView()
//    }
//}
