//
//  InventoryFormEditView.swift
//  ambis-reborn
//
//  Created by Rinaldi LNU on 14/07/21.
//

import SwiftUI

struct InventoryFormEditView: View {
    @ObservedObject var inventoryViewModel: InventoryViewModel
    @ObservedObject var foodCategoryViewModel: FoodCategoryViewModel
    
    @Binding var isPresented: Bool
    @Binding var status: String
    @Binding var selectedIndex: Int
    
    @State var presentSelectCategory: Bool = false
    @State var previewSelectedCategory = "Choose Category"
    @State var detailDisclaimer = ""
    @State var expiryEstimation: Int = 0
    @State private var textQty = "Total "
    
    func prepareData() {
        //EDIT MODE - AUTO FILL TEXTFIELD DATA
//        inventoryViewModel.prepareDataEdit(index: selectedIndex)
        let inventorySelected = inventoryViewModel.inventory[selectedIndex]
        previewSelectedCategory = String(inventorySelected.foodCategory.imageString ?? "") + " " + String(inventorySelected.foodCategory.name!)
        detailDisclaimer = inventoryViewModel.inventory[selectedIndex].foodCategory.estimation!
    }
    
    func actionDone() {
        //EDIT ITEM
        let inventory = inventoryViewModel.inventory[selectedIndex]
//        inventoryViewModel.editData(inventory)
//        inventoryViewModel.getData()
        //SET NOTIF
        Notification.instance.sendNotification(inventId: inventoryViewModel.inventoryId.uuidString, itemName: inventoryViewModel.name, reminderDate: inventoryViewModel.expiryDate)
        //POP VIEW
        isPresented = false
    }
    
    func actionCancel() {
//        inventoryViewModel.resetData()
        //POP VIEW
        isPresented = false
    }
    
    func categoryOnTap(category: FoodCategoryModel) {
        previewSelectedCategory = category.imageString + " " + category.name
        detailDisclaimer = category.estimation
//        inventoryViewModel.toInventory = [category.foodCategory]
        inventoryViewModel.expiryDate = Calendar.current.date(byAdding: .day, value: Int(category.expiryEstimation), to: inventoryViewModel.purchaseDate)!
        expiryEstimation = Int(category.expiryEstimation)
        presentSelectCategory = false
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Product Name")) {
                    TextField("Name", text: $inventoryViewModel.name)
                }
                Section(header: Text("Total Product")) {
                    TextField("Qty", text: $inventoryViewModel.total)
                    TextField("Type", text: $inventoryViewModel.totalType)
                }
//                Section(header: Text("Product Category")) {
//                    Picker(selection: $inventoryViewModel.toInventory, label: Text(previewSelectedCategory)) {
//                        ForEach(foodCategoryViewModel.foodCategories, id:\.id) { category in
//                            InventoryCategoryListView(foodCategory: category, previewSelectedCategory: $previewSelectedCategory)
//                                .contentShape(Rectangle())
//                                .onTapGesture {
//                                    categoryOnTap(category: category)
//                                }
//                        }
//                    }
//                }
                Section(header: Text("Date Information")) {
                    DatePicker("Buy", selection: Binding<Date> (
                        get: { inventoryViewModel.purchaseDate },
                        set: { inventoryViewModel.purchaseDate = $0
                            if inventoryViewModel.expiryDate < $0 {
                                inventoryViewModel.expiryDate = $0
                            }
                            inventoryViewModel.expiryDate = Calendar.current.date(byAdding: .day, value: expiryEstimation, to: $0)!
                        }), displayedComponents: .date)
                    DatePicker("Expiry", selection: $inventoryViewModel.expiryDate, in: inventoryViewModel.purchaseDate..., displayedComponents: .date)
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
            .navigationBarTitle("Edit Product", displayMode: .inline)
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
            .onAppear(perform: {
                prepareData()
            })
//            .onDisappear(perform: {
//                prepareData()
//            })
        }
    }
}
