//
//  RecipeModel.swift
//  ambis-reborn
//
//  Created by Muhammad Rizki Miftha Alhamid on 8/6/21.
//

import Foundation
import CoreData
import SwiftUI
import UIKit

struct RecipeCloudKitModel: Identifiable {
    var id = UUID()
    var photo: NSObject?
    var tags: String = ""
    
    var name: String = ""
    var category: String = ""
    var totalServes: Int = 0
    var prepTime: Int = 0
    var cookTime: Int = 0
    var difficultyLevel: String = ""
    
    var ingredients: [String] = []
    var cookSteps: [String] = []
}

struct RecipeModel {
    let recipe: Recipe
    
    var id: NSManagedObjectID {
        return recipe.objectID
    }
    
    var ingredient: [IngredientModel] {
        var ingredient: [IngredientModel] = []
        for ingredientData in recipe.toIngredient ?? [] {
            ingredient.append(IngredientModel(ingredient: ingredientData as! Ingredient))
        }
        return ingredient
    }
    
    
    var name: String {
        return recipe.name ?? ""
    }
    
    var cookMethod: String {
        return recipe.cookMethod ?? ""
    }
    
    var cookStep: [String] {
        return recipe.cookStep as! [String]
    }
    
    var cookTime: Int {
        return Int(recipe.cookTime)
    }
    
    var difficultyLevel: String {
        return recipe.difficultyLevel ?? ""
    }
    
    var isFavorite: Bool {
        return recipe.isFavorite
    }
    
    var prepTime: Int {
        return Int(recipe.prepTime)
    }
    
    var recipeCategory: String {
        return recipe.recipeCategory ?? ""
    }
    
    var recipeImage: Data {
        return recipe.recipeImage ?? Data()
    }
    
    var totalServes: Int {
        return Int(recipe.totalServes)
    }
    
    
}
