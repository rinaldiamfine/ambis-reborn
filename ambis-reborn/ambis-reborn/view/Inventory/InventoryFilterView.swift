//
//  InventoryFilterView.swift
//  ambis-reborn
//
//  Created by Rinaldi LNU on 18/07/21.
//

import SwiftUI

struct InventoryFilterView: View {
    @Binding var defaultFilter: String
    
    @State var isExpirySoon: Bool = false
    @State var isFridge: Bool = false
    @State var isFreezer: Bool = false
    @State var isOther: Bool = false
    
    func removeFilter() {
        isExpirySoon = false
        isFridge = false
        isFreezer = false
        isOther = false
    }
    
    var body: some View {
        HStack {
            Spacer()
            VStack {
                if defaultFilter == "Expiry Soon" {
                    Ellipse()
                        .fill(Color.init(UIColor.red))
                        .frame(width: 32, height: 32)
                } else {
                    Ellipse()
                        .fill(Color.init(UIColor.systemGray5))
                        .frame(width: 32, height: 32)
                }
                Text("Expiry Soon")
                    .font(.system(size: 15))
            }.onTapGesture {
                defaultFilter = "Expiry Soon"
            }
            .padding(.top)
            .padding(.bottom)
            Spacer()
            VStack {
                if defaultFilter == "Fridge" {
                    Ellipse()
                        .fill(Color.init(UIColor.red))
                        .frame(width: 32, height: 32)
                } else {
                    Ellipse()
                        .fill(Color.init(UIColor.systemGray5))
                        .frame(width: 32, height: 32)
                }
                Text("   Fridge   ")
                    .font(.system(size: 15))
            }.onTapGesture {
                removeFilter()
                isFridge = true
                defaultFilter = "Fridge"
            }
            .padding(.top)
            .padding(.bottom)
            Spacer()
            VStack {
                if defaultFilter == "Freezer" {
                    Ellipse()
                        .fill(Color.init(UIColor.red))
                        .frame(width: 32, height: 32)
                } else {
                    Ellipse()
                        .fill(Color.init(UIColor.systemGray5))
                        .frame(width: 32, height: 32)
                }
                Text("   Freezer   ")
                    .font(.system(size: 15))
            }.onTapGesture {
                defaultFilter = "Freezer"
            }
            .padding(.top)
            .padding(.bottom)
            Spacer()
            VStack {
                if defaultFilter == "Other" {
                    Ellipse()
                        .fill(Color.init(UIColor.red))
                        .frame(width: 32, height: 32)
                } else {
                    Ellipse()
                        .fill(Color.init(UIColor.systemGray5))
                        .frame(width: 32, height: 32)
                }
                Text("   Other   ")
                    .font(.system(size: 15))
            }.onTapGesture {
                defaultFilter = "Other"
            }
            .padding(.top)
            .padding(.bottom)
            Spacer()
        }
        .background(RoundedRectangle(cornerRadius: 10).fill(Color.init(UIColor.systemGray6)))
        .padding()
    }
}

//struct InventoryFilterView_Previews: PreviewProvider {
//    static var previews: some View {
//        InventoryFilterView()
//    }
//}
