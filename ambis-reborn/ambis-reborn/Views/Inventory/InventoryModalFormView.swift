//
//  InventoryModalFormView.swift
//  ExpiRemind
//
//  Created by Rinaldi LNU on 21/02/22.
//

import SwiftUI
import Combine

struct InventoryModalFormView: View {
    @ObservedObject var inventoryViewModel: InventoryViewModel
    @ObservedObject var foodCategoryViewModel: FoodCategoryViewModel
    @Binding var isPresented: Bool
    @Binding var filterCategory: String
    @State private var isShowActionSheet = false
    @State private var isShowPickerType = false
    @State private var isShowPickerStore = false
    func actionDone() {
        var action = "create"
        if inventoryViewModel.status == "edit" {
            inventoryViewModel.editData(inventoryViewModel.inventory[inventoryViewModel.selectedIndex])
            action = "edit"
            filterCategory = inventoryViewModel.inventory[inventoryViewModel.selectedIndex].store
        } else {
            inventoryViewModel.save()
            action = "create"
            filterCategory = inventoryViewModel.store
        }
        inventoryViewModel.getData()
        let dictValue = setupWatchDictValue(inventory: inventoryViewModel, action: action)
        WatchManager.shared.sendParamsToWatch(dict: dictValue)
        Notification.instance.sendNotification(inventId: inventoryViewModel.inventoryId.uuidString, itemName: inventoryViewModel.name, reminderDate: inventoryViewModel.expiryDate)
        inventoryViewModel.resetData()
        isPresented = false
    }
    func actionCancel() {
        isShowActionSheet.toggle()
    }
    var body: some View {
        NavigationView {
            ZStack {
                InventoryModalFormContentView(
                    inventoryViewModel: inventoryViewModel,
                    showingActionSheet: $isShowActionSheet,
                    isShowPickerType: $isShowPickerType,
                    isShowPickerStore: $isShowPickerStore)
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
                ModalTotalTypeView(
                    isPresented: $isShowPickerType,
                    inventoryViewModel: inventoryViewModel)
                ModalStoreView(
                    isPresented: $isShowPickerStore,
                    inventoryViewModel: inventoryViewModel)
            }
            .actionSheet(isPresented: $isShowActionSheet) {
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

struct InventoryModalFormContentView: View {
    @ObservedObject var inventoryViewModel: InventoryViewModel
    @State private var characterLimit = 30
    @Binding var showingActionSheet: Bool
    @Binding var isShowPickerType: Bool
    @Binding var isShowPickerStore: Bool
    func limitText(_ limit: Int) {
        if inventoryViewModel.name.count > limit {
            inventoryViewModel.name = String(inventoryViewModel.name.prefix(limit))
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
                        InventoryCategoryListView(
                            foodCategory: category,
                            previewSelectedCategory: $inventoryViewModel.previewSelectedCategory)
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

//struct InventoryModalFormView_Previews: PreviewProvider {
//    static var previews: some View {
//        InventoryMainFormView()
//    }
//}
