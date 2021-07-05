//
//  TabBarView.swift
//  ambis-reborn
//
//  Created by Rinaldi LNU on 05/07/21.
//

import SwiftUI

struct TabBarView: View {
    var defaultAccentColor = Color("AccentColor")
    var body: some View {
        TabView {
            InventoryView().tabItem {
                InventoryView().getIconName()
                InventoryView().gettabName()
            }
            CategoryView().tabItem {
                CategoryView().getIconName()
                CategoryView().gettabName()
            }
        }.accentColor(defaultAccentColor)
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
