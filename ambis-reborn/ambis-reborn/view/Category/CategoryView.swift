//
//  CategoryView.swift
//  ambis-reborn
//
//  Created by Rinaldi LNU on 05/07/21.
//

import SwiftUI

struct CategoryView: View {
    func getIconName() -> Image {
        return Image(systemName: "square.grid.2x2.fill")
    }
    func gettabName() -> Text {
        return Text("Category")
    }
    
    var body: some View {
        Text("Category")
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView()
    }
}
