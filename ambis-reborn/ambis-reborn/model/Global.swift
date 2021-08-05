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
        globalData.append(AppGlobalData(name: "kg", value: ""))
        globalData.append(AppGlobalData(name: "gram", value: ""))
        globalData.append(AppGlobalData(name: "mg", value: ""))
        globalData.append(AppGlobalData(name: "litre", value: ""))
        globalData.append(AppGlobalData(name: "ml", value: ""))
        globalData.append(AppGlobalData(name: "cc", value: ""))
        globalData.append(AppGlobalData(name: "pcs", value: ""))
        globalData.append(AppGlobalData(name: "pack(s)", value: ""))
        globalData.append(AppGlobalData(name: "bunch(es)", value: ""))
        globalData.append(AppGlobalData(name: "bag(s)", value: ""))
        globalData.append(AppGlobalData(name: "set(s)", value: ""))
        globalData.append(AppGlobalData(name: "box(es)", value: ""))
        globalData.append(AppGlobalData(name: "gallon(s)", value: ""))
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
