//
//  InventoryEmptyStateView.swift
//  ExpiRemind
//
//  Created by Rinaldi LNU on 20/02/22.
//

import SwiftUI

struct InventoryEmptyStateView: View {
    @ObservedObject var inventoryViewModel: InventoryViewModel
    @State var icon: String
    @State var title: String
    @State var subtitle: String
    @Environment(\.isSearching) var isSearching
    var body: some View {
        if !isSearching {
            VStack(spacing: 30) {
                Spacer()
                HStack {
                    Spacer()
                    if icon == "plus" {
                        Image(systemName: "plus")
                            .resizable()
                            .foregroundColor(Color("BrandColor"))
                            .frame(width: 40, height: 40, alignment: .center)
                            .background(
                                Circle()
                                    .fill(Color.init(UIColor.systemGray3))
                                    .frame(width: 110, height: 110)
                                )
                    } else {
                        Image(inventoryViewModel.filterCategory)
                            .resizable()
                            .foregroundColor(Color("BrandColor"))
                            .frame(width: 40, height: 40, alignment: .center)
                            .background(
                                Circle()
                                    .fill(Color.init(UIColor.systemGray3))
                                    .frame(width: 110, height: 110)
                                )
                    }
                    Spacer()
                }
                .padding()
                
                HStack(alignment: .center) {
                    VStack(alignment: .center, spacing: 5) {
                        if icon == "plus" {
                            Text(title)
                                .font(.system(.headline, design: .rounded))
                                .foregroundColor(Color.init(UIColor.systemGray))
                        } else {
                            Text("There are no items in " + inventoryViewModel.filterCategory)
                                .font(.system(.headline, design: .rounded))
                                .foregroundColor(Color.init(UIColor.systemGray))
                        }
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
        } else {
            VStack(spacing: 30) {
                Spacer()
                HStack {
                    Spacer()
                    Image(systemName: "magnifyingglass")
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
                        Text("There are no items found")
                            .font(.system(.headline, design: .rounded))
                            .foregroundColor(Color.init(UIColor.systemGray))
                        Text("Please try another keyword")
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
}

struct InventoryEmptyStateView_Previews: PreviewProvider {
    static var previews: some View {
        InventoryEmptyStateView(inventoryViewModel: InventoryViewModel(), icon: "BtnExpirySoon", title: "Title", subtitle: "Subtitle")
    }
}
