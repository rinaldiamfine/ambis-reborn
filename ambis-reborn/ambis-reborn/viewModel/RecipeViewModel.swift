//
//  RecipeViewModel.swift
//  ambis-reborn
//
//  Created by Muhammad Rizki Miftha Alhamid on 8/9/21.
//

import Foundation
import UIKit
import CoreData
import CloudKit

class RecipeViewModel: ObservableObject, Identifiable {
    @Published var recipes: [RecipeCloudKitModel] = []
    let database = CKContainer(identifier: "iCloud.icloud.keepfresh").publicCloudDatabase
    
    func fetchRecipes(tags: [String]) {
        let query = CKQuery(recordType: "Recipes", predicate: NSPredicate(format: "tags IN %@", tags))
//        let query = CKQuery(recordType: "Recipes", predicate: NSPredicate(value: true))
        database.perform(query, inZoneWith: .default) { ckRecord, error in
            guard let records = ckRecord, error == nil else { return }
            DispatchQueue.main.async {
                self.recipes = records.compactMap { ck in
                    RecipeCloudKitModel(
                        id: UUID(),
                        photo: ck["photo"] as! CKAsset,
                        tags: ck["tags"] as! String,
                        name: ck["name"] as! String,
                        category: ck["category"] as! String,
                        totalServes: ck["totalServes"] as! Int,
                        prepTime: ck["prepTime"] as! Int,
                        cookTime: ck["cookTime"] as! Int,
                        difficultyLevel: ck["difficultyLevel"] as! String,
                        ingredients: ck["ingredients"] as! [String],
                        cookSteps: ck["cookSteps"] as! [String]
                    )
                }
            }
            print(self.recipe, "CHECK DATA RECIPES")
        }
        print(self.recipe, "CHECK DATA RECIPES OUTS")
    }
    
    @Published var recipe: [RecipeModel] = []
    @Published var recipeCount: Int = 0
    
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
    
//    init() {
//        saveRecipeData()
//    }
    
    func saveRecipeData() {
        let dataRecipe = DataRecipe.recipes
        
        for data in dataRecipe {
            let recipe = Recipe(context: PersistenceController.shared.container.viewContext)
            
            recipe.name = data.name
            recipe.cookStep = data.cookStep
            for dataIngredient in data.ingredient {
                let ingredient = Ingredient(context: PersistenceController.shared.container.viewContext)
                
                ingredient.name = dataIngredient.name
                ingredient.toRecipe = recipe
            }
            //print(recipe.toIngredient)
            PersistenceController.shared.saveData()
        }
        print("save succesful")
    }
    
    func getAllRecipe() {
        if !UserDefaults.standard.isRecipeLoad() {
            saveRecipeData()
            UserDefaults.standard.setRecipeLoad(value: true)
        }
        recipe = PersistenceController.shared.getRecipeData().map(RecipeModel.init)
        recipeCount = recipe.count
    }
    
}
