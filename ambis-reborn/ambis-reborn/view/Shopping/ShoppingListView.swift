//
//  ShoppingListView.swift
//  ambis-reborn
//
//  Created by Muhammad Rizki Miftha Alhamid on 7/14/21.
//

import SwiftUI

struct ShoppingListView: View {
    var shopping: ShoppingModel
    
    func formatSubtitle() -> String {
        var format = ""
        format = String(self.shopping.total) + " " + self.shopping.totalType
        return format
    }
    
    var body: some View {
        HStack {
            if shopping.foodCategory != FoodCategory() {
                Text(shopping.foodCategory.imageString ?? "")
                    .font(.system(size: 18))
            }
            VStack(alignment: .leading) {
                Text(shopping.name).font(.system(size: 15))
                Text(formatSubtitle()).font(.system(size: 13))
            }
            Spacer()
            Text("Day").font(.system(size: 15))
        }
    }
}

//struct ShoppingListView_Previews: PreviewProvider {
//    static var previews: some View {
//        ShoppingListView()
//    }
//}
