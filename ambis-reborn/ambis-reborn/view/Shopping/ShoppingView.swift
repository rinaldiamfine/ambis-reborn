//
//  ShoppingView.swift
//  ambis-reborn
//
//  Created by Muhammad Rizki Miftha Alhamid on 7/14/21.
//

import SwiftUI
import CoreData

struct ShoppingView: View {
    
    var body: some View {
        Text("Shopping")
    }
    
    
    func getIconName() -> Image {
        return Image(systemName: "bag.fill")
    }
    func gettabName() -> Text {
        return Text("Shopping List")
    }
}

//struct ShoppingView_Previews: PreviewProvider {
//    static var previews: some View {
//        ShoppingView()
//    }
//}
