//
//  RecipeSample.swift
//  ambis-reborn
//
//  Created by Muhammad Rizki Miftha Alhamid on 7/29/21.
//

import Foundation

struct RecipeSample {
    var name: String
    var prepTime: Int = 1
    var cookTime: Int = 1
    var cookMethod: String = ""
    var cookStep: [String]
    var totalServes: Int = 1
    var category: String = "Dessert"
    var level : String = "intermediate"
    
    var ingredient: [IngredientSample]
}
