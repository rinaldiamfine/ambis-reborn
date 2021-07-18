//
//  InventoryListView.swift
//  ambis-reborn
//
//  Created by Rinaldi LNU on 10/07/21.
//

import SwiftUI

struct InventoryListView: View {
    var inventory: InventoryModel
    @State private var boxBackground = Color("BoxBackground")
    @State private var iconBackground1 = Color("IconBackground1")
    @State private var iconBackground2 = Color("IconBackground2")
    
    func formatSubtitle() -> String {
        var format = ""
        format = String(self.inventory.total) + " " + self.inventory.totalType
        return format
    }
    
    var body: some View {
        HStack {
            if inventory.foodCategory != FoodCategory() {
                ZStack {
                    Ellipse()
                        .fill(LinearGradient(
                            gradient: .init(colors: [iconBackground1, iconBackground2]),
                            startPoint: .init(x: 0, y: 0.5),
                            endPoint: .init(x: 0.8, y: 0.5)
                        ))
                        .frame(width: 46, height: 46)
                    Text(inventory.foodCategory.imageString ?? "").font(.system(size: 18))
                }.padding(.leading, 10)
                
            }
            VStack(alignment: .leading, spacing: 5) {
                Text(inventory.name).font(.system(size: 15))
                Text(formatSubtitle()).font(.system(size: 13)).foregroundColor(Color.init(.systemGray))
            }.padding(.leading, 10)
            Spacer()
            if inventory.remainingDays == 0 {
                Text("Today").font(.system(size: 15))
                    .padding(.trailing, 10)
            } else if inventory.remainingDays == 1 {
                Text("\(inventory.remainingDays) Day Left").font(.system(size: 15))
                    .padding(.trailing, 10)
            } else if inventory.remainingDays > 1 {
                Text("\(inventory.remainingDays) Days Left").font(.system(size: 15))
                    .padding(.trailing, 10)
            } else {
                Text("Expired").font(.system(size: 15)).foregroundColor(.red)
                    .padding(.trailing, 10)
            }
            
        }
        .padding(.all, 8)
        .background(RoundedRectangle(cornerRadius: 10).fill(boxBackground))
    }
}

//struct InventoryListView_Previews: PreviewProvider {
//    static var previews: some View {
//        InventoryListView()
//    }
//}
