//
//  RecipeListItemView.swift
//  ambis-reborn
//
//  Created by Rio Sudarsono on 29/07/21.
//

import SwiftUI

struct RecipeListItemView: View {
    
    var recipe: String
    
    var body: some View {
        ZStack {
            HStack {
    //            Image("appicon").cornerRadius(10)
                Text("Image")
                    .padding(.vertical, 40)
                    .padding(.horizontal,30)
                    .background(Color.gray)
                    .cornerRadius(10)
                VStack(alignment: .leading, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/, content: {
                    Text("Ayam Bumbu Kemenyan").bold().font(.system(size: 14)).padding(.bottom, 16).foregroundColor(.primary)
                    Text("Dessert")
                        .font(.system(size: 12)).foregroundColor(.primary)
                })
                Spacer(minLength: 0)
                VStack(alignment: .leading, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/, content: {
                    HStack{
                        Image(systemName: "person")
                        Text("Intermediate").font(.system(size: 14)).foregroundColor(.primary)
                    }
                    HStack{
                        Image(systemName: "clock")
                        Text("5 Min").font(.system(size: 14)).foregroundColor(.primary)
                    }.padding(.vertical, 4)
                    HStack{
                        Image(systemName: "circle.grid.cross")
                        Text("Stove, Pan").font(.system(size: 14)).foregroundColor(.primary)
                    }
                })
            }
            .padding(.all, 8)
            .background(RoundedRectangle(cornerRadius:15).fill(Color("BoxBackground")))
//            .shadow(radius: 3)
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 4)
    }
}

struct RecipeListItemView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListItemView(recipe: "asd")
    }
}
