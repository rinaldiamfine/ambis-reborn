//
//  FoodCategoryModel.swift
//  ambis-reborn
//
//  Created by Rinaldi LNU on 10/07/21.
//

import Foundation
import CoreData

struct FoodCategoryModel {
    let foodCategory: FoodCategory
    
    var id: NSManagedObjectID {
        return foodCategory.objectID
    }
    
    var name: String {
        return foodCategory.name ?? ""
    }
    var subtitle: String {
        return foodCategory.subtitle ?? ""
    }
    var estimation: String {
        return foodCategory.estimation ?? ""
    }
    var expiryEstimation: Int64 {
        return foodCategory.expiryEstimation
    }
    var imageString: String {
        return foodCategory.imageString ?? ""
    }
    var imageData: Data {
        return foodCategory.imageData ?? Data()
    }
    //UUID
    //ID
}

struct DefalutFoodCategory {
    let name: String
    let iconString: String
    let subtitle: String
    let estimation: String
    let expiryEstimation: Int64
    
    static func generateDefaultCategory() -> [DefalutFoodCategory] {
        var defaultFoodCategories = [DefalutFoodCategory]()
        defaultFoodCategories.append(DefalutFoodCategory(name: "Meat", iconString: "🥩", subtitle: "Meat includes any type of land creatures and amphibians, including but are not limited to chicken, turkey, beef, pork, deer, rabbit, frog, alligator, etc.", estimation: "Open air: 1 Day\nFridge: 5 Days\nFreezer: 8 Months", expiryEstimation: 5))
        defaultFoodCategories.append(DefalutFoodCategory(name: "Fish & Seafood", iconString: "🍤", subtitle: "Fish includes saltwater fish as well as freshwater fish. Seafood refers to any creature that resides in the ocean, such as shrimps, shellfishes, crabs, etc.", estimation: "Open air: 1 day\nFridge: 2 days\nFreezer: 6 months", expiryEstimation: 2))
        defaultFoodCategories.append(DefalutFoodCategory(name: "Vegetable & Mushroom", iconString: "🥦", subtitle: "Green Vegetable are easy to spoil if not refrigerated, whereas root vegetables such as onion, potato, etc last longer even in room temperatures.", estimation: "Open air: 1 Day\nFridge: 7 Days\nFreezer: 8 Months", expiryEstimation: 7))
        defaultFoodCategories.append(DefalutFoodCategory(name: "Fruit", iconString: "🍒", subtitle: "Not every fruit has to be stored in a fridge. Fruits such as avocado and banana is better off stored in room temperature.\nFruits with high sugar and water content such as grapes, pears, mangoes, melons, etc should be refrigerated.", estimation: "Open Air: 1 day\nFridge: 7 days\nFreezer: 6 Months", expiryEstimation: 7))
        defaultFoodCategories.append(DefalutFoodCategory(name: "Canned & Dried Food", iconString: "🥫", subtitle: "Canned and dried food can last for months, if not years. Dried food can last long because of the lack of water, which inhibits bacterial growth.\nCanned food can last indefinitely as long as the can is kept in good condition, in a dark and cool place.\nAlthough canned and dried food may last indefinitely, it may experience a change in flavor or texture, and the nutritional value may also deteriorate over time.\nGenerally, you should follow the use by date provided at the packaging.", estimation: "Follow the use by/expiry date written on the label of the packaging", expiryEstimation: 365))
        defaultFoodCategories.append(DefalutFoodCategory(name: "Spice & Condiment", iconString: "🧂", subtitle: "Dried spices and herbs can last for about 1-4 years.\nFresh herbs and spices, on the other hand, generally lasts for about 1-2 weeks in the fridge.\nCondiments generally last indefinitely, but it is suggested to follow the use by date provided in the packaging.", estimation: "Follow the use by/expiry date written on the label of the packaging", expiryEstimation: 365))
        defaultFoodCategories.append(DefalutFoodCategory(name: "Egg & Dairy Products", iconString: "🧀", subtitle: "Dairy product is a type of food produced from, or containing the milk of mammals such as cow, sheep, goats, etc. Dairy products include food items such as milk, yogurt, cheese, and butter.\nPasteurized milk will last for about 2-5 days in the fridge.\nHeavy cream, yogurt, and soft cheeses such as Fresh Mozzarella and Cottage Cheese will last for about 1 week after opened.\nHard cheeses such as Parmesan can last for about a month after it is opened.\nFresh eggs can be refrigerated for up to 6 weeks, but it is best to follow the use by date provided in the packaging.", estimation: "Follow the use by/expiry date written on the label of the packaging", expiryEstimation: 7))
        defaultFoodCategories.append(DefalutFoodCategory(name: "Other", iconString: "📦", subtitle: " ", estimation: " ", expiryEstimation: 0))
        return defaultFoodCategories
    }
}
