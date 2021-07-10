//
//  InventoryListView.swift
//  ambis-reborn
//
//  Created by Rinaldi LNU on 10/07/21.
//

import SwiftUI

struct InventoryListView: View {
    var title: String = "Title"
    var subtitle: String = "Subtitle"
    var body: some View {
        HStack {
            Image(systemName: "circle").font(.system(size: 25)).frame(width: 40, height: 40)
            VStack {
                Text(title).font(.body)
                Text(subtitle).font(.footnote)
            }
            Spacer()
        }
    }
}

struct InventoryListView_Previews: PreviewProvider {
    static var previews: some View {
        InventoryListView()
    }
}
