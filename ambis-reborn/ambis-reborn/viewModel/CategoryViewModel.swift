//
//  CategoryViewModel.swift
//  ambis-reborn
//
//  Created by Rinaldi LNU on 09/07/21.
//

import Foundation
import UIKit
import CoreData
import SwiftUI

class FoddCategoryViewModel: ObservableObject {
    var name: String = ""
    var subtitle: String = ""
    var estimation: String = ""
    var imageString: String = ""
    
    var defaultFoodCategory: [DefalutFoodCategory] = []
    @Published var foodCategories: [FoodCategoryModel] = []
    @Published var foodCategoriesCount: Int = 0
    @Published private(set) var dest: AnyView? = nil
    @Published var isActive: Bool = false
    
    func move(to: AnyView) {
        self.dest = to
        self.isActive = true
    }
    
    func getData() {
        foodCategories = PersistenceController.shared.getCategoryData().map(FoodCategoryModel.init)
        foodCategoriesCount = foodCategories.count
        if foodCategoriesCount == 0 {
            defaultFoodCategory = DefalutFoodCategory.generateDefaultCategory()
            for food in defaultFoodCategory {
                let foodCategory = FoodCategory(context: PersistenceController.shared.container.viewContext)
                foodCategory.name = food.name
                foodCategory.subtitle = food.subtitle
                foodCategory.estimation = food.estimation
                foodCategory.imageString = food.iconString
                foodCategory.expiryEstimation = food.expiryEstimation
                PersistenceController.shared.saveData()
            }
            getData()
        }
    }
    
    func saveData() {
        let foodCategory = FoodCategory(context: PersistenceController.shared.container.viewContext)
        foodCategory.name = name
        foodCategory.subtitle = subtitle
        foodCategory.estimation = estimation
        foodCategory.imageString = imageString
        PersistenceController.shared.saveData()
    }
}
