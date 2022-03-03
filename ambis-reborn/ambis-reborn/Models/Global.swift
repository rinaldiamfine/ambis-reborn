//
//  Global.swift
//  ambis-reborn
//
//  Created by Rinaldi LNU on 15/07/21.
//

import Foundation

struct AppGlobalData: Hashable {
    let id: Int
    let name: String
    let value: String
    
    static func generateDataType() -> [AppGlobalData] {
        var globalData = [AppGlobalData]()
        globalData.append(AppGlobalData(id: 1, name: "kg", value: ""))
        globalData.append(AppGlobalData(id: 2, name: "gram", value: ""))
        globalData.append(AppGlobalData(id: 3, name: "mg", value: ""))
        globalData.append(AppGlobalData(id: 4, name: "litre", value: ""))
        globalData.append(AppGlobalData(id: 5, name: "ml", value: ""))
        globalData.append(AppGlobalData(id: 6, name: "cc", value: ""))
        globalData.append(AppGlobalData(id: 7, name: "pcs", value: ""))
        globalData.append(AppGlobalData(id: 8, name: "pack(s)", value: ""))
        globalData.append(AppGlobalData(id: 9, name: "bunch(es)", value: ""))
        globalData.append(AppGlobalData(id: 10, name: "bag(s)", value: ""))
        globalData.append(AppGlobalData(id: 11, name: "set(s)", value: ""))
        globalData.append(AppGlobalData(id: 12, name: "box(es)", value: ""))
        globalData.append(AppGlobalData(id: 13, name: "gallon(s)", value: ""))
        return globalData
    }
    
    static func generateDataStore() -> [AppGlobalData] {
        var globalData = [AppGlobalData]()
        globalData.append(AppGlobalData(id: 1, name: "Fridge", value: ""))
        globalData.append(AppGlobalData(id: 2, name: "Freezer", value: ""))
        globalData.append(AppGlobalData(id: 3, name: "Other", value: ""))
        return globalData
    }
    
    static func generateFilterDataSotre() -> [AppGlobalData] {
        var globalData = [AppGlobalData]()
        globalData.append(AppGlobalData(id: 0, name: "Expire Soon", value: ""))
        globalData.append(AppGlobalData(id: 1, name: "Fridge", value: ""))
        globalData.append(AppGlobalData(id: 2, name: "Freezer", value: ""))
        globalData.append(AppGlobalData(id: 3, name: "Other", value: ""))
        return globalData
    }
}
