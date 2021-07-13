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
            Text(foodCategory.name).font(.body)
            Spacer()
            let formatName = foodCategory.imageString + " " + foodCategory.name
            if previewSelectedCategory == formatName {
                Image(systemName: "checkmark.circle").foregroundColor(Color.init(UIColor.systemGreen))
            }
        }
    }
    
//    @Binding var previewSelectedCategory: String
//    @Binding var detailDisclaimer: String
//    @Binding var expiryEstimation: Int
//    @Binding var selectedCategory: [FoodCategoryModel]
//
//    func categoryOnTap() {
//        previewSelectedCategory = foodCategory.imageString + " " + foodCategory.name
//        detailDisclaimer = foodCategory.estimation
//        selectedCategory = [foodCategory]
//        expiryEstimation = Int(foodCategory.expiryEstimation)
//    }
//
//    var body: some View {
//        HStack {
//            Text(foodCategory.imageString).font(.system(size: 18))
//            Text(foodCategory.name).font(.body)
//            Spacer()
//            Image(systemName: "checkmark.circle")
//        }
//        .contentShape(Rectangle())
//        .onTapGesture {
//            categoryOnTap()
//        }
//    }
}
