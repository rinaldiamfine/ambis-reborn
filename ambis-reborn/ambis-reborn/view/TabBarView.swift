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
                InventoryView(totalInventSearch: $totalInventSearch).getIconName()
                InventoryView(totalInventSearch: $totalInventSearch).gettabName()
            }.tag(1)
            ShoppingView().tabItem {
                ShoppingView().getIconName()
                ShoppingView().gettabName()
            }.tag(2)
            PrepareView().tabItem {
                PrepareView().getIconName()
                PrepareView().gettabName()
            }.tag(3)
            CategoryView().tabItem {
                CategoryView().getIconName()
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
