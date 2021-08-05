//
//  RecipeView.swift
//  ambis-reborn
//
//  Created by Muhammad Rizki Miftha Alhamid on 7/29/21.
//

import SwiftUI

struct RecipeView: View {
    
    @State var isCookingStepPresented: Bool = false
    
    func getIconName() -> Image {
        return Image(systemName: "bag.fill")
    }
    func gettabName() -> Text {
        return Text("Recipe (sementara)")
    }
    
    let defaultRecipeSample = DataRecipe.recipes
    //
    //    let defaultRecipeSample = RecipeSample(name: "Ayam bumbu andaliman",
    //                                           prepTime: 10,
    //                                           cookTime: 30,
    //                                           cookMethod: "Bakar",
    //                                           cookStep: ["Siapkan bahan bahan",
    //                                                      "Bakar ayam",
    //                                                      "Beri bumbu"],
    //                                           totalServes: 1,
    //                                           ingredient: [IngredientSample(name: "Ayam", total: 1, totalType: "kg", isAvailable: false),
    //                                                        IngredientSample(name: "Bawang", total: 2, totalType: "biji", isAvailable: true)])
    
    var body: some View {
        
        VStack {
            ImagePlaceholder()
            RecipeTitle(name: defaultRecipeSample[0].name)
            RecipeDescription(totalServes: defaultRecipeSample[0].totalServes, prepTime: defaultRecipeSample[0].prepTime, cookTime: defaultRecipeSample[0].cookTime)
            Divider()
            ZStack {
                IngredientListView(ingredientsSample: defaultRecipeSample[0].ingredient)
                VStack {
                    Spacer()
                    CookingStepButtonView(cookingSteps: defaultRecipeSample[0].cookStep)
                }
            }
        }
        .padding(.horizontal)
        .navigationBarTitleDisplayMode(.large)
        .navigationBarTitle(Text("Recipe"))
        .sheet(isPresented: $isCookingStepPresented) {
            CookingStepView(cookingStepSample: defaultRecipeSample[0].cookStep)
        }
        .background(Color("AppBackground"))
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
            .aspectRatio(contentMode: .fit)
            .mask(
                RoundedRectangle(cornerRadius: 25)
                    .frame(maxHeight: 220)
            )
            .padding(.top)
    }
}

struct RecipeDescription: View {
    var totalServes: Int
    var prepTime: Int
    var cookTime: Int
    
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
                Text("\(prepTime) mins")
                    .font(.system(size: 15))
            }.padding(.trailing)
            HStack {
                Image(systemName: "circle.grid.cross")
                    .foregroundColor(Color(red: 253/255, green: 141/255, blue: 53/155))
                Text("intermediate")
                    .font(.system(size: 15))
            }.padding(.trailing)
            Spacer()
        }.padding([.vertical, .trailing])
        
    }
}

struct IngredientListView: View {
    let ingredientsSample: [IngredientSample]
    
    var body: some View {
        VStack {
            HStack {
                Text("Ingredients")
                    .font(.system(size: 19))
                    .fontWeight(.medium)
                Spacer()
                Text("\(ingredientsSample.count) item(s)")
                    .foregroundColor(Color("BrandColor"))
                    .font(.system(size: 15))
            }
            ScrollView {
                ForEach(0..<ingredientsSample.count) { tes in
                    IngredientListCellView(ingredient: ingredientsSample[tes])
                }
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

struct RecipeView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView()
    }
}
