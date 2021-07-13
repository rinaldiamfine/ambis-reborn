//
//  InventoryFormView.swift
//  ambis-reborn
//
//  Created by Rinaldi LNU on 10/07/21.
//

import SwiftUI
import UserNotifications

struct InventoryFormView: View {
    @ObservedObject var inventoryViewModel: InventoryViewModel
    @Binding var isPresented: Bool
    @Binding var status: String
    @Binding var selectedIndex: Int
    @State var previewSelectedCategory = "Choose Category"
    @State var detailDisclaimer = ""
    @ObservedObject var foodCategoryViewModel: FoodCategoryViewModel
    @State var inventorySelected: InventoryModel
    
    func prepareData() {
        if status == "edit" {
            inventoryViewModel.prepareDataEdit(index: selectedIndex)
            self.previewSelectedCategory = inventoryViewModel.inventory[selectedIndex].foodCategory.imageString! + " " + inventoryViewModel.inventory[selectedIndex].foodCategory.name!
            self.detailDisclaimer = inventoryViewModel.inventory[selectedIndex].foodCategory.estimation!
        }
    }
    func actionDone() {
        if status == "create" {
            inventoryViewModel.saveData()
            inventoryViewModel.getData()
        } else {
            inventoryViewModel.getData()
        }
        Notification.instance.sendNotification(itemName: inventoryViewModel.name, reminderDate: inventoryViewModel.expiryDate)
        isPresented = false
    }
    func actionCancel() {
        isPresented = false
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
                Section(header: Text("Product Category")) {
                    Picker(selection: $inventoryViewModel.toInventory, label: Text(previewSelectedCategory)) {
                        ForEach(foodCategoryViewModel.foodCategories, id:\.id) {
                                category in
                            CategoryListView(foodCategory: category)
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    self.previewSelectedCategory = category.imageString + " " + category.name
                                    self.detailDisclaimer = category.estimation
                                    inventoryViewModel.toInventory = [category.foodCategory]
                                    inventoryViewModel.expiryDate = Calendar.current.date(byAdding: .day, value: Int(category.expiryEstimation), to: inventoryViewModel.purchaseDate)!
                                }
                        }
                    }
                }
                Section(header: Text("Date Information")) {
                    DatePicker("Buy", selection: $inventoryViewModel.purchaseDate, displayedComponents: .date)
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
            .onAppear(perform: {
                prepareData()
            })
        }
    }
}
