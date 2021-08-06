//
//  ShoppingFormView.swift
//  ambis-reborn
//
//  Created by Muhammad Rizki Miftha Alhamid on 7/14/21.
//

import SwiftUI
import Combine

struct ShoppingFormView: View {
    @ObservedObject var shoppingViewModel = ShoppingViewModel()
    @StateObject var foodCategoryViewModel = FoodCategoryViewModel()
    
    @Binding var isPresented: Bool
    
    @State private var showingActionSheet = false
    @State private var isShowPickerType = false
    @State private var characterLimit = 30
    
    var typeAvailable = AppGlobalData.generateDataType()
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
    }
    
    func categoryOnTap(category: FoodCategoryModel) {
        shoppingViewModel.previewSelectedCategory = category.imageString + " " + category.name
        shoppingViewModel.detailDisclaimer = category.estimation
        shoppingViewModel.toShopping = [category.foodCategory]
    }
    
    func limitText(_ upper: Int) {
        if shoppingViewModel.name.count > upper {
            shoppingViewModel.name = String(shoppingViewModel.name.prefix(upper))
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Form {
                    Section(header: Text("Product Name")
                                .font(.system(.caption, design: .rounded))) {
                        TextField("E.g. Chicken Wings", text: $shoppingViewModel.name)
                            .onReceive(Just(shoppingViewModel.name)) { _ in
                                limitText(characterLimit) }
                            .font(.system(.callout, design: .rounded))
                    }
                    Section(header: Text("Total Product")
                                .font(.system(.caption, design: .rounded))) {
                        TextField("Quantity", text: $shoppingViewModel.total)
                            .keyboardType(.decimalPad)
                            .font(.system(.callout, design: .rounded))
                        HStack {
                            Text("Type")
                                .font(.system(.callout, design: .rounded))
                            Spacer()
                            Text(shoppingViewModel.totalType)
                                .font(.system(.callout, design: .rounded))
                            Image(systemName: "chevron.right")
                                .font(.system(size: 13, weight: .bold))
                                .foregroundColor(Color.init(UIColor.systemGray2))
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            isShowPickerType.toggle()
                        }
                    }
                    Section(header: Text("Product Category")
                                .font(.system(.caption, design: .rounded))) {
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
                .navigationBarTitle(shoppingViewModel.status == "create" ? "Add Product" : "Edit Product", displayMode: .inline)
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
                
                ShoppingModalTotalType(isShowPickerType: $isShowPickerType, shoppingViewModel: shoppingViewModel)
            }
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

struct ShoppingModalTotalType: View {
    @Binding var isShowPickerType: Bool
    @ObservedObject var shoppingViewModel: ShoppingViewModel
    var typeAvailable = AppGlobalData.generateDataType()
    
    var body: some View {
        VStack {
            Spacer()
            VStack(spacing: 15) {
                HStack {
                    Picker("", selection: $shoppingViewModel.totalType) {
                        ForEach(typeAvailable, id: \.self.name) {
                            Text($0.name)
                                .font(.system(.title3, design: .rounded))
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .background(Color(.systemBackground))
                }
                .cornerRadius(15)
                
//                Button {
//                    isShowPickerType.toggle()
//                } label: {
//                    Spacer()
//                    Text("Close")
//                        .font(.system(size: 18, design: .rounded))
//                        .foregroundColor(Color("BrandColor"))
//                        .bold()
//                    Spacer()
//                }
//                .frame(width: UIScreen.screenWidth - 30, height: 50, alignment: .center)
//                .background(Color(.systemBackground))
//                .cornerRadius(15)
            }
            .padding(.bottom, (UIApplication.shared.windows.last?.safeAreaInsets.bottom)! + 10)
            .padding(.horizontal)
            .padding(.top, 15)
            .background(Color.clear)
            .cornerRadius(25)
            .offset(y: isShowPickerType ? 0 : UIScreen.main.bounds.height)
        }.background(isShowPickerType ? Color.black.opacity(0.7) : Color.clear).edgesIgnoringSafeArea(.all)
        .edgesIgnoringSafeArea(.bottom)
        .onTapGesture {
            isShowPickerType.toggle()
        }
    }
}
