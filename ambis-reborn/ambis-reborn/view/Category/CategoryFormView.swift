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
    var foodCategory: FoodCategoryModel
    
    var body: some View {
        VStack {
            ZStack {
                Ellipse()
                    .fill(Color.init(UIColor.systemGray5))
                    .frame(width: 86, height: 86)
                Text(foodCategory.imageString)
                    .font(.system(size: 38))
            }.padding()
            Text(foodCategory.name)
                .font(.system(size: 22))
                .bold()
            Text(foodCategory.subtitle)
                .font(.system(size: 14))
                .multilineTextAlignment(.center)
                .foregroundColor(Color.init(UIColor.systemGray))
                .lineSpacing(/*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                .padding()
            Text(foodCategory.estimation)
                .font(.system(size: 17))
                .multilineTextAlignment(.center)
                .foregroundColor(Color.init(UIColor.systemGreen))
                .lineSpacing(/*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
            Spacer()
        }
        .navigationBarTitle("Category", displayMode: .inline)
        .padding(.top, 20)
    }
}

//
//struct CategoryFormView_Previews: PreviewProvider {
//    static var previews: some View {
//        CategoryFormView()
//    }
//}
