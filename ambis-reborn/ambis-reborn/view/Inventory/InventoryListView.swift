//
//  InventoryListView.swift
//  ambis-reborn
//
//  Created by Rinaldi LNU on 10/07/21.
//

import SwiftUI

struct InventoryListView: View {
    var inventory: InventoryModel
    
    func formatSubtitle() -> String {
        var format = ""
        print(inventory.totalType, "-", inventory.total)
        format = String(self.inventory.total) + " " + self.inventory.totalType
        return format
    }
    
    var body: some View {
        HStack {
            Image(systemName: "circle").font(.system(size: 25)).frame(width: 40, height: 40)
            VStack {
                Text(inventory.name).font(.system(size: 15))
                Text(formatSubtitle()).font(.system(size: 13))
            }
            Spacer()
            Text("3 Days Remaining").font(.system(size: 15))
        }
    }
}

//struct InventoryListView_Previews: PreviewProvider {
//    static var previews: some View {
//        InventoryListView()
//    }
//}
