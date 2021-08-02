//
//  RecipeListView.swift
//  ambis-reborn
//
//  Created by Rio Sudarsono on 29/07/21.
//

import SwiftUI

struct RecipeListView: View {
    
    @State var toSort = false
    
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
            RecipeSortView(toSort: $toSort)
        })
        .background(Color("AppBackground"))
        .navigationBarTitle("Recipe", displayMode: .automatic)
       
    }
    
}

struct RecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListView()
    }
}
