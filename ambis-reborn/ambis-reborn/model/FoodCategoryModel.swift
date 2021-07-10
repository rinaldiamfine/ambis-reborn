//
//  FoodCategoryModel.swift
//  ambis-reborn
//
//  Created by Rinaldi LNU on 10/07/21.
//

import Foundation
import CoreData

struct FoodCategoryModel {
    let foodCategory: FoodCategory
    
    var id: NSManagedObjectID {
        return foodCategory.objectID
    }
    
    var name: String {
        return foodCategory.name ?? ""
    }
}
