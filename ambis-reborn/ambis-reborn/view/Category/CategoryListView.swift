//
//  CategoryCellView.swift
//  ambis-reborn
//
//  Created by Rinaldi LNU on 06/07/21.
//

import SwiftUI

struct CategoryListView: View {
    var title: String = ""
    var body: some View {
        HStack {
            Image(systemName: "circle").font(.system(size: 25)).frame(width: 40, height: 40)
            Text(title).font(.body)
            Spacer()
        }
    }
}

struct CategoryListView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryListView()
    }
}
