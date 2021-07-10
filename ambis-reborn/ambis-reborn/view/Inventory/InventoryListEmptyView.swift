//
//  InventoryListEmptyView.swift
//  ambis-reborn
//
//  Created by Rinaldi LNU on 10/07/21.
//

import SwiftUI

struct InventoryListEmptyView: View {
    var body: some View {
        Image(systemName: "bag").font(.system(size: 80))
        Text("There are no items in your inventory.").padding()
    }
}

struct InventoryListEmptyView_Previews: PreviewProvider {
    static var previews: some View {
        InventoryListEmptyView()
    }
}
