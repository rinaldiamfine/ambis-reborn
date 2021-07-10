//
//  CategoryViewModel.swift
//  ambis-reborn
//
//  Created by Rinaldi LNU on 09/07/21.
//

import Foundation
import UIKit
import CoreData

class FoddCategoryViewModel: ObservableObject {
    var name: String = ""
    @Published var foodCategories: [FoodCategoryModel] = []
    @Published var foodCategoriesCount: Int = 0
    
    func getData() {
        foodCategories = PersistenceController.shared.getCategoryData().map(FoodCategoryModel.init)
        foodCategoriesCount = foodCategories.count
        print("CURRENT CATEGORY", foodCategoriesCount)
    }
    
    func saveData() {
        let foodCategory = FoodCategory(context: PersistenceController.shared.container.viewContext)
        foodCategory.name = name
        PersistenceController.shared.saveData()
    }
}
