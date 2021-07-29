//
//  RecipeSample.swift
//  ambis-reborn
//
//  Created by Muhammad Rizki Miftha Alhamid on 7/29/21.
//

import Foundation

struct RecipeSample {
    var name: String
    var prepTime: Int
    var cookTime: Int
    var cookMethod: String
    var cookStep: [String]
    var totalServes: Int
    
    var ingredient: [IngredientSample]
}
