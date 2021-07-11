//
//  CategoryCellView.swift
//  ambis-reborn
//
//  Created by Rinaldi LNU on 06/07/21.
//

import SwiftUI

struct CategoryListView: View {
    var foodCategory: FoodCategoryModel
    
    var body: some View {
        HStack {
//            Image(uiImage: icon.symbolToImage())
            Text(foodCategory.imageString).font(.system(size: 18))
            Text(foodCategory.name).font(.body)
            Spacer()
        }
    }
}

//struct CategoryListView_Previews: PreviewProvider {
//    static var previews: some View {
//        CategoryListView()
//    }
//}
