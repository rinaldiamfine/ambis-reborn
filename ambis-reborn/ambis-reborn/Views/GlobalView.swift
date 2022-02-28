//
//  GlobalView.swift
//  ambis-reborn
//
//  Created by Rinaldi LNU on 02/08/21.
//

import SwiftUI

func setupWatchDictValue(inventory: InventoryViewModel, action: String) -> [String: Any] {
    let dateFormater = DateFormatter()
    dateFormater.dateFormat = "yyyy-MM-dd hh:mm:ss"
    let stringDate = dateFormater.string(from: inventory.expiryDate)
    return [
        "inventoryId": inventory.inventoryId.uuidString,
        "name": inventory.name,
        "store": inventory.store,
        "total": inventory.total,
        "totalType": inventory.totalType,
        "expiredDate": stringDate,
        "categoryIcon": inventory.toFoodCategory.imageString ?? "",
        "action": action
    ]
}

struct GlobalView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct GlobalView_Previews: PreviewProvider {
    static var previews: some View {
        GlobalView()
    }
}

struct SpaceView: View {
    var body: some View {
        HStack {
            HStack {
                Text(" ")
                Spacer()
            }
        }
        HStack {
            HStack {
                Text(" ")
                Spacer()
            }
        }
        HStack {
            HStack {
                Text(" ")
                Spacer()
            }
        }
        HStack {
            HStack {
                Text(" ")
                Spacer()
            }
        }
    }
}
