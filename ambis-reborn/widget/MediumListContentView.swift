//
//  MediumListContentView.swift
//  ExpiRemind
//
//  Created by Rinaldi LNU on 03/03/22.
//

import SwiftUI

struct MediumListContentView: View {
    @State var content: WidgetInventoryModelList
    @State private var iconBackground1 = Color("IconBackground1")
    @State private var iconBackground2 = Color("IconBackground2")
    
    func setFormatSubtitle(store: String, total: Double, totalType: String) -> String {
        var format : String = ""
        format = store + "・" + String(total) + " " + totalType
        return format
    }
    
    var body: some View {
        HStack {
            ZStack {
                Ellipse()
                    .fill(LinearGradient(
                        gradient: .init(colors: [iconBackground1, iconBackground2]),
                        startPoint: .init(x: 0, y: 0.5),
                        endPoint: .init(x: 0.8, y: 0.5)
                    ))
                    .frame(width: 40, height: 40)
                Text(content.icon).font(.system(size: 20))
            }
            VStack(alignment: .leading, spacing: 5) {
                Text(content.name).font(.system(size: 13, design: .rounded))
                HStack {
                    Text(setFormatSubtitle(store: content.store,total: content.total, totalType: content.totalType)).font(.system(size: 10, design: .rounded)).foregroundColor(Color.init(.systemGray))
                }
            }
        }
    }
}
