//
//  InventoryFormView.swift
//  ambis-reborn
//
//  Created by Rinaldi LNU on 10/07/21.
//

import SwiftUI
import UserNotifications
import Combine

struct InventoryFormView: View {
    @ObservedObject var inventoryViewModel: InventoryViewModel = InventoryViewModel()
    @ObservedObject var foodCategoryViewModel: FoodCategoryViewModel = FoodCategoryViewModel()
    
    @Binding var isPresented: Bool
    @Binding var dropCloseModal: Bool
    var formName = "Add Inventory"
    
    @State private var showingActionSheet = false
    @State private var isShowPickerType = false
    @State private var characterLimit = 30
    
    @State private var offset = CGSize.zero
    
    var typeAvailable = AppGlobalData.generateDataType()
    
    var storeAvailable = AppGlobalData.generateDataStore()
    
    
    func actionDone() {
        if inventoryViewModel.status == "edit" {
            inventoryViewModel.editData(inventoryViewModel.inventory[inventoryViewModel.selectedIndex])
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "inventoryUpdated"), object: inventoryViewModel)
        } else {
            inventoryViewModel.saveData()
        }
        inventoryViewModel.getData()
        Notification.instance.sendNotification(itemName: inventoryViewModel.name, reminderDate: inventoryViewModel.expiryDate)
        inventoryViewModel.resetData()
        isPresented = false
    }
    
    func actionCancel() {
        showingActionSheet.toggle()
    }
    
    func categoryOnTap(category: FoodCategoryModel) {
        inventoryViewModel.previewSelectedCategory = category.imageString + " " + category.name
        inventoryViewModel.detailDisclaimer = category.estimation
        inventoryViewModel.toInventory = [category.foodCategory]
        inventoryViewModel.expiryDate = Calendar.current.date(byAdding: .day, value: Int(category.expiryEstimation), to: inventoryViewModel.purchaseDate)!
        inventoryViewModel.expiryEstimation = Int(category.expiryEstimation)
    }
    
    func limitText(_ upper: Int) {
        if inventoryViewModel.name.count > upper {
            inventoryViewModel.name = String(inventoryViewModel.name.prefix(upper))
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Product Name")) {
                    TextField("E.g. Chicken Wings", text: $inventoryViewModel.name)
                        .onReceive(Just(inventoryViewModel.name)) { _ in limitText(characterLimit) }
                }
                Section(header: Text("Total Product")) {
                    TextField("Quantity", text: $inventoryViewModel.total)
                        .keyboardType(.decimalPad)
                    HStack {
                        Text("Type")
                        Spacer()
                        Text(inventoryViewModel.totalType)
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
                        Picker("", selection: $inventoryViewModel.totalType) {
                            ForEach(typeAvailable, id: \.self.name) {
                                Text($0.name)
                            }
                        }.pickerStyle(WheelPickerStyle())
                    }
                }
                Section(header: Text("Product Category")) {
                    Picker(selection: $inventoryViewModel.toInventory, label: Text(inventoryViewModel.previewSelectedCategory)) {
                        ForEach(inventoryViewModel.foodCategories, id:\.id) { category in
                            InventoryCategoryListView(foodCategory: category, previewSelectedCategory: $inventoryViewModel.previewSelectedCategory)
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    categoryOnTap(category: category)
                                }
                        }
                    }
                }
                
                Section(header: Text("Storing Type")) {
                    Picker("", selection: $inventoryViewModel.store) {
                        ForEach(storeAvailable, id: \.self.name) {
                            Text($0.name)
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                    if inventoryViewModel.detailDisclaimer != "" {
                        HStack {
                            Spacer()
                            Text(inventoryViewModel.detailDisclaimer)
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
                
                Section(header: Text("Date Information")) {
                    DatePicker("Buy", selection: Binding<Date> (
                        get: { inventoryViewModel.purchaseDate },
                        set: { inventoryViewModel.purchaseDate = $0
                            if inventoryViewModel.expiryDate < $0 {
                                inventoryViewModel.expiryDate = $0
                            }
                            inventoryViewModel.expiryDate = Calendar.current.date(byAdding: .day, value: inventoryViewModel.expiryEstimation, to: $0)!
                        }), displayedComponents: .date)
                    DatePicker("Expiry", selection: $inventoryViewModel.expiryDate, in: inventoryViewModel.purchaseDate..., displayedComponents: .date)
                }
//                Section(header: Text("Disclaimer")) {
//                    Text("The numbers provided below are rough estimates on how long an item in the category you have chosen can last in different situations.\n\nThe best indicators on whether a food has expired is to look for signs of spoilage, such as foul odor, fungi and mold growth, and sour taste")
//                        .font(.system(size: 14))
//                        .foregroundColor(.gray)
//                        .padding(.top, 10).padding(.bottom, 10)
//                }
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
            .gesture(
                DragGesture()
                    .onChanged({ gesture in
                        self.offset = gesture.translation
                        if gesture.translation.height > 5 {
                            self.offset = .zero
                            actionCancel()
                        } else {
                            self.offset = .zero
                        }
                    })
                    .onEnded { gesture in
                        self.offset = .zero
                    }
            )
        }
        .gesture(
            DragGesture()
                .onChanged({ gesture in
                    self.offset = gesture.translation
                    if gesture.translation.height > 50 {
                        self.offset = .zero
                        actionCancel()
                    } else {
                        self.offset = .zero
                    }
                })
                .onEnded { gesture in
                    self.offset = .zero
                }
        )
        .offset(x: 0, y: offset.height)
        //DRAG DROP
        .actionSheet(isPresented: $dropCloseModal) {
            ActionSheet(
                title: Text("Changes you made may not be saved."),
                buttons: [
                    .destructive(Text("Discard Changes")) {
                        isPresented = false
                        inventoryViewModel.resetData()
                    },
                    .cancel()
                ]
            )
        }
        // CANCEL BUTTON
        .actionSheet(isPresented: $showingActionSheet) {
            ActionSheet(
                title: Text("Changes you made may not be saved."),
                buttons: [
                    .destructive(Text("Discard Changes")) {
                        isPresented = false
                        inventoryViewModel.resetData()
                    },
                    .cancel()
                ]
            )
        }
    }
}
