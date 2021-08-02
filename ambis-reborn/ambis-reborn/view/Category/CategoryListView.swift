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
            Text(foodCategory.imageString).font(.system(size: 18))
            Text(foodCategory.name).font(.system(.body, design: .rounded))
            Spacer()
            Image(systemName: "chevron.right")
                .font(.system(size: 13, weight: .bold))
            .foregroundColor(Color.init(UIColor.systemGray2))
        }
    }
}

//struct CategoryListView_Previews: PreviewProvider {
//    static var previews: some View {
//        CategoryListView()
//    }
//}
