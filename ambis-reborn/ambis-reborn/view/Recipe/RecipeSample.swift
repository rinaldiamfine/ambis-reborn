//
//  RecipeSample.swift
//  ambis-reborn
//
//  Created by Muhammad Rizki Miftha Alhamid on 7/29/21.
//

import Foundation

struct RecipeSample {
    var name: String
    var prepTime: Int = 0
    var cookTime: Int = 0
    var cookMethod: String = ""
    var cookStep: [String]
    var totalServes: Int = 0
    
    var ingredient: [IngredientSample]
    
    //var defaultRecipes: [RecipeSample] = [RecipeSample(name: "Ayam Goreng Bawang Khas Batam", cookStep: <#T##[String]#>, ingredient: <#[IngredientSample]#>)]
    
}


