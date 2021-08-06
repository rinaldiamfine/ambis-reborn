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
    @StateObject var foodCategoryViewModel: FoodCategoryViewModel = FoodCategoryViewModel()
    
    @Binding var isPresented: Bool
    @Binding var defaultFilter: String
    
    @State private var showingActionSheet = false
    @State private var isShowPickerType = false
    @State private var isShowPickerStore = false
    
    var navigationName = "Add Inventory"
    
    func actionDone() {
        if inventoryViewModel.status == "edit" {
            inventoryViewModel.editData(inventoryViewModel.inventory[inventoryViewModel.selectedIndex])
            defaultFilter = inventoryViewModel.inventory[inventoryViewModel.selectedIndex].store
        } else {
            inventoryViewModel.saveData()
            defaultFilter = inventoryViewModel.store
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
    
    
    var body: some View {
        NavigationView {
            ZStack {
                InventoryModalForm(inventoryViewModel: inventoryViewModel, showingActionSheet: $showingActionSheet, isShowPickerType: $isShowPickerType, isShowPickerStore: $isShowPickerStore)
                    .navigationBarTitle(inventoryViewModel.status == "edit" ? "Edit Inventory" : "Add Inventory", displayMode: .inline)
                .navigationBarItems(
                    leading: Button(action: actionCancel, label: {
                            Text("Cancel")
                                .font(.system(.callout, design: .rounded))
                                .accentColor(Color("BackgroundInverse"))}),
                    trailing: Button(action: actionDone, label: {
                            Text("Done")
                                .font(.system(.callout, design: .rounded))
                                .accentColor(Color("BackgroundInverse"))})
                )
                
                ModalTotalType(isShowPickerType: $isShowPickerType, inventoryViewModel: inventoryViewModel)
                ModalStore(isShowPickerStore: $isShowPickerStore, inventoryViewModel: inventoryViewModel)
                
            }
            .actionSheet(isPresented: $showingActionSheet) {
                ActionSheet(
                    title: Text("Changes you made may not be saved.").font(.system(.body, design: .rounded)),
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
}

struct InventoryModalForm: View {
    @ObservedObject var inventoryViewModel: InventoryViewModel
    @State private var characterLimit = 30
    
    @Binding var showingActionSheet: Bool
    @Binding var isShowPickerType: Bool
    @Binding var isShowPickerStore: Bool
    
    func limitText(_ upper: Int) {
        if inventoryViewModel.name.count > upper {
            inventoryViewModel.name = String(inventoryViewModel.name.prefix(upper))
        }
    }
    
    func categoryOnTap(category: FoodCategoryModel) {
        inventoryViewModel.previewSelectedCategory = category.imageString + " " + category.name
        inventoryViewModel.detailDisclaimer = category.estimation
        inventoryViewModel.toInventory = [category.foodCategory]
        inventoryViewModel.expiryDate = Calendar.current.date(byAdding: .day, value: Int(category.expiryEstimation), to: inventoryViewModel.purchaseDate)!
        inventoryViewModel.expiryEstimation = Int(category.expiryEstimation)
    }
    
    var body: some View {
        Form {
            Section(header: Text("Product Name")
                        .font(.system(.caption, design: .rounded))) {
                TextField("E.g. Chicken Wings", text: $inventoryViewModel.name)
                    .onReceive(Just(inventoryViewModel.name)) { _ in limitText(characterLimit) }
                    .font(.system(.callout, design: .rounded))
            }
            Section(header: Text("Total Product")
                        .font(.system(.caption, design: .rounded))) {
                TextField("Quantity", text: $inventoryViewModel.total)
                    .keyboardType(.decimalPad)
                    .font(.system(.callout, design: .rounded))
                HStack {
                    Text("Type")
                        .font(.system(.callout, design: .rounded))
                    Spacer()
                    Text(inventoryViewModel.totalType)
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
                Picker(selection: $inventoryViewModel.toInventory, label: Text(inventoryViewModel.previewSelectedCategory)
                        .font(.system(.callout, design: .rounded))) {
                    ForEach(inventoryViewModel.foodCategories, id:\.id) { category in
                        InventoryCategoryListView(foodCategory: category, previewSelectedCategory: $inventoryViewModel.previewSelectedCategory)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                categoryOnTap(category: category)
                            }
                            .navigationTitle("Food Category")
                    }
                }
                HStack {
                    Text("Storing Type")
                        .font(.system(.callout, design: .rounded))
                    Spacer()
                    Text(inventoryViewModel.store)
                        .font(.system(.callout, design: .rounded))
                        Image(systemName: "chevron.right")
                            .font(.system(size: 13, weight: .bold))
                            .foregroundColor(Color.init(UIColor.systemGray2))
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    isShowPickerStore.toggle()
                }
            }
            Section(header: Text("Date Information")
                        .font(.system(.caption, design: .rounded))) {
                DatePicker("Buy", selection: Binding<Date> (
                    get: { inventoryViewModel.purchaseDate },
                    set: { inventoryViewModel.purchaseDate = $0
                        if inventoryViewModel.expiryDate < $0 {
                            inventoryViewModel.expiryDate = $0
                        }
                        inventoryViewModel.expiryDate = Calendar.current.date(byAdding: .day, value: inventoryViewModel.expiryEstimation, to: $0)!
                    }), displayedComponents: .date)
                    .font(.system(.callout, design: .rounded))
                DatePicker("Expiry", selection: $inventoryViewModel.expiryDate, in: inventoryViewModel.purchaseDate..., displayedComponents: .date)
                    .font(.system(.callout, design: .rounded))
            }
        }
    }
}

struct ModalTotalType: View {
    @Binding var isShowPickerType: Bool
    @ObservedObject var inventoryViewModel: InventoryViewModel
    var typeAvailable = AppGlobalData.generateDataType()
    
    var body: some View {
        VStack {
            Spacer()
            VStack(spacing: 15) {
                HStack {
                    Picker("", selection: $inventoryViewModel.totalType) {
                        ForEach(typeAvailable, id: \.self.name) {
                            Text($0.name)
                                .font(.system(.title3, design: .rounded))
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .background(Color(.systemBackground))
                }
                .cornerRadius(15)
                
                
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

struct ModalStore: View {
    @Binding var isShowPickerStore: Bool
    @ObservedObject var inventoryViewModel: InventoryViewModel
    var storeAvailable = AppGlobalData.generateDataStore()
    
    var body: some View {
        VStack {
            Spacer()
            VStack(spacing: 15) {
                HStack {
                    Picker("", selection: $inventoryViewModel.store) {
                        ForEach(storeAvailable, id: \.self.name) {
                            Text($0.name)
                                .font(.system(.title3, design: .rounded))
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .background(Color(.systemBackground))
                }
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
        .onTapGesture {
            isShowPickerStore.toggle()
        }
    }
}
