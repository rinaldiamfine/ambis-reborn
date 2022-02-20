//
//  InventoryView.swift
//  ambis-reborn
//
//  Created by Rinaldi LNU on 05/07/21.
//

import SwiftUI
import WidgetKit
import CoreData
import UserNotifications

struct InventoryView: View {
    @StateObject var inventoryViewModel = InventoryViewModel()
    @StateObject var foodCategoryViewModel = FoodCategoryViewModel()
    @AppStorage("expiry", store: UserDefaults(suiteName: "group.inventoryData")) var inventoryData : Data = Data()
    
    @ObservedObject var searchBar: SearchBar = SearchBar()
    @State private var defaultFilter = "Expire Soon"
    
    @State private var searchText = ""
    @State private var showCancelButton: Bool = false
    
    func getIconNameActive() -> Image {
        return Image("TabBarInventoryActive")
    }
    func getIconName() -> Image {
        return Image("TabBarInventory")
    }
    func gettabName() -> Text {
        return Text("Inventory")
    }
    
    func filterList(expiryDate: Date, name: String, store: String) -> Bool {
        if defaultFilter == "Expire Soon" {
            if !showCancelButton {
                if expiryDate <= Date().addingTimeInterval(24 * 60 * 60 * 3) {
                    return true
                } else {
                    return false
                }
            } else {
                return name.localizedStandardContains(searchText)
            }
        } else {
            if !showCancelButton  {
                return store.localizedStandardContains(defaultFilter)
            } else {
                return name.localizedStandardContains(searchText)
            }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                if inventoryViewModel.inventoryCount > 0 {
                    ScrollView {
                        VStack(spacing: 10) {
                            InventoryFilterView(defaultFilter: $defaultFilter, isSearchActive: $showCancelButton, searchText: $searchText, showCancelButton: $showCancelButton)
                                .padding(.horizontal)
                        }
                        
                        Section {
                            ForEach (inventoryViewModel.inventory.filter {
                                let filter = filterList(expiryDate: $0.expiryDate, name: $0.name, store: $0.store)
                                return filter
                            }, id:\.id) {
                                inventory in
                                VStack(spacing: 10) {
                                    if !showCancelButton {
                                        // EXPIRE SOON
                                        if defaultFilter == "Expire Soon" {
                                            InventoryListExpiryView(inventory: inventory, inventoryViewModel: inventoryViewModel, counterGate: inventoryViewModel.inventoryCount)
                                                .onTapGesture {
                                                    presentModalForEdit()
                                                }
                                        }
                                        //NOT EXPIRE SOON
                                        else {
                                            InventoryListView(inventory: inventory, inventoryViewModel: inventoryViewModel)
                                        }
                                    } else {
                                        //ON FILTER
                                        InventoryListFilterView(inventory: inventory, inventoryViewModel: inventoryViewModel, counterGate: inventoryViewModel.inventoryCount)
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }

                        VStack {
                            if defaultFilter == "Expire Soon" {
                                if inventoryViewModel.inventoryExpiry.isEmpty {
                                    SpaceView()
                                    ZStack {
                                        Ellipse()
                                            .fill(Color.init(UIColor.systemGray5))
                                            .frame(width: 102, height: 102)
                                        Image(systemName: "bag").font(.system(size: 42))
                                            .foregroundColor(Color("BrandColor"))
                                    }
                                    Text("Great, None of your items are expiring soon.")
                                        .foregroundColor(Color.init(UIColor.systemGray))
                                        .padding(.top, 15)
                                }
                            }

                            if defaultFilter == "Fridge" {
                                if inventoryViewModel.inventoryFridge.isEmpty {
                                    SpaceView()
                                    ZStack {
                                        Ellipse()
                                            .fill(Color.init(UIColor.systemGray5))
                                            .frame(width: 102, height: 102)
                                        Image(systemName: "bag").font(.system(size: 42))
                                            .foregroundColor(Color("BrandColor"))
                                    }
                                    Text("There are no items in your \(defaultFilter).")
                                        .foregroundColor(Color.init(UIColor.systemGray))
                                        .padding(.top, 15)
                                }
                            }

                            if defaultFilter == "Freezer" {
                                if inventoryViewModel.inventoryFreezer.isEmpty {
                                    SpaceView()
                                    ZStack {
                                        Ellipse()
                                            .fill(Color.init(UIColor.systemGray5))
                                            .frame(width: 102, height: 102)
                                        Image(systemName: "bag").font(.system(size: 42))
                                            .foregroundColor(Color("BrandColor"))
                                    }
                                    Text("There are no items in your \(defaultFilter).")
                                        .foregroundColor(Color.init(UIColor.systemGray))
                                        .padding(.top, 15)
                                }
                            }

                            if defaultFilter == "Other" {
                                if inventoryViewModel.inventoryOther.isEmpty {
                                    SpaceView()
                                    ZStack {
                                        Ellipse()
                                            .fill(Color.init(UIColor.systemGray5))
                                            .frame(width: 102, height: 102)
                                        Image(systemName: "bag").font(.system(size: 42))
                                            .foregroundColor(Color("BrandColor"))
                                    }
                                    Text("There are no items in your \(defaultFilter).")
                                        .foregroundColor(Color.init(UIColor.systemGray))
                                        .padding(.top, 15)
                                }
                            }
                        }
                        .frame(width: UIScreen.screenWidth)

                        VStack {
                            SpaceView()
                        }
                    }
                    .frame(width: UIScreen.screenWidth)
                    .background(Color("AppBackground"))
                } else {
                    Spacer()
                    InventoryListEmptyView()
                        .onTapGesture {
                            inventoryViewModel.isPresented = true
                        }
                    Spacer()
                }
            }
            .navigationBarTitle("Inventory")
            .navigationBarItems(
                trailing: Button(action: inventoryViewModel.prepareCreateData, label: {
                    Image(systemName: "plus")
                        .imageScale(.large)
                        .foregroundColor(Color("BackgroundInverse"))
                }).contentShape(Circle())
            )
        }
        .sheet(isPresented: $inventoryViewModel.isPresented) {
            InventoryFormView(inventoryViewModel: inventoryViewModel, foodCategoryViewModel: foodCategoryViewModel, isPresented: $inventoryViewModel.isPresented, defaultFilter: $defaultFilter)
        }
        .onAppear(perform: {
            Notification.instance.requestAuthorization()
            foodCategoryViewModel.getData()
            inventoryViewModel.loadList()
            NotificationCenter.default.addObserver(inventoryViewModel, selector: #selector(inventoryViewModel.refresh), name: NSNotification.Name(rawValue: "inventoryUpdated"), object: nil)
            setupWidgetContent()
        })
        
    }
    
    func presentModalForEdit() {
        inventoryViewModel.isPresented = true
    }
    
    func setupWidgetContent() {
        var widgetInventoryModel : [WidgetInventoryModelList] = []
        for data in inventoryViewModel.inventory {
            if data.remainingDays <= 3 {
                widgetInventoryModel.append(
                    WidgetInventoryModelList(name: data.name, store: data.store, total: data.total, totalType: data.totalType, icon: data.foodCategory.imageString ?? "", remainingDate: data.remainingDays)
                )
            }
        }
        guard let content = try? JSONEncoder().encode(WidgetInventoryModel.init(totalExpiry: inventoryViewModel.inventoryExpire, totalInventory: inventoryViewModel.inventoryCount, progressBar: inventoryViewModel.progressBar, inventory: widgetInventoryModel)) else {return}
        inventoryData = content
        WidgetCenter.shared.reloadTimelines(ofKind: "widget")
    }
}

//struct InventoryView_Previews: PreviewProvider {
//    static var previews: some View {
//        InventoryView()
//    }
//}
