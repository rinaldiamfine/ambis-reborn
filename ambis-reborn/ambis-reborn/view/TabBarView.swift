//
//  TabBarView.swift
//  ambis-reborn
//
//  Created by Rinaldi LNU on 05/07/21.
//

import SwiftUI

struct TabBarView: View {
    @State private var selectedTab = 1
    var defaultAccentColor = Color("AccentColor")
    
    var body: some View {
        TabView(selection: $selectedTab) {
            InventoryView().tabItem {
                InventoryView().getIconName()
                InventoryView().gettabName()
            }.tag(1)
            CategoryView().tabItem {
                CategoryView().getIconName()
                CategoryView().gettabName()
            }.tag(2)
        }.accentColor(defaultAccentColor)
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
