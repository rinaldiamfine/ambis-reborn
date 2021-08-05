//
//  RecipeListItemView.swift
//  ambis-reborn
//
//  Created by Rio Sudarsono on 29/07/21.
//

import SwiftUI

struct RecipeListItemView: View {
    
    var recipe: RecipeSample
    
    var body: some View {
        ZStack {
            HStack {
    //            Image("appicon").cornerRadius(10)
                Text("Image")
                    .padding(.vertical, 40)
                    .padding(.horizontal,30)
                    .background(Color.init(.systemGray2))
                    .cornerRadius(10)
                VStack(alignment: .leading, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/, content: {
                    Text(recipe.name)
//                        .lineLimit(3)
//                        .fixedSize(horizontal: false, vertical: true)
                        .font(.system(size: 13))
                        .padding(.trailing, 10)
                        .padding(.bottom, 4)
                        .padding(.top, 20)
                        .foregroundColor(.primary)
                    Text(recipe.category)
                        .font(.system(size: 12))
                        .foregroundColor(Color.init(.systemGray))
                    Spacer()
                })
                Spacer(minLength: 0)
                VStack(alignment: .leading, spacing: 2, content: {
                    Spacer()
                    HStack{
                        Image(systemName: "person")
                            .resizable()
                            .frame(width: 12, height: 12, alignment: .center)
                        
                        Text("\(recipe.totalServes) serve").font(.system(size: 12))
                        .foregroundColor(Color.init(.systemGray))
                    }.padding(.bottom, 6)
                    HStack{
                        Image(systemName: "clock")
                            .resizable()
                            .frame(width: 12, height: 12, alignment: .center)
                            
                        let time = recipe.prepTime + recipe.cookTime
                        Text("\(time) mins").font(.system(size: 12))
                        .foregroundColor(Color.init(.systemGray))
                    }
                    HStack{
                        Image(systemName: "circle.grid.cross")
                            .resizable()
                            .frame(width: 12, height: 12, alignment: .center)
                            
                        Text(recipe.level).font(.system(size: 12))
                        .foregroundColor(Color.init(.systemGray))
                    }.padding(.top, 6)
                    Spacer()
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

//struct RecipeListItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        RecipeListItemView(recipe: "asd")
//    }
//}
