//
//  InventoryListEmptyView.swift
//  ambis-reborn
//
//  Created by Rinaldi LNU on 10/07/21.
//

import SwiftUI

struct InventoryListEmptyView: View {
    private var brandColor = Color("BrandColor")
    var body: some View {
        VStack {
            ZStack {
                Ellipse()
                    .fill(Color.init(UIColor.systemGray5))
                    .frame(width: 102, height: 102)
                Image(systemName: "plus").font(.system(size: 42))
                    .foregroundColor(brandColor)
            }
            Text("There are no items in your inventory.")
                .foregroundColor(Color.init(UIColor.systemGray))
                .padding(.top, 15)
            Text("Press + button to add.")
                .foregroundColor(Color.init(UIColor.systemGray))
        }
    }
}

struct  InventoryListSearchEmptyView: View {
//    @Binding totalInventSearch: Int
    
    var body: some View {
        HStack {
//            if inventory.foodCategory != FoodCategory() {
                ZStack {
                    Ellipse()
                        .fill(LinearGradient(
                            gradient: .init(colors: [.red, .blue]),
                            startPoint: .init(x: 0, y: 0.5),
                            endPoint: .init(x: 0.8, y: 0.5)
                        ))
                        .frame(width: 46, height: 46)
//                    Text(formatIcon()).font(.system(size: 18))
                }
                .padding(.leading, 10)
//            }
            
            VStack(alignment: .leading, spacing: 5) {
                Text("AASDASDASD").font(.system(size: 15))
                Text("AASDASDASD").font(.system(size: 13)).foregroundColor(Color.init(.systemGray))
            }
            .padding(.leading, 2)
            Spacer()
        }
        .padding(.top, 8)
        .padding(.bottom, 8)
        .padding(.trailing, 8)
        .background(RoundedRectangle(cornerRadius: 10).fill(Color(.red)))
//        Text(String(totalInventSearch))
    }
}

struct InventoryEmptyView: View {
    var body: some View {
        VStack{
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }.background(Color.yellow)
    }
}

//struct InventoryListEmptyView_Previews: PreviewProvider {
//    static var previews: some View {
//        InventoryListEmptyView()
//    }
//}
