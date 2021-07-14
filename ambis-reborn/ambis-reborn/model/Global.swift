//
//  Global.swift
//  ambis-reborn
//
//  Created by Rinaldi LNU on 15/07/21.
//

import Foundation

struct AppGlobalData: Hashable {
    let name: String
    let value: String
    
    static func generateDataType() -> [AppGlobalData] {
        var globalData = [AppGlobalData]()
        globalData.append(AppGlobalData(name: "Kg", value: ""))
        globalData.append(AppGlobalData(name: "Pcs", value: ""))
        globalData.append(AppGlobalData(name: "Pack(s)", value: ""))
        globalData.append(AppGlobalData(name: "Bunch(es)", value: ""))
        globalData.append(AppGlobalData(name: "Litre", value: ""))
        globalData.append(AppGlobalData(name: "Bag(s)", value: ""))
        globalData.append(AppGlobalData(name: "Set(s)", value: ""))
        globalData.append(AppGlobalData(name: "Box(es)", value: ""))
        globalData.append(AppGlobalData(name: "Gallon(s)", value: ""))
        return globalData
    }
    
    static func generateDataStore() -> [AppGlobalData] {
        var globalData = [AppGlobalData]()
        globalData.append(AppGlobalData(name: "Fridge", value: ""))
        globalData.append(AppGlobalData(name: "Freezer", value: ""))
        globalData.append(AppGlobalData(name: "Other", value: ""))
        return globalData
    }
}
