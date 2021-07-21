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
    @ObservedObject var shoppingViewModel: ShoppingViewModel
    @Binding var shoppingToBeMoved: [NSManagedObjectID]
    
    @State private var boxBackground = Color("BoxBackground")
    @State private var iconBackground1 = Color("IconBackground1")
    @State private var iconBackground2 = Color("IconBackground2")
    
    @State private var limitChar: Int = 27
    @State private var startLimit: Int = 17
    

    func filterShopping() -> [ShoppingModel] {
        return shoppingViewModel.shopping.filter{
            $0.id.isEqual(shopping.id)
        }
    }
    
    func formatTitle() -> String {
        var format = ""
        for i in filterShopping() {
            let nameCount = i.name.count
            if nameCount > limitChar {
                format = String(i.name.prefix(startLimit)) + "..."
            } else {
                format = i.name
            }
        }
        return format
    }
    
    func formatSubtitle() -> String {
        var format = ""
        for i in filterShopping() {
            format = String(i.total) + " " + i.totalType
        }
        return format
    }
    
    func formatIcon() -> String {
        var format = ""
        for i in filterShopping() {
            format = i.foodCategory.imageString ?? ""
        }
        return format
    }
    
    var body: some View {
        HStack {
            if shopping.foodCategory != FoodCategory() {
                ZStack {
                    Ellipse()
                        .fill(LinearGradient(
                            gradient: .init(colors: [iconBackground1, iconBackground2]),
                            startPoint: .init(x: 0, y: 0.5),
                            endPoint: .init(x: 0.8, y: 0.5)
                        ))
                        .frame(width: 46, height: 46)
                    Text(formatIcon()).font(.system(size: 18))
                }
                //.padding(.leading, 10)
            }
            VStack(alignment: .leading, spacing: 5) {
                Text(formatTitle()).font(.system(size: 15))
                Text(formatSubtitle()).font(.system(size: 13))
                    .foregroundColor(Color.init(.systemGray))
            }
            .padding(.leading, 10)
            Spacer()
            if shoppingToBeMoved.contains(shopping.id) {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(Color.init(red: 63/255, green: 154/255, blue: 142/255))
                    .font(.system(size: 30))
            } else {
                Image(systemName: "circle")
                    .foregroundColor(Color.init(.systemGray))
                    .font(.system(size: 30))
            }
        }
        .background(RoundedRectangle(cornerRadius: 10).fill(boxBackground))
    }
}

//struct ShoppingListView_Previews: PreviewProvider {
//    static var previews: some View {
//        ShoppingListView()
//    }
//}
