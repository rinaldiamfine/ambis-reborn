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
            if inventory.remainingDays == 0 {
                Text("Today").font(.system(size: 15))
            } else if inventory.remainingDays == 1 {
                Text("\(inventory.remainingDays) Day Left").font(.system(size: 15))
            } else if inventory.remainingDays > 1 {
                Text("\(inventory.remainingDays) Days Left").font(.system(size: 15))
            } else {
                Text("Expired").font(.system(size: 15)).foregroundColor(.red)
            }
            
        }
    }
}

//struct InventoryListView_Previews: PreviewProvider {
//    static var previews: some View {
//        InventoryListView()
//    }
//}
