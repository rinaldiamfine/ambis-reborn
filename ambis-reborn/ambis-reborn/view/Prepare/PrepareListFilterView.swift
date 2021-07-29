//
//  PrepareListFilterView.swift
//  ambis-reborn
//
//  Created by Rinaldi LNU on 29/07/21.
//

import SwiftUI

struct PrepareListFilterView: View {
    var inventory: InventoryModel
    @ObservedObject var inventoryViewModel: InventoryViewModel
    @State private var boxBackground = Color("BoxBackground")
    @State private var iconBackground1 = Color("IconBackground1")
    @State private var iconBackground2 = Color("IconBackground2")
    @State private var expiryColor = Color("ExpiryColor")
    
    @State private var limitChar: Int = 20
    @State private var startLimit: Int = 17
    var counterGate: Int
    
    private var remainingDays: Int {
        var format = 0
        for i in filterInvent() {
            format = i.remainingDays
        }
        return format
    }
    
    func filterInvent() -> [InventoryModel] {
        return inventoryViewModel.inventory.filter{
            $0.id.isEqual(inventory.id)
        }
    }
    
    func formatTitle() -> String {
        var format = ""
        for i in filterInvent() {
            let nameCount = i.name.count
            if nameCount > limitChar {
                format = String(i.name.prefix(startLimit)) + "..."
            } else {
                format = i.name
            }
        }
        return format
    }
    
    func formatSubtitle() -> String {
        var format = ""
        for i in filterInvent() {
            format = String(i.total) + " " + i.totalType
        }
        return format
    }
    
    func formatIcon() -> String {
        var format = ""
        for i in filterInvent() {
            if i.inventory.toFoodCategory != nil {
                format = i.foodCategory.imageString ?? ""
            }
        }
        return format
    }
    
    func formatStore() -> String {
        var format = ""
        for i in filterInvent() {
            format = i.store
        }
        return format
    }
    
    var body: some View {
        HStack {
            if inventory.foodCategory != FoodCategory() {
                ZStack {
                    Ellipse()
                        .fill(LinearGradient(
                            gradient: .init(colors: [iconBackground1, iconBackground2]),
                            startPoint: .init(x: 0, y: 0.5),
                            endPoint: .init(x: 0.8, y: 0.5)
                        ))
                        .frame(width: 46, height: 46)
                    Text(formatIcon()).font(.system(size: 28))
                }.padding(.leading, 10)
                
            }
            VStack(alignment: .leading, spacing: 5) {
                Text(formatTitle()).font(.system(size: 15))
                HStack {
                    Text(formatStore()).font(.system(size: 13)).foregroundColor(Color.init(.systemGray))
                    Text("・").font(.system(size: 13)).foregroundColor(Color.init(.systemGray))
                    Text(formatSubtitle()).font(.system(size: 13)).foregroundColor(Color.init(.systemGray))
                }
            }.padding(.leading, 2)
            Spacer()
            if remainingDays == 0 {
                Text("Today").font(.system(size: 15)).foregroundColor(expiryColor)
                    .padding(.trailing, 10)
            } else if remainingDays == 1 {
                Text("\(remainingDays) Day Left").font(.system(size: 15)).foregroundColor(expiryColor)
                    .padding(.trailing, 10)
            } else if remainingDays > 1 {
                Text("\(remainingDays) Days Left").font(.system(size: 15)).foregroundColor(expiryColor)
                    .padding(.trailing, 10)
            } else {
                Text("Expired").font(.system(size: 15)).foregroundColor(expiryColor)
                    .padding(.trailing, 10)
            }
//            Spacer()
            if inventoryViewModel.prepareSelectedInventory.contains(inventory.id) {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(Color("BrandColor"))
                    .font(.system(size: 30))
            } else {
                Image(systemName: "circle")
                    .foregroundColor(Color.init(.systemGray))
                    .font(.system(size: 30))
            }
        }
        .padding(.top, 8)
        .padding(.bottom, 8)
        .padding(.trailing, 8)
        .background(RoundedRectangle(cornerRadius: 10).fill(boxBackground))
        .onTapGesture {
            if inventoryViewModel.prepareSelectedInventory.contains(inventory.id) {
                inventoryViewModel.prepareSelectedInventory = inventoryViewModel.prepareSelectedInventory.filter{$0 != inventory.id}
            } else {
                inventoryViewModel.prepareSelectedInventory.append(inventory.id)
            }
        }
    }
}

//struct PrepareListFilterView_Previews: PreviewProvider {
//    static var previews: some View {
//        PrepareListFilterView()
//    }
//}
