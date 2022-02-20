//
//  InventoryEmptyStateView.swift
//  ExpiRemind
//
//  Created by Rinaldi LNU on 20/02/22.
//

import SwiftUI

struct InventoryEmptyStateView: View {
    @State var title: String
    @State var subtitle: String
    var body: some View {
        VStack(spacing: 30) {
            Spacer()
            HStack {
                Spacer()
                Image(systemName: "plus")
                    .resizable()
                    .foregroundColor(Color("BrandColor"))
                    .frame(width: 40, height: 40, alignment: .center)
                    .background(
                        Circle()
                            .fill(Color.init(UIColor.systemGray3))
                            .frame(width: 110, height: 110)
                )
                Spacer()
            }
            .padding()
            
            HStack(alignment: .center) {
                VStack(alignment: .center, spacing: 5) {
                    Text(title)
                        .font(.system(.headline, design: .rounded))
                        .foregroundColor(Color.init(UIColor.systemGray))
                    Text(subtitle)
                        .font(.system(.subheadline, design: .rounded))
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color.init(UIColor.systemGray))
                }
            }
            .padding()
            Spacer()
        }
        .background(Color("AppBackground"))
    }
}

struct InventoryEmptyStateView_Previews: PreviewProvider {
    static var previews: some View {
        InventoryEmptyStateView(title: "Title", subtitle: "Subtitle")
    }
}
