//
//  RecipeView.swift
//  ambis-reborn
//
//  Created by Muhammad Rizki Miftha Alhamid on 7/29/21.
//

import SwiftUI

struct RecipeView: View {
    
    var recipe: RecipeModel
    //var recipe: RecipeSample
    @State var isCookingStepPresented: Bool = false
    
    var body: some View {
        //REMOVE USING CLOUDKIT
        Text("")
//        VStack {
//            ScrollView {
//                ImagePlaceholder()
//                RecipeTitle(name: recipe.name)
//                RecipeDescription(totalServes: recipe.totalServes, prepTime: recipe.prepTime, cookTime: recipe.cookTime, difficultyLevel: recipe.difficultyLevel)
//                Divider()
//                IngredientListView(ingredients: recipe.ingredient)
//            }
//                Spacer()
//            CookingStepButtonView(cookingSteps: recipe.cookStep)
//        }
//        .padding(.horizontal)
//        .navigationBarTitleDisplayMode(.large)
//        .navigationBarTitle(Text("Recipe"))
//        .sheet(isPresented: $isCookingStepPresented) {
//            CookingStepView(cookingStepSample: recipe.cookStep)
//        }
//        .background(Color("AppBackground"))
    }
    
    
}

struct RecipeTitle: View {
    var name: String
    var body: some View {
        HStack {
            Text(name)
                .font(.system(size: 21))
                .fontWeight(.semibold)
                .multilineTextAlignment(.leading)
            Spacer()
        }
        //.padding(.top)
    }
}

struct ImagePlaceholder: View {
    var body: some View {
        Image("foodImageSample")
            .resizable()
            .frame(minWidth: UIScreen.screenWidth - 30, minHeight: UIScreen.screenHeight / 3.7)
            .aspectRatio(contentMode: .fit)
            .mask(
                RoundedRectangle(cornerRadius: 25)
            )
            .padding(.top)
    }
}

struct RecipeDescription: View {
    var totalServes: Int
    var prepTime: Int
    var cookTime: Int
    var difficultyLevel: String
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "person")
                    .foregroundColor(Color(red: 253/255, green: 141/255, blue: 53/155))
                Text("\(totalServes) serve")
                    .font(.system(size: 15))
            }.padding(.trailing)
            HStack {
                Image(systemName: "clock")
                    .foregroundColor(Color(red: 253/255, green: 141/255, blue: 53/155))
                Text("\(prepTime + cookTime) mins")
                    .font(.system(size: 15))
            }.padding(.trailing)
            HStack {
                Image(systemName: "circle.grid.cross")
                    .foregroundColor(Color(red: 253/255, green: 141/255, blue: 53/155))
                Text("\(difficultyLevel)")
                    .font(.system(size: 15))
            }.padding(.trailing)
            Spacer()
        }.padding([.vertical, .trailing])
        
    }
}

struct IngredientListView: View {
    let ingredients: [IngredientModel]
    //let ingredients: [IngredientSample]
    
    var body: some View {
        VStack {
            HStack {
                Text("Ingredients")
                    .font(.system(size: 19))
                    .fontWeight(.medium)
                Spacer()
                Text("\(ingredients.count) item(s)")
                    .foregroundColor(Color("BrandColor"))
                    .font(.system(size: 15))
            }
            ForEach(0..<ingredients.count) { data in
                IngredientListCellView(ingredient: ingredients[data])
                //IngredientListCellView(ingredient: ingredients[data])
            }
        }
    }
}

struct CookingStepButtonView: View {
    var cookingSteps: [String]
    
    var body: some View {
        Button {
            //isCookingStepPresented = true
        } label: {
            NavigationLink(destination: CookingStepView(cookingStepSample: cookingSteps)) {
                HStack {
                    Spacer()
                    Text("How to cook")
                        .font(.system(size: 18, design: .rounded))
                        .foregroundColor(Color("BackgroundInverse"))
                    Spacer()
                }
            }
            .contentShape(Rectangle())
        }
        .frame(width: UIScreen.screenWidth - 30, height: 50, alignment: .center)
        .background(Color("BrandColor"))
        .cornerRadius(15)
        //.padding(.horizontal, 15)
        .padding(.bottom, 15)
    }
}

//struct RecipeView_Previews: PreviewProvider {
//    static var previews: some View {
//        RecipeView()
//    }
//}
