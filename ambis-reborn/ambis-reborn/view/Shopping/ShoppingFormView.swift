//
//  ShoppingFormView.swift
//  ambis-reborn
//
//  Created by Muhammad Rizki Miftha Alhamid on 7/14/21.
//

import SwiftUI

struct ShoppingFormView: View {
    @ObservedObject var shoppingViewModel: ShoppingViewModel
    @ObservedObject var foodCategoryViewModel: FoodCategoryViewModel
    
    @Binding var isPresented: Bool
    
    @State private var showingActionSheet = false
    @State private var selection = "None"
    
    var typeAvailable = AppGlobalData.generateDataType()
    @State private var selectedType = "Kg"
    @State private var isShowPickerType = false
    
    func actionDone() {
        if shoppingViewModel.status == "create" {
            //CREATE ITEM
            shoppingViewModel.saveData()
        } else {
            //EDIT ITEM
        }
        
        shoppingViewModel.getData()
        shoppingViewModel.resetData()
        //POP VIEW
        isPresented = false
    }
    
    func actionCancel() {
        shoppingViewModel.resetData()
        //POP VIEW
        isPresented = false
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
                    TextField("Name", text: $shoppingViewModel.name)
                }
                Section(header: Text("Total Product")) {
                    TextField("Qty", text: $shoppingViewModel.total)
                        .keyboardType(.decimalPad)
                    
                    //TextField("Type", text: $shoppingViewModel.totalType)
                    HStack {
                        Text("Type")
                        Spacer()
                        Text(selectedType)
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
                        Picker("", selection: $selectedType) {
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
                
                Section(header: Text("Disclaimer")) {
                    Text("The numbers provided below are rough estimates on how long an item in the category you have chosen can last in different situations.\n\nThe best indicators on whether a food has expired is to look for signs of spoilage, such as foul odor, fungi and mold growth, and sour taste")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                        .padding(.top, 10).padding(.bottom, 10)
                }            }
            .navigationBarTitle("Add Shopping", displayMode: .inline)
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

//struct ShoppingFormView_Previews: PreviewProvider {
//    static var previews: some View {
//        ShoppingFormView()
//    }
//}
