//
//  RecipeCloudKitView.swift
//  ambis-reborn
//
//  Created by Rinaldi LNU on 11/08/21.
//

import SwiftUI

struct RecipeCloudKitView: View {
    var recipe: RecipeCloudKitModel
    @State var isCookingStepPresented: Bool = false
    
    func setupImage(url: URL) -> NSData {
        guard let imageData = NSData(contentsOf: url) else {
            return NSData()
        }
        return imageData
    }
    
    var body: some View {
        VStack {
            ScrollView {
//                Image(uiImage: UIImage(data: setupImage(url: recipe.photo.fileURL!) as Data)!)
//                    .resizable()
//                    .frame(width: UIScreen.screenWidth - 30, height: UIScreen.screenHeight / 3.7, alignment: .center)
//                    .aspectRatio(contentMode: .fit)
//                    .cornerRadius(25)
//                    .padding(.top)
//                    .padding(.horizontal)
                
                HStack {
                    Text(recipe.name)
                        .font(.system(size: 21))
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
                .padding(.horizontal)
                
                HStack {
                    HStack {
                        Image(systemName: "person")
                            .foregroundColor(Color(red: 253/255, green: 141/255, blue: 53/155))
                        Text("\(recipe.totalServes) serve")
                            .font(.system(size: 15))
                    }
                    .padding(.trailing)
                    
                    HStack {
                        Image(systemName: "clock")
                            .foregroundColor(Color(red: 253/255, green: 141/255, blue: 53/155))
                        Text("\(recipe.prepTime + recipe.cookTime) mins")
                            .font(.system(size: 15))
                    }
                    .padding(.trailing)
                    
                    HStack {
                        Image(systemName: "circle.grid.cross")
                            .foregroundColor(Color(red: 253/255, green: 141/255, blue: 53/155))
                        Text("\(recipe.difficultyLevel)")
                            .font(.system(size: 15))
                    }
                    .padding(.trailing)
                    Spacer()
                }
                .padding([.vertical, .trailing])
                .padding(.horizontal)
                
                Divider()
                VStack {
                    HStack {
                        Text("Ingredients")
                            .font(.system(size: 19))
                            .fontWeight(.medium)
                        Spacer()
                        Text("\(recipe.ingredients.count) item(s)")
                            .foregroundColor(Color("BrandColor"))
                            .font(.system(size: 15))
                    }
                    
                    ForEach(0..<recipe.ingredients.count) { data in
                        HStack {
                            Circle()
                                .foregroundColor(.gray)
                                .frame(width: 46, height: 46)
                            Text(recipe.ingredients[data])
                                .font(.system(size: 16))
                            Spacer()
//                            Text("\(ingredient.total)  \(ingredient.totalType)")
//                                .font(.system(size: 13))
//                                .foregroundColor(Color.init(.systemGray))
                        }
                    }
                }
                .padding(.horizontal)
            }
            Spacer()
            Button {
                //
            } label: {
                NavigationLink(destination: CookingStepCloudKitView(recipe: recipe)) {
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
            .padding(.bottom, 15)
        }
        .navigationBarTitleDisplayMode(.large)
        .navigationBarTitle(Text("Recipe Details"))
        .background(Color("AppBackground"))
    }
}

struct CookingStepCloudKitView: View {
    var recipe: RecipeCloudKitModel
    @Environment(\.presentationMode) var presentationMode
    
    func setupImage(url: URL) -> NSData {
        guard let imageData = NSData(contentsOf: url) else {
            return NSData()
        }
        return imageData
    }
    
    var body: some View {
        VStack {
            ScrollView {
//                Image(uiImage: UIImage(data: setupImage(url: recipe.photo.fileURL!) as Data)!)
//                    .resizable()
//                    .frame(width: UIScreen.screenWidth - 30, height: UIScreen.screenHeight / 3.7, alignment: .center)
//                    .aspectRatio(contentMode: .fit)
//                    .cornerRadius(25)
//                    .padding(.vertical)
//                    .padding(.horizontal)
                
                ForEach(0..<recipe.cookSteps.count) { count in
                    ZStack {
                        RoundedRectangle(cornerRadius: 25)
                            .foregroundColor(Color("BoxBackground"))
                        HStack {
                            VStack {
                                Circle()
                                    .foregroundColor(.gray)
                                    .frame(width: 25, height: 25)
                                    .padding(.top)
                                    .offset(x: 0, y: -15)
                                Spacer()
                            }
                            VStack(alignment: .leading) {
                                Text("Step \(count + 1)")
                                    .font(.system(size: 19))
                                    .fontWeight(.semibold)
                                Text(recipe.cookSteps[count])
                                    .font(.system(size: 16))
                                    .multilineTextAlignment(.leading)
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            Spacer()
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 25)
                                .strokeBorder(Color("BrandColor"), lineWidth: 1)
                        )
                        .frame(maxHeight: .infinity)
                    }
                    .padding(.horizontal)
                }
            }
            Spacer()
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Done")
                    .font(.system(size: 18, design: .rounded))
                    .foregroundColor(Color("BackgroundInverse"))
                    .contentShape(Rectangle())
                    .frame(width: UIScreen.screenWidth - 30, height: 50, alignment: .center)
                    .background(Color("BrandColor"))
                    .cornerRadius(15)
                    .padding(.bottom, 15)
            }
        }
        .navigationBarTitle("Cooking Steps")
        .padding(.horizontal)
        .background(Color("AppBackground"))
    }
}
