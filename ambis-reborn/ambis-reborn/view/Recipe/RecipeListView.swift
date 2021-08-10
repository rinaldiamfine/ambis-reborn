//
//  RecipeListView.swift
//  ambis-reborn
//
//  Created by Rio Sudarsono on 29/07/21.
//

import SwiftUI

struct RecipeListView: View {
    @StateObject var recipeViewModel = RecipeViewModel()
    var tags : [String]
    var dataRecipe = DataRecipe.recipes
    
    func mapDataRecipe() {
        print(tags, "TAGES")
    }
    
    var body: some View {
        ZStack {
            VStack{
                VStack {}
                .frame(
                      minWidth: 0,maxWidth: .infinity,
                      minHeight: 0,maxHeight: 100,
                      alignment: .topLeading
                    )
                .background(
                    Rectangle()
                        .fill(LinearGradient(gradient: .init(colors: [Color("Gradient1"), Color("Gradient2")]), startPoint: .init(x: 0, y: 0.1), endPoint: .init(x: 0, y: 1)))
                    )
                Spacer()
            }
            VStack(alignment: .leading, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/, content: {
                HStack{
                    Text("5 Recipes Available")
                    Spacer()
                    HStack {
                        Text("Sort").foregroundColor(Color("AccentColor"))
                        Image(systemName: "arrow.up.arrow.down").foregroundColor(Color("AccentColor"))
                    }.onTapGesture {
                        recipeViewModel.toSort = true
                    }
                }.padding(.all, 12)
                ScrollView {
//                    ForEach(0..<dataRecipe.count) { data in
//                        NavigationLink(destination: RecipeView(recipe: dataRecipe[data])) {
//                            RecipeListItemView(recipe: dataRecipe[data])
//                        }
//                    }
//                    ForEach(0..<recipeViewModel.recipe.count) { data in
//                        NavigationLink(destination: RecipeView(recipe: recipeViewModel.recipe[data])) {
//                            RecipeListItemView(recipe: recipeViewModel.recipe[data])
//                        }
//                    }
                    ForEach(recipeViewModel.recipe, id:\.id) { recipe in
                        NavigationLink(destination: RecipeView(recipe: recipe)) {
                            RecipeListItemView(recipe: recipe)
                        }
                    }

                }
                Spacer()
            }).sheet(isPresented: $recipeViewModel.toSort, content: {
                RecipeSortView(toSort: $recipeViewModel.toSort, sortDish: $recipeViewModel.sortDish, sortPortion: $recipeViewModel.sortPortion, sortEquipment: $recipeViewModel.sortEquipment)
            })
            
        }
        .background(Color("AppBackground"))
        .navigationBarTitle("Recipe", displayMode: .automatic)
        .onAppear(perform: {
            recipeViewModel.getAllRecipe()
            //print(recipeViewModel.recipe[0], "Mantap")
            print(recipeViewModel.recipeCount)
            mapDataRecipe()
        })
    }
    
}

//struct RecipeListView_Previews: PreviewProvider {
//    static var previews: some View {
//        RecipeListView()
//    }
//}
