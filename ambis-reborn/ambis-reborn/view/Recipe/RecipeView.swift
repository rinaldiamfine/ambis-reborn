//
//  RecipeView.swift
//  ambis-reborn
//
//  Created by Muhammad Rizki Miftha Alhamid on 7/29/21.
//

import SwiftUI

struct RecipeView: View {
    
    @State private var segmentedPicker = 1
    
    func getIconName() -> Image {
        return Image(systemName: "bag.fill")
    }
    func gettabName() -> Text {
        return Text("Recipe (sementara)")
    }
    
    let defaultRecipeSample = RecipeSample(name: "Ayam bumbu andaliman",
                                           prepTime: 10,
                                           cookTime: 30,
                                           cookMethod: "Bakar",
                                           cookStep: ["Siapkan bahan bahan",
                                                      "Bakar ayam",
                                                      "Beri bumbu"],
                                           totalServes: 1,
                                           ingredient: [IngredientSample(name: "Ayam", total: 1, totalType: "kg", isAvailable: false),
                                                        IngredientSample(name: "Bawang", total: 2, totalType: "biji", isAvailable: true)])
    
    var body: some View {
        NavigationView {
            VStack {
                RecipeTitle(name: defaultRecipeSample.name)
                ImagePlaceholder()
                RecipeDescription(totalServes: defaultRecipeSample.totalServes, prepTime: defaultRecipeSample.prepTime, cookTime: defaultRecipeSample.cookTime)
                Picker(selection: $segmentedPicker, label: Text(""), content: {
                    Text("Ingredients").tag(1)
                    Text("How to cook").tag(2)
                })
                .pickerStyle(SegmentedPickerStyle())
                if segmentedPicker == 1 {
                    IngredientListView(ingredientsSample: defaultRecipeSample.ingredient)
                } else {
                    CookingStepListView(cookingStepSample: defaultRecipeSample.cookStep)
                }
            }
            .padding()
            .navigationBarTitleDisplayMode(.inline)
            //.navigationBarTitle(Text("Ayam Madu"))
        }
        
    }
}

struct RecipeTitle: View {
    var name: String
    var body: some View {
        Text(name)
            .font(.system(size: 28))
            .bold()
    }
}

struct ImagePlaceholder: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10).stroke()
            Text("Image Placeholder")
        }
    }
}

struct RecipeDescription: View {
    var totalServes: Int
    var prepTime: Int
    var cookTime: Int
    
    var body: some View {
        HStack {
            VStack {
                ZStack {
                    Circle()
                        .foregroundColor(.green)
                        .frame(width: 40, height: 40)
                    Text("\(totalServes)")
                }
                Text("Serve")
                    .font(.system(size: 15))
                    .frame(maxWidth: .infinity)
            }
            VStack {
                ZStack {
                    Circle()
                        .foregroundColor(.green)
                        .frame(width: 40, height: 40)
                    Text("\(prepTime)")
                }
                Text("Prep Time")
                    .font(.system(size: 15))
                    .frame(maxWidth: .infinity)
            }
            VStack {
                ZStack {
                    Circle()
                        .foregroundColor(.green)
                        .frame(width: 40, height: 40)
                    Text("\(cookTime)")
                }
                Text("Cook Time")
                    .font(.system(size: 15))
                    .frame(maxWidth: .infinity)
            }
        }
    }
}

struct IngredientListView: View {
    let ingredientsSample: [IngredientSample]
    
    var body: some View {
        ScrollView {
            ForEach(0..<ingredientsSample.count) { tes in
                IngredientListCellView(ingredient: ingredientsSample[tes])
            }
        }
    }
}

struct CookingStepListView: View {
    let cookingStepSample: [String]
    
    var body: some View {
        ScrollView {
            ForEach(0..<cookingStepSample.count) { count in
                HStack {
                    VStack {
                        Circle()
                            .foregroundColor(.gray)
                            .frame(width: 40, height: 40)
                    }
                    VStack(alignment: .leading) {
                        Text("Step \(count + 1)")
                            .font(.system(size: 28))
                            .bold()
                        Text(cookingStepSample[count])
                            .multilineTextAlignment(.leading)
                    }
                    Spacer()
                }
            }
        }
    }
}

//tes
