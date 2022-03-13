//
//  FoodCategoryCoreDataManager.swift
//  ExpiRemind
//
//  Created by Rinaldi LNU on 21/02/22.
//

import Foundation
import CoreData

extension ExpiRemindCoreDataManager {
    func fetchCategory() -> [FoodCategoryModel] {
        let request: NSFetchRequest<FoodCategory> = FoodCategory.fetchRequest()
        do {
            return try viewContext.fetch(request).map(FoodCategoryModel.init)
        } catch {
            return []
        }
    }
    
}
