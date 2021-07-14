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
                }.padding()
                Text(foodCategoryViewModel.foodCategories[selectedCategory].name)
                    .font(.system(size: 22))
                    .bold()
                    .padding()
                Text(foodCategoryViewModel.foodCategories[selectedCategory].subtitle)
                    .font(.system(size: 14))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color.init(UIColor.systemGray))
                    .lineSpacing(/*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                    .padding()
                Text(foodCategoryViewModel.foodCategories[selectedCategory].estimation)
                    .font(.system(size: 17))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color.init(UIColor.systemGreen))
                    .lineSpacing(/*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                    .padding()
                Spacer()
            }
            .navigationBarTitle("Category", displayMode: .inline)
            .navigationBarItems(
                trailing:
                    Button(action: actionClose, label: {
                        Text("Close")
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
