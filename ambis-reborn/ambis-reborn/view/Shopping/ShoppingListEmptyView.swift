//
//  ShoppingListEmptyView.swift
//  ambis-reborn
//
//  Created by Muhammad Rizki Miftha Alhamid on 7/14/21.
//

import SwiftUI

struct ShoppingListEmptyView: View {
    var body: some View {
        VStack {
            Image(systemName: "bag")
                .font(.system(size: 80))
                .foregroundColor(Color.init(UIColor.systemGray))
            Text("There are no items in your shopping list.")
                .foregroundColor(Color.init(UIColor.systemGray))
                .padding()
        }
    }
}

struct ShoppingListEmptyView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingListEmptyView()
    }
}
