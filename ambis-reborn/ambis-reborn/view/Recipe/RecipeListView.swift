//
//  RecipeListView.swift
//  ambis-reborn
//
//  Created by Rio Sudarsono on 29/07/21.
//

import SwiftUI

struct RecipeListView: View {
    
    var dummy: [String] = ["", "", "", "", "", ""]
    
    var body: some View {
        VStack(alignment: .leading, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/, content: {
            HStack{
                Text("5 Recipes Available")
                Spacer()
                Text("Filter")
            }
            ScrollView {
                ForEach(0..<dummy.count) { data in
                    NavigationLink(destination: RecipeListView()) {
                        RecipeListItemView(recipe: dummy[data])
                    }
                }
            }
            Spacer()
        })
        .padding(.all, 12)
        .navigationBarTitle("Recipe", displayMode: .inline)
    }
    
}

struct RecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListView()
    }
}
