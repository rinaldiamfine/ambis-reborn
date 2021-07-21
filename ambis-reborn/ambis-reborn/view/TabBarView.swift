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
    
    var body: some View {
        TabView(selection: $selectedTab) {
            InventoryView().tabItem {
                InventoryView().getIconName()
                InventoryView().gettabName()
            }.tag(1).environmentObject(inventoryViewModel)
            ShoppingView().tabItem {
                ShoppingView().getIconName()
                ShoppingView().gettabName()
            }.tag(2)
            CategoryView().tabItem {
                CategoryView().getIconName()
                CategoryView().gettabName()
            }.tag(3)
        }.accentColor(defaultAccentColor)
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
