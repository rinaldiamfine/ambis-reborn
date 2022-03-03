//
//  TabBarView.swift
//  ambis-reborn
//
//  Created by Rinaldi LNU on 05/07/21.
//

import SwiftUI

struct TabBarView: View {
    @State private var selectedTab = 1
    var defaultAccentColor = Color("BrandColor")
    @ObservedObject var inventoryViewModel: InventoryViewModel = InventoryViewModel()
    var storeAvailable = AppGlobalData.generateDataStore()
    
    init() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge]) { (success, error) in
            if success{
                print("Setup notification success!")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
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
