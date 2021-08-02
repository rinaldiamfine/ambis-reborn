//
//  ShoppingToInventoryView.swift
//  ambis-reborn
//
//  Created by Muhammad Rizki Miftha Alhamid on 7/15/21.
//

import SwiftUI
import CoreData
import UserNotifications

struct ShoppingToInventoryView: View {
    @ObservedObject var inventoryViewModel = InventoryViewModel()
    @ObservedObject var shoppingViewModel = ShoppingViewModel()
    @ObservedObject var foodCategoryViewModel = FoodCategoryViewModel()
    
    //@State var isShowDetail = false
    
    @Binding var isMovedToInventory: Bool
    @State var isShowPickerStore = false
    @State var selectedArrayShowPicker = 0
    
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
                
                //CREATE
                inventoryViewModel.readDataFromShopping(shopping: shopping, purchaseDate: shoppingViewModel.arrayPurchaseDate[counter], expiryDate: shoppingViewModel.arrayExpiryDate[counter], store: shoppingViewModel.arrayStore[counter])
                
                //ADD Notification
                Notification.instance.sendNotification(itemName: shopping.name, reminderDate: shoppingViewModel.expiryDate)
            }
            counter += 1
        }
        isMovedToInventory = false
        shoppingViewModel.status = "move"
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    if shoppingViewModel.shoppingCount > 0 {
                        List {
                            ForEach(0..<shoppingViewModel.shopping.count) { i in
                                if shoppingViewModel.shoppingToBeMoved.contains(shoppingViewModel.shopping[i].id) {
                                    ShoppingToInventoryListView(shopping: shoppingViewModel.shopping[i], expiryDate: $shoppingViewModel.arrayExpiryDate[i], purchaseDate: $shoppingViewModel.arrayPurchaseDate[i], store: $shoppingViewModel.arrayStore[i], selectedArrayShowPicker: $selectedArrayShowPicker, isShowPickerStore: $isShowPickerStore, counterList: i)
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
                                .font(.system(.callout, design: .rounded))
                        }),
                    trailing:
                        Button(action: actionDone, label: {
                            Text("Done")
                                .font(.system(.callout, design: .rounded))
                        })
                )
                
                ShoppingModalStore(isShowPickerStore: $isShowPickerStore, shoppingViewModel: shoppingViewModel, selectedArrayShowPicker: $selectedArrayShowPicker)
            }
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

struct ShoppingModalStore: View {
    @Binding var isShowPickerStore: Bool
    @ObservedObject var shoppingViewModel: ShoppingViewModel
    @Binding var selectedArrayShowPicker: Int
    var storeAvailable = AppGlobalData.generateDataStore()
    
    var body: some View {
        VStack {
            Spacer()
            VStack(spacing: 15) {
                HStack {
                    Picker("", selection: $shoppingViewModel.arrayStore[selectedArrayShowPicker]) {
                        ForEach(storeAvailable, id: \.self.name) {
                            Text($0.name)
                                .font(.system(.title3, design: .rounded))
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .background(Color(.systemBackground))
                }
                .cornerRadius(15)
                
                Button {
                    isShowPickerStore.toggle()
                } label: {
                    Spacer()
                    Text("Close")
                        .font(.system(size: 18, design: .rounded))
                        .foregroundColor(Color("BrandColor"))
                        .bold()
                    Spacer()
                }
                .frame(width: UIScreen.screenWidth - 30, height: 50, alignment: .center)
                .background(Color(.systemBackground))
                .cornerRadius(15)
            }
            .padding(.bottom, (UIApplication.shared.windows.last?.safeAreaInsets.bottom)! + 10)
            .padding(.horizontal)
            .padding(.top, 15)
            .background(Color.clear)
            .cornerRadius(25)
            .offset(y: isShowPickerStore ? 0 : UIScreen.main.bounds.height)
        }.background(isShowPickerStore ? Color.black.opacity(0.7) : Color.clear).edgesIgnoringSafeArea(.all)
        .edgesIgnoringSafeArea(.bottom)
    }
}
