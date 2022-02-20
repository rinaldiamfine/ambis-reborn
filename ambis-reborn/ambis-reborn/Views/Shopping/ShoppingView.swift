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
    @StateObject var shoppingViewModel = ShoppingViewModel()
    @StateObject var foodCategoryViewModel = FoodCategoryViewModel()
    
    @State var isMovedToInventory = false
    
    func getIconName() -> Image {
        return Image("TabBarShopping")
    }
    func getIconNameActive() -> Image {
        return Image("TabBarShoppingActive")
    }
    func gettabName() -> Text {
        return Text("Shopping List")
    }
    
    func setArrayDate() {
        for i in 0..<shoppingViewModel.shopping.count {
            shoppingViewModel.arrayPurchaseDate.append(Date())
            shoppingViewModel.arrayExpiryDate.append(Date())
            shoppingViewModel.arrayStore.append("Fridge")
            if shoppingViewModel.shoppingToBeMoved.contains(shoppingViewModel.shopping[i].id) {
                shoppingViewModel.arrayPurchaseDate[i] = shoppingViewModel.shopping[i].purchaseDate
                if shoppingViewModel.shopping[i].shopping.toFoodCategory != nil {
                    shoppingViewModel.arrayExpiryDate[i] =  Calendar.current.date(byAdding: .day, value: Int(shoppingViewModel.shopping[i].foodCategory.expiryEstimation), to: Date())!
                }
            }
        }
    }
        
    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                if shoppingViewModel.shoppingCount > 0 {
                    ZStack {
                        ScrollView {
                            Text("")
//                            VStack {
//                                SpaceView()
//                            }.background(
//                                Rectangle()
//                                    .fill(LinearGradient(gradient: .init(colors: [Color("Gradient1"), Color("Gradient2")]), startPoint: .init(x: 0, y: 0.1), endPoint: .init(x: 0, y: 1)))
//                            )
                            
                            Section {
                                ForEach(shoppingViewModel.shopping, id:\.id) {
                                    shopping in
                                    ShoppingListView(shopping: shopping, shoppingViewModel: shoppingViewModel)
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
                                            if shoppingViewModel.shoppingToBeMoved.contains(shopping.id) {
                                                shoppingViewModel.shoppingToBeMoved = shoppingViewModel.shoppingToBeMoved.filter{$0 != shopping.id}
                                            } else {
                                                shoppingViewModel.shoppingToBeMoved.append(shopping.id)
                                            }
                                        }
                                        .padding(.horizontal)
                                }
                                
                            }
                            VStack {
                                SpaceView()
                            }
                        }
                        .frame(width: UIScreen.screenWidth)
                        .background(Color("AppBackground"))
                        
                        
                        VStack {
                            Spacer()
                            if !shoppingViewModel.shoppingToBeMoved.isEmpty {
                                Button {
                                    isMovedToInventory = true
                                    setArrayDate()
                                } label: {
                                    Text("Move to inventory")
                                        .font(.system(size: 18, design: .rounded))
                                        .foregroundColor(Color("BackgroundInverse"))
                                }
                                .frame(width: UIScreen.screenWidth - 30, height: 50, alignment: .center)
                                .background(Color("BrandColor"))
                                .cornerRadius(15)
                                .padding(.horizontal, 15)
                                .padding(.bottom, 15)
                            } else {
                                Button {
                                    //Action
                                } label: {
                                    Text("Move to inventory")
                                        .font(.system(size: 18, design: .rounded))
                                        .foregroundColor(Color("BackgroundInverse"))
                                }
                                .frame(width: UIScreen.screenWidth - 30, height: 50, alignment: .center)
                                .background(Color.init(.systemGray))
                                .cornerRadius(15)
                                .padding(.horizontal, 15)
                                .padding(.bottom, 15)
                            }
                        }
                        
                        
                    }
                    
                } else {
                    Spacer()
                    ShoppingListEmptyView()
                        .onTapGesture {
                            shoppingViewModel.isPresented = true
                        }
                    Spacer()
                }
            }
            .navigationBarTitle("Shopping List")
            .navigationBarItems(
                trailing: Button(action: shoppingViewModel.prepareCreateData, label: {
                    Image(systemName: "plus")
                        .imageScale(.large)
                        .foregroundColor(Color("BackgroundInverse"))
                }).contentShape(Circle())
            )
        }
        .sheet(isPresented: $shoppingViewModel.isPresented) {
            ShoppingFormView(shoppingViewModel: shoppingViewModel, foodCategoryViewModel: foodCategoryViewModel, isPresented: $shoppingViewModel.isPresented)
        }
        .sheet(isPresented: $isMovedToInventory, content: {
            ShoppingToInventoryView(shoppingViewModel: shoppingViewModel, foodCategoryViewModel: foodCategoryViewModel, isMovedToInventory: $isMovedToInventory)
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

struct ShoppingView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingView()
    }
}
