//
//  InventoryCategoryListView.swift
//  ambis-reborn
//
//  Created by Rinaldi LNU on 14/07/21.
//

import SwiftUI

struct InventoryCategoryListView: View {
    var foodCategory: FoodCategoryModel
    @Binding var previewSelectedCategory: String
    
    var body: some View {
        HStack {
            Text(foodCategory.imageString).font(.system(size: 18))
            Text(foodCategory.name).font(.system(.body, design: .rounded))
            Spacer()
            let formatName = foodCategory.imageString + " " + foodCategory.name
            if previewSelectedCategory == formatName {
                Image(systemName: "checkmark")
                    .foregroundColor(Color("AccentColor"))
            }
        }
        .navigationBarBackButtonHidden(false)
        .navigationBarHidden(false)
        .accentColor(.red)
    }
}
