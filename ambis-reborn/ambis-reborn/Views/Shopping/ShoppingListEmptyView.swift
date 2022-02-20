//
//  ShoppingListEmptyView.swift
//  ambis-reborn
//
//  Created by Muhammad Rizki Miftha Alhamid on 7/14/21.
//

import SwiftUI

struct ShoppingListEmptyView: View {
    private var brandColor = Color("BrandColor")
    var body: some View {
        VStack {
            ZStack {
                Ellipse()
                    .fill(Color.init(UIColor.systemGray5))
                    .frame(width: 102, height: 102)
                Image(systemName: "plus").font(.system(size: 42))
                    .foregroundColor(brandColor)
            }
            Text("There are no items in your shopping list.")
                .foregroundColor(Color.init(UIColor.systemGray))
                .padding(.top, 15)
            Text("Press the + button to add.")
                .foregroundColor(Color.init(UIColor.systemGray))
        }
    }
}

struct ShoppingListEmptyView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingListEmptyView()
    }
}
