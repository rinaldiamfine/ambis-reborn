//
//  IngredientModel.swift
//  ambis-reborn
//
//  Created by Muhammad Rizki Miftha Alhamid on 8/6/21.
//

import Foundation
import CoreData

struct IngredientModel {
    let ingredient: Ingredient
    
    var id: NSManagedObjectID {
        return ingredient.objectID
    }
    
    var recipe: Recipe {
        return ingredient.toRecipe ?? Recipe()
    }
    
    var name: String {
        return ingredient.name ?? ""
    }
    
    var total: Double {
        return ingredient.total
    }
    
    var totalType: String {
        return ingredient.totalType ?? ""
    }
}
