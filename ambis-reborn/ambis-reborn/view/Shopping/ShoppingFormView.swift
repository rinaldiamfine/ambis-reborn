//
//  ShoppingFormView.swift
//  ambis-reborn
//
//  Created by Muhammad Rizki Miftha Alhamid on 7/14/21.
//

import SwiftUI

struct ShoppingFormView: View {
    @ObservedObject var shoppingViewModel = ShoppingViewModel()
    @StateObject var foodCategoryViewModel = FoodCategoryViewModel()
    
    @Binding var isPresented: Bool
    
    @State private var showingActionSheet = false
    
    var typeAvailable = AppGlobalData.generateDataType()
    @State private var isShowPickerType = false
    
    func actionDone() {
        if shoppingViewModel.status == "edit" {
            //EDIT
            shoppingViewModel.editData(shoppingViewModel.shopping[shoppingViewModel.selectedIndex])
        } else {
            //CREATE
            shoppingViewModel.saveData()
        }
        
        shoppingViewModel.getData()
        shoppingViewModel.resetData()
        //POP VIEW
        isPresented = false
    }
    
    func actionCancel() {
        showingActionSheet.toggle()
        print(shoppingViewModel.totalType, "Test 1")
    }
    
    func categoryOnTap(category: FoodCategoryModel) {
        shoppingViewModel.previewSelectedCategory = category.imageString + " " + category.name
        shoppingViewModel.detailDisclaimer = category.estimation
        shoppingViewModel.toShopping = [category.foodCategory]
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Product Name")) {
                    TextField("E.g. Chicken Wings", text: $shoppingViewModel.name)
                }
                Section(header: Text("Total Product")) {
                    TextField("Quantity", text: $shoppingViewModel.total)
                        .keyboardType(.decimalPad)
                    HStack {
                        Text("Type")
                        Spacer()
                        Text(shoppingViewModel.totalType)
                        if isShowPickerType {
                            Image(systemName: "chevron.down")
                                .font(.system(size: 12, weight: .bold))
                                .foregroundColor(Color.init(UIColor.systemGray2))
                        } else {
                            Image(systemName: "chevron.right")
                                .font(.system(size: 13, weight: .bold))
                                .foregroundColor(Color.init(UIColor.systemGray2))
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        isShowPickerType.toggle()
                    }
                    
                    if isShowPickerType {
                        Picker("", selection: $shoppingViewModel.totalType) {
                            ForEach(typeAvailable, id: \.self.name) {
                                Text($0.name)
                            }
                        }.pickerStyle(WheelPickerStyle())
                    }
                }
                Section(header: Text("Product Category")) {
                    Picker(selection: $shoppingViewModel.toShopping, label: Text(shoppingViewModel.previewSelectedCategory)) {
                        ForEach(foodCategoryViewModel.foodCategories, id: \.id) {
                            category in InventoryCategoryListView(foodCategory: category, previewSelectedCategory: $shoppingViewModel.previewSelectedCategory).contentShape(Rectangle())
                                .onTapGesture {
                                    categoryOnTap(category: category)
                                }
                        }
                    }
                }
            }
                .navigationBarTitle("Add Product", displayMode: .inline)
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
        .actionSheet(isPresented: $showingActionSheet) {
            ActionSheet(
                title: Text("Changes you made may not be saved"),
                buttons: [
                    .destructive(Text("Discard Changes")) {
                        isPresented = false
                        shoppingViewModel.resetData()
                    },
                    .cancel()
                ]
            )
        }
    }
}

//struct ShoppingFormView_Previews: PreviewProvider {
//    static var previews: some View {
//        ShoppingFormView()
//    }
//}
