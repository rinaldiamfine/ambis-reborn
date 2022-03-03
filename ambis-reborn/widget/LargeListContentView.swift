//
//  LargeListContentView.swift
//  ExpiRemind
//
//  Created by Rinaldi LNU on 03/03/22.
//

import SwiftUI

struct LargeListContentView: View {
    @State var content: WidgetInventoryModelList
    @State private var iconBackground1 = Color("IconBackground1")
    @State private var iconBackground2 = Color("IconBackground2")
    @State private var expiryColor = Color("ExpiryColor")
    @State private var cellColor = Color("IconBackground1")
    
    func setFormatSubtitle(total: Double, totalType: String) -> String {
        var format : String = ""
        format = String(total) + " " + totalType
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
                Text(content.icon).font(.system(size: 24))
            }
            .padding(.leading, 10)
            VStack(alignment: .leading, spacing: 5) {
                Text(content.name).font(.system(size: 13, design: .rounded))
                HStack {
                    Text(content.store).font(.system(size: 10, design: .rounded)).foregroundColor(Color.init(.systemGray))
                    Text("・").font(.system(size: 10, design: .rounded)).foregroundColor(Color.init(.systemGray))
                    Text(setFormatSubtitle(total: content.total, totalType: content.totalType)).font(.system(size: 10, design: .rounded)).foregroundColor(Color.init(.systemGray))
                }
            }
            Spacer()
            HStack {
                if content.remainingDate == 0 {
                    Text("Today")
                        .font(.system(size: 10, design: .rounded))
                        .foregroundColor(Color.white)
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                        .frame(width: 90, height: 25)
                        .background(
                            Capsule().fill(Color("ExpiryBackground"))
                        )
                } else if content.remainingDate == 1 {
                    Text("\(content.remainingDate) Day Left")
                        .font(.system(size: 10, design: .rounded))
                        .foregroundColor(Color.white)
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                        .frame(width: 90, height: 25)
                        .background(
                            Capsule().fill(Color("ExpiryBackground"))
                        )
                } else if content.remainingDate > 1 {
                    Text("\(content.remainingDate) Days Left")
                        .font(.system(size: 10, design: .rounded))
                        .foregroundColor(Color.white)
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                        .frame(width: 90, height: 25)
                        .background(
                            Capsule().fill(Color("ExpiryBackground"))
                        )
                } else {
                    Text("Expired")
                        .font(.system(size: 10, design: .rounded))
                        .foregroundColor(Color.white)
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                        .frame(width: 90, height: 25)
                        .background(
                            Capsule().fill(Color("ExpiryBackground"))
                        )
                }
            }
            .padding(.horizontal, 15)
        }
        .padding(.vertical, 7)
        .background(RoundedRectangle(cornerRadius: 15).fill(cellColor))
        .padding(.horizontal, 15)
    }
}
