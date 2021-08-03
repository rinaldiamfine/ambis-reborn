//
//  RecipeListView.swift
//  ambis-reborn
//
//  Created by Rio Sudarsono on 29/07/21.
//

import SwiftUI

struct RecipeListView: View {
    
    @State var toSort = false
    @State var sortDish: [RecipeSort] = [
        RecipeSort(id: "", name: "Appetizer", isChoose: true),
        RecipeSort(id: "", name: "Main Dish", isChoose: true),
        RecipeSort(id: "", name: "Dessert", isChoose: true)]
    @State var sortPortion: [RecipeSort] = [
        RecipeSort(id: "", name: "From lowest to highest", isChoose: true),
        RecipeSort(id: "", name: "From highest to lowest", isChoose: true)]
    @State var sortEquipment: [RecipeSort] = [
        RecipeSort(id: "", name: "Stove", isChoose: true),
        RecipeSort(id: "", name: "Microwave", isChoose: true),
        RecipeSort(id: "", name: "Oven", isChoose: true)]
    
    var dummy: [String] = ["", "", "", "", "", ""]
    
    var body: some View {
        VStack(alignment: .leading, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/, content: {
            HStack{
                Text("5 Recipes Available")
                Spacer()
                HStack {
                    Text("Sort").foregroundColor(Color("AccentColor"))
                    Image(systemName: "arrow.up.arrow.down").foregroundColor(Color("AccentColor"))
                }.onTapGesture {
                    toSort = true
                }
            }.padding(.all, 12)
            ScrollView {
                ForEach(0..<dummy.count) { data in
                    NavigationLink(destination: RecipeView()) {
                        RecipeListItemView(recipe: dummy[data])
                    }
                }
            }
            Spacer()
        }).sheet(isPresented: $toSort, content: {
            RecipeSortView(toSort: $toSort, sortDish: $sortDish,sortPortion: $sortPortion, sortEquipment: $sortEquipment)
        })
        .background(Color("AppBackground"))
        .navigationBarTitle("Recipe", displayMode: .automatic)
       
    }
    
}

//struct RecipeListView_Previews: PreviewProvider {
//    static var previews: some View {
//        RecipeListView()
//    }
//}
