//
//  ShoppingListView.swift
//  ambis-reborn
//
//  Created by Muhammad Rizki Miftha Alhamid on 7/14/21.
//

import SwiftUI
import CoreData

struct ShoppingListView: View {
    var shopping: ShoppingModel
    @Binding var shoppingToBeMoved: [NSManagedObjectID]
    
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
            if shoppingToBeMoved.contains(shopping.id) {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.green)
            } else {
                Image(systemName: "checkmark.circle")
            }
        }
    }
}

//struct ShoppingListView_Previews: PreviewProvider {
//    static var previews: some View {
//        ShoppingListView()
//    }
//}
