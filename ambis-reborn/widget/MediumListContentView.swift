//
//  MediumListContentView.swift
//  ExpiRemind
//
//  Created by Rinaldi LNU on 03/03/22.
//

import SwiftUI

struct MediumListContentView: View {
    @State var widgetInventoryModel: WidgetInventoryModelList
    
    var body: some View {
        HStack {
            ZStack {
                Ellipse()
                    .fill(LinearGradient(
                        gradient: .init(colors: [Color("IconBackground1"), Color("IconBackground2")]),
                        startPoint: .init(x: 0, y: 0.5),
                        endPoint: .init(x: 0.8, y: 0.5)
                    ))
                    .frame(width: 40, height: 40)
                Text(widgetInventoryModel.icon)
                    .font(.system(size: 20))
            }
            VStack(alignment: .leading, spacing: 5) {
                Text(widgetInventoryModel.name)
                    .font(.system(size: 13, design: .rounded))
                HStack {
                    Text(widgetInventoryModel.formatSubtitle)
                        .font(.system(size: 10, design: .rounded))
                        .foregroundColor(Color.init(.systemGray))
                }
            }
        }
    }
}
