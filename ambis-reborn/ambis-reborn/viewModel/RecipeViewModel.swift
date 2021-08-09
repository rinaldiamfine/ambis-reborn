//
//  RecipeViewModel.swift
//  ambis-reborn
//
//  Created by Muhammad Rizki Miftha Alhamid on 8/9/21.
//

import Foundation
import UIKit
import CoreData

class RecipeViewModel: ObservableObject {
    
    @Published var recipe: [RecipeModel] = []
    
    @Published var toSort = false
    @Published var sortDish: [RecipeSort] = [
        RecipeSort(id: "", name: "Appetizer", isChoose: true),
        RecipeSort(id: "", name: "Main Dish", isChoose: true),
        RecipeSort(id: "", name: "Dessert", isChoose: true),
        RecipeSort(id: "", name: "Beverage", isChoose: true)]
    @Published var sortPortion: [RecipeSort] = [
        RecipeSort(id: "", name: "From lowest to highest", isChoose: true),
        RecipeSort(id: "", name: "From highest to lowest", isChoose: true)]
    @Published var sortEquipment: [RecipeSort] = [
        RecipeSort(id: "", name: "Stove", isChoose: true),
        RecipeSort(id: "", name: "Microwave", isChoose: true),
        RecipeSort(id: "", name: "Oven", isChoose: true)]
    
    func saveRecipeData() {
        let dataRecipe = DataRecipe.recipes
        
        for data in dataRecipe {
            let recipe = Recipe(context: PersistenceController.shared.container.viewContext)
            let ingredient = Ingredient(context: PersistenceController.shared.container.viewContext)
            
            recipe.name = data.name
            recipe.cookStep = data.cookStep
            for dataIngredient in data.ingredient {
                ingredient.name = dataIngredient.name
                recipe.addToToIngredient(ingredient)
            }
            
            PersistenceController.shared.saveData()
        }
    }
    
    
    
}
