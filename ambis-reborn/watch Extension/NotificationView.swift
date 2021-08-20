//
//  NotificationView.swift
//  watch Extension
//
//  Created by Rinaldi LNU on 18/08/21.
//

import SwiftUI

struct NotificationView: View {
    var body: some View {
        GeometryReader(content: { geometry in
            VStack(alignment: .center, spacing: 5) {
                HStack(alignment: .center) {
                    Image("BrandIcon")
                        .resizable()
                        .frame(width: 122, height: 122)
                }
                .frame(width: geometry.size.width, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
                HStack(alignment: .center) {
                    Text("Items Expired")
                        .font(.system(.body, design: .rounded))
                }
                
                HStack(alignment: .center) {
                    Text("ExpiRemind")
                        .font(.system(.footnote, design: .rounded))
                        .foregroundColor(Color("InfoColor"))
                }
            }
            .frame(width: geometry.size.width, height:  geometry.size.height, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        })
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}
