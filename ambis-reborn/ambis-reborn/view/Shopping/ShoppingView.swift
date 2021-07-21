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
    @ObservedObject var shoppingViewModel = ShoppingViewModel()
    @ObservedObject var foodCategoryViewModel = FoodCategoryViewModel()
    
    @State var isMovedToInventory = false
    @State var shoppingToBeMoved: [NSManagedObjectID] = []
    
    @State var arrayStore: [String] = []
    @State var arrayPurchaseDate: [Date] = []
    @State var arrayExpiryDate: [Date] = []
    
    func getIconName() -> Image {
        return Image(systemName: "bag.fill")
    }
    func gettabName() -> Text {
        return Text("Shopping List")
    }
    
    func setArrayDate() {
        for i in 0..<shoppingViewModel.shopping.count {
            arrayPurchaseDate.append(Date())
            arrayExpiryDate.append(Date())
            arrayStore.append("Fridge")
            if shoppingToBeMoved.contains(shoppingViewModel.shopping[i].id) {
                arrayPurchaseDate[i] = shoppingViewModel.shopping[i].purchaseDate
                arrayExpiryDate[i] =  Calendar.current.date(byAdding: .day, value: Int(shoppingViewModel.shopping[i].foodCategory.expiryEstimation), to: Date())!
            }
        }
    }
        
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                if shoppingViewModel.shoppingCount > 0 {
                    ZStack {
                        List {
                            ForEach(shoppingViewModel.shopping, id:\.id) {
                                shopping in ShoppingListView(shopping: shopping, shoppingViewModel: shoppingViewModel, shoppingToBeMoved: $shoppingToBeMoved)
                                    .contextMenu {
                                        Button {
                                            shoppingViewModel.editData(index: shopping)
                                            print(shopping)
                                        } label: {
                                            Label("Update Item", systemImage: "square.and.pencil")
                                        }
                                        
                                        Divider()
                                        Button {
                                            shoppingViewModel.deleteItemByContextMenu(index: shopping)
                                        } label: {
                                            Text("Remove")
                                            Image(systemName: "trash")
                                        }
                                    }
                                    .contentShape(Rectangle())
                                    .onTapGesture {
                                        if shoppingToBeMoved.contains(shopping.id) {
                                            shoppingToBeMoved = shoppingToBeMoved.filter{$0 != shopping.id}
                                        } else {
                                            shoppingToBeMoved.append(shopping.id)
                                        }
                                    }
                                
                            }
                        }
                        .listStyle(InsetGroupedListStyle())
                        VStack {
                            Spacer()
                            
                            if !shoppingToBeMoved.isEmpty {
                                Button {
                                    isMovedToInventory = true
                                    //shoppingToBeMoved
                                    setArrayDate()
                                } label: {
                                    Text("Move to inventory")
                                        .font(.system(size: 18))
                                        .foregroundColor(.white)
                                }
                                .frame(width: 350, height: 50, alignment: .center)
                                .background(Color.blue)
                                .cornerRadius(10)
                                .padding()
                            }
                        }
                    }
                    
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
            ShoppingFormView(shoppingViewModel: shoppingViewModel, foodCategoryViewModel: foodCategoryViewModel, isPresented: $shoppingViewModel.isPresented)
        }
        .sheet(isPresented: $isMovedToInventory, content: {
            //
            ShoppingToInventoryView(shoppingViewModel: shoppingViewModel, foodCategoryViewModel: foodCategoryViewModel, shoppingToBeMoved: $shoppingToBeMoved, isMovedToInventory: $isMovedToInventory, arrayExpiryDate: $arrayExpiryDate, arrayPurchaseDate: $arrayPurchaseDate, arrayStore: $arrayStore)
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
