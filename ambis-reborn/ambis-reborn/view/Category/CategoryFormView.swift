//
//  CategoryFormView.swift
//  ambis-reborn
//
//  Created by Rinaldi LNU on 09/07/21.
//

import SwiftUI

struct CategoryFormView: View {
    @ObservedObject var foodCategoryViewModel: FoodCategoryViewModel
    @Binding var isPresented: Bool
    @Binding var selectedCategory : Int
    
    func actionClose() {
        isPresented.toggle()
    }
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Ellipse()
                        .fill(Color.init(UIColor.systemGray5))
                        .frame(width: 86, height: 86)
                    Text(foodCategoryViewModel.foodCategories[selectedCategory].imageString)
                        .font(.system(size: 38))
                }
                .padding(.horizontal)
                .padding(.vertical)
                HStack {
                    Text(foodCategoryViewModel.foodCategories[selectedCategory].name)
                        .font(.system(size: 22, design: .rounded))
                        .bold()
                }
                .padding(.horizontal)
                .padding(.vertical)
                HStack {
                    Text(foodCategoryViewModel.foodCategories[selectedCategory].subtitle)
                        .font(.system(size: 14, design: .rounded))
                        .multilineTextAlignment(.leading)
                        .foregroundColor(Color.init(UIColor.systemGray))
                        .lineSpacing(10)
                }
                .padding(.horizontal)
                .padding(.vertical)
                HStack {
                    Text(foodCategoryViewModel.foodCategories[selectedCategory].estimation)
                        .font(.system(size: 17, design: .rounded))
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color.init(UIColor.systemGreen))
                        .lineSpacing(10)
                }
                .padding(.horizontal)
                .padding(.vertical)
                Spacer()
            }
            .padding(.horizontal)
            .navigationBarTitle("Category", displayMode: .inline)
            .navigationBarItems(
                trailing:
                    Button(action: actionClose, label: {
                        Text("Close")
                            .font(.system(.callout, design: .rounded))
                            .accentColor(Color("BackgroundInverse"))
                    })
            )
        }
    }
}

//
//struct CategoryFormView_Previews: PreviewProvider {
//    static var previews: some View {
//        CategoryFormView()
//    }
//}
