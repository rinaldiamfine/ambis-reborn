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
    
    @State var presentSelectCategory: Bool = false
    @State var previewSelectedCategory = "Choose Category"
    @State var detailDisclaimer = ""
    
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
        previewSelectedCategory = category.imageString + " " + category.name
        detailDisclaimer = category.estimation
        shoppingViewModel.toShopping = [category.foodCategory]
        presentSelectCategory = false
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Name")) {
                    TextField("Name", text: $shoppingViewModel.name)
                }
                Section(header: Text("Total")) {
                    TextField("Qty", text: $shoppingViewModel.total)
                    TextField("Type", text: $shoppingViewModel.totalType)
                }
                Section(header: Text("Category")) {
                    Picker(selection: $shoppingViewModel.toShopping, label: Text(previewSelectedCategory)) {
                        ForEach(foodCategoryViewModel.foodCategories, id: \.id) {
                            category in InventoryCategoryListView(foodCategory: category, previewSelectedCategory: $previewSelectedCategory).contentShape(Rectangle())
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
                    if detailDisclaimer != "" {
                        HStack {
                            Spacer()
                            Text(detailDisclaimer)
                                .lineLimit(nil).contentShape(Rectangle())
                                .multilineTextAlignment(.center)
                                .font(.system(size: 14))
                                .foregroundColor(Color.init(UIColor.systemGreen))
                                .lineSpacing(/*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                                .padding(.top, 10).padding(.bottom, 10)
                            Spacer()
                        }
                    }
                }
            }
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
