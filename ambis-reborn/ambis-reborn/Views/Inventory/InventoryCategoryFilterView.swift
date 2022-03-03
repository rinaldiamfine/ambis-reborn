//
//  InventoryCategoryFilterView.swift
//  ExpiRemind
//
//  Created by Rinaldi LNU on 20/02/22.
//

import SwiftUI

struct InventoryCategoryFilterContentView: View {
    @ObservedObject var inventoryViewModel: InventoryViewModel
    @State var name: String
    func actionTap() {
        inventoryViewModel.filterCategory = name
    }
    var body: some View {
        VStack {
            Rectangle()
                .fill(inventoryViewModel.filterCategory == name ? Color("BrandColor") : Color("BoxBackground"))
                .cornerRadius(radius: 5, corners: [.bottomLeft, .bottomRight])
                .frame(width: 26, height: 4, alignment: .center)
            ZStack {
                Ellipse()
                    .fill(Color("BoxBackground"))
                    .frame(width: 46, height: 46)
                if name == "Expire Soon" {
                    Image("BtnExpirySoonActive")
                    .resizable().frame(width: 26, height: 26)
                } else if name == "Fridge" {
                    Image("BtnFridgeActive")
                    .resizable().frame(width: 26, height: 26)
                } else if name == "Freezer" {
                    Image("BtnFreezerActive")
                    .resizable().frame(width: 26, height: 26)
                } else {
                    Image("BtnOtherActive")
                    .resizable().frame(width: 26, height: 26)
                }
            }
            Text(name)
                .fontWeight(inventoryViewModel.filterCategory == name ? .medium : .medium)
                .font(.system(size: 12, design: .rounded))
                .foregroundColor(inventoryViewModel.filterCategory == name ? Color("BackgroundInverse") : Color.secondary)
        }
        .onTapGesture {
            actionTap()
        }
    }
}

struct InventoryCategoryFilterView: View {
    @ObservedObject var inventoryViewModel: InventoryViewModel
    var filterStoreAvailable = AppGlobalData.generateFilterDataSotre()
//    @Environment(\.isSearching) var isSearching
    var body: some View {
        VStack {
//            if !isSearching {
                HStack(spacing: 0) {
                    Spacer()
                    ForEach (filterStoreAvailable, id:\.id) {
                        store in
                        InventoryCategoryFilterContentView(inventoryViewModel: self.inventoryViewModel, name: store.name)
                        .padding(.bottom)
                        .frame(minWidth: 0, maxWidth: .infinity)
                    }
                    Spacer()
                }
                .background(
                    RoundedRectangle(cornerRadius: 15)
                    .fill(Color("BoxBackground")))
//            }
        }
        .padding(.bottom, 10)
        .animation(.default)
    }
}

struct InventoryCategoryFilterView_Previews: PreviewProvider {
    static var previews: some View {
        InventoryCategoryFilterView(inventoryViewModel: InventoryViewModel())
    }
}
