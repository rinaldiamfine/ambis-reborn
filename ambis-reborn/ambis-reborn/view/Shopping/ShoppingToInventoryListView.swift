//
//  ShoppingToInventoryListView.swift
//  ambis-reborn
//
//  Created by Muhammad Rizki Miftha Alhamid on 7/15/21.
//

import SwiftUI
import CoreData

struct ShoppingToInventoryListView: View {
    var shopping: ShoppingModel
    @State var testDate: Date
    @Binding var activeShopping: [NSManagedObjectID]
    
    func formatSubtitle() -> String {
        var format = ""
        format = String(self.shopping.total) + " " + self.shopping.totalType
        return format
    }
    
    var body: some View {
        VStack {
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
                if activeShopping.contains(shopping.id) {
                    Image(systemName: "chevron.down")
                        .font(.system(size: 12, weight: .bold))
                    .foregroundColor(Color.init(UIColor.systemGray2))
                } else {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 13, weight: .bold))
                    .foregroundColor(Color.init(UIColor.systemGray2))
                }
            }
            if activeShopping.contains(shopping.id) {
                DatePicker("Buy", selection: $testDate)
            }
        }
        
        
    }
}

//struct ShoppingToInventoryListView_Previews: PreviewProvider {
//    static var previews: some View {
//        ShoppingToInventoryListView()
//    }
//}
