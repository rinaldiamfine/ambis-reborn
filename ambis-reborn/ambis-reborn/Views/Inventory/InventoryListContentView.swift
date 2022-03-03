//
//  InventoryListContentView.swift
//  ExpiRemind
//
//  Created by Rinaldi LNU on 03/03/22.
//

import SwiftUI

struct InventoryListContentView: View {
    var inventory: InventoryModel
    @ObservedObject var inventoryViewModel: InventoryViewModel
    @State private var boxBackground = Color("BoxBackground")
    @State private var iconBackground1 = Color("IconBackground1")
    @State private var iconBackground2 = Color("IconBackground2")
    @State private var expiryColor = Color("ExpiryColor")
    
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
                    Text(inventory.foodCategory.imageString ?? "").font(.system(size: 28))
                }
                .padding(.leading, 10)
            }
            
            VStack(alignment: .leading, spacing: 5) {
                Text(inventory.name)
                    .font(.system(size: 15, design: .rounded))
                Text(String(inventory.total) + " " + inventory.totalType)
                    .font(.system(size: 13, design: .rounded))
                    .foregroundColor(Color.init(.systemGray))
            }
            .padding(.leading, 2)
            Spacer()
            
            if inventory.remainingDays == 0 {
                Text("Today")
                    .font(.system(size: 12, design: .rounded))
                    .foregroundColor(Color.white)
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.center)
                    .frame(width: 98, height: 28)
                    .background(
                        Capsule().fill(Color("AlertBackground-1"))
                    )
                    .padding(.trailing, 10)
            } else if inventory.remainingDays == 1 {
                Text("\(inventory.remainingDays) Day Left")
                    .font(.system(size: 12, design: .rounded))
                    .foregroundColor(Color.white)
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.center)
                    .frame(width: 98, height: 28)
                    .background(
                        Capsule().fill(Color("AlertBackground-2"))
                    )
                    .padding(.trailing, 10)
            } else if inventory.remainingDays > 1 {
                Text("\(inventory.remainingDays) Days Left")
                    .font(.system(size: 12, design: .rounded))
                    .foregroundColor(Color.white)
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.center)
                    .frame(width: 98, height: 28)
                    .background(
                        Capsule().fill(Color("AlertBackground-3"))
                    )
                    .padding(.trailing, 10)
            } else {
                Text("Expired")
                    .font(.system(size: 12, design: .rounded))
                    .foregroundColor(Color.white)
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.center)
                    .frame(width: 98, height: 28)
                    .background(
                        Capsule().fill(Color("AlertBackground-1"))
                    )
                    .padding(.trailing, 10)
            }
            
        }
        .padding(.top, 8)
        .padding(.bottom, 8)
        .padding(.trailing, 8)
        .background(RoundedRectangle(cornerRadius: 15).fill(boxBackground))
        .contextMenu {
            Button {
                inventoryViewModel.fillForm(model: inventory)
            } label: {
                Label("Update Inventory", systemImage: "square.and.pencil")
            }

            Button {
                actionShare(data: inventory)
            } label: {
                Label("Share", systemImage: "arrowshape.turn.up.forward")
            }

            Divider()
            Button {
                inventoryViewModel.deleteById(model: inventory)
            } label: {
                Text("Remove")
                Image(systemName: "trash")
            }
        }
    }
    
    func actionShare(data: InventoryModel) {
        let total = String(format: "%.0f", data.total)
        let type = String(describing: data.totalType)
        let name = data.name
        let formatShare = ["Hey. I have about \(total) \(type) of \(name) that I will not be using. Would you like to take it?"]
        let activityView = UIActivityViewController(activityItems: formatShare, applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(activityView, animated: true, completion: nil)
    }
}
