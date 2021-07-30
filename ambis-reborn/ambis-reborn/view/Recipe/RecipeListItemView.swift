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
                    Text("Ayam Bumbu Kemenyan").font(.system(size: 14)).padding(.bottom, 16)
                    Text("2 Ingredients Missing")
                        .foregroundColor(.red)
                        .font(.system(size: 12))
                })
                Spacer(minLength: 0)
                VStack(alignment: .leading, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/, content: {
                    HStack{
                        Circle()
                            .foregroundColor(.gray)
                            .frame(width: 24, height: 24)
                        Text("Intermediate").font(.system(size: 14))
                    }
                    HStack{
                        Circle()
                            .foregroundColor(.gray)
                            .frame(width: 24, height: 24)
                        Text("5 Min").font(.system(size: 14))
                    }
                    HStack{
                        Circle()
                            .foregroundColor(.gray)
                            .frame(width: 24, height: 24)
                        Text("Stove, Pan").font(.system(size: 14))
                    }
                })
            }
            .padding(.all, 8)
            .background(Color.init(UIColor.systemGray5))
            .cornerRadius(8)
            .shadow(radius: 3)
        }.padding(.all, 4)
    }
}

struct RecipeListItemView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListItemView(recipe: "asd")
    }
}
