//
//  TabBarView.swift
//  ambis-reborn
//
//  Created by Rinaldi LNU on 05/07/21.
//

import SwiftUI
import WidgetKit

struct TabBarView: View {
    @State private var selectedTab = 1
    var defaultAccentColor = Color("BrandColor")
    @ObservedObject var inventoryViewModel: InventoryViewModel = InventoryViewModel()
    @AppStorage("expiry", store: UserDefaults(suiteName: "group.widget.inventory")) var groupWidgetInventory : Data = Data()
    var storeAvailable = AppGlobalData.generateDataStore()
    
    init() {
        NotificationManager.shared.requestAuthorization()
        UIApplication.shared.applicationIconBadgeNumber = 0
        setupWidgetContent()
    }
    
    func setupWidgetContent() {
        var widgetInventoryModel : [WidgetInventoryModelList] = []
        let inventoryNearExpiry = inventoryViewModel.filterInventoryExpired()
        for data in inventoryNearExpiry {
            widgetInventoryModel.append(
                WidgetInventoryModelList(
                    name: data.name,
                    store: data.store,
                    total: data.total,
                    totalType: data.totalType,
                    icon: data.foodCategory.imageString ?? "",
                    remainingDate: data.remainingDays)
            )
        }
        guard let content = try? JSONEncoder().encode(
            WidgetInventoryModel.init(inventory: widgetInventoryModel)
            ) else { return }
        groupWidgetInventory = content
        WidgetCenter.shared.reloadTimelines(ofKind: "widget")
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            InventoryMainView().tabItem {
                if selectedTab == 1 {
                    InventoryMainView().getIconNameActive()
                } else {
                    InventoryMainView().getIconName()
                }
                InventoryMainView().gettabName()
            }.tag(1)
                .environmentObject(inventoryViewModel)
//            ShoppingView().tabItem {
//                if selectedTab == 2 {
//                    ShoppingView().getIconNameActive()
//                } else {
//                    ShoppingView().getIconName()
//                }
//                ShoppingView().gettabName()
//            }.tag(2)
//            PrepareView().tabItem {
//                if selectedTab == 3 {
//                    PrepareView().getIconNameActive()
//                } else {
//                    PrepareView().getIconName()
//                }
//                PrepareView().gettabName()
//            }.tag(3)
            CategoryView().tabItem {
                if selectedTab == 4 {
                    CategoryView().getIconNameActive()
                } else {
                    CategoryView().getIconName()
                }
                CategoryView().gettabName()
            }
            .tag(4)
        }
        .accentColor(defaultAccentColor)
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
