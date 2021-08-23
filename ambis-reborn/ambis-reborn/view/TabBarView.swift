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
    @State var totalInventSearch : Bool = false
    
    var body: some View {
        TabView(selection: $selectedTab) {
            InventoryView(totalInventSearch: $totalInventSearch).tabItem {
                if selectedTab == 1 {
                    InventoryView(totalInventSearch: $totalInventSearch).getIconNameActive()
                } else {
                    InventoryView(totalInventSearch: $totalInventSearch).getIconName()
                }
                InventoryView(totalInventSearch: $totalInventSearch).gettabName()
            }.tag(1)
            ShoppingView().tabItem {
                if selectedTab == 2 {
                    ShoppingView().getIconNameActive()
                } else {
                    ShoppingView().getIconName()
                }
                ShoppingView().gettabName()
            }.tag(2)
            PrepareView().tabItem {
                if selectedTab == 3 {
                    PrepareView().getIconNameActive()
                } else {
                    PrepareView().getIconName()
                }
                PrepareView().gettabName()
            }.tag(3)
            CategoryView().tabItem {
                if selectedTab == 4 {
                    CategoryView().getIconNameActive()
                } else {
                    CategoryView().getIconName()
                }
                CategoryView().gettabName()
            }.tag(4)
//            RecipeView().tabItem {
//                RecipeView().getIconName()
//                RecipeView().gettabName()
//            }.tag(5)
        }.accentColor(defaultAccentColor)
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
