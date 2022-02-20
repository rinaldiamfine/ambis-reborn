//
//  RecipeListItemCloudKitView.swift
//  ambis-reborn
//
//  Created by Rinaldi LNU on 11/08/21.
//

import SwiftUI

struct RecipeListItemCloudKitView: View {
    var recipe: RecipeCloudKitModel
    
    func setupImage(url: URL) -> NSData {
        guard let imageData = NSData(contentsOf: url) else {
            return NSData()
        }
        return imageData
    }
    
    var body: some View {
        ZStack {
            HStack {
                ZStack {
//                    Image(uiImage: UIImage(data: setupImage(url: recipe.photo.fileURL!) as Data)!)
//                        .resizable()
//                        .frame(width: 80, height: 80, alignment: .center)
//                        .aspectRatio(contentMode: .fit)
//                        .cornerRadius(10)
                }
                VStack(alignment: .leading, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/, content: {
                    Text(recipe.name)
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
                            
                        Text(recipe.difficultyLevel).font(.system(size: 12))
                        .foregroundColor(Color.init(.systemGray))
                    }.padding(.top, 6)
                    Spacer()
                })
            }
            .padding(.all, 8)
            .background(RoundedRectangle(cornerRadius:15).fill(Color("BoxBackground")))
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 4)
    }
}
