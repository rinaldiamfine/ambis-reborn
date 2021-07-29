//
//  IngredientListCellView.swift
//  ambis-reborn
//
//  Created by Muhammad Rizki Miftha Alhamid on 7/29/21.
//

import SwiftUI

struct IngredientListCellView: View {
    var ingredient: IngredientSample
    
    var body: some View {
        HStack {
            Circle()
                .foregroundColor(.gray)
                .frame(width: 46, height: 46)
            Text(ingredient.name)
                .font(.system(size: 15))
            Spacer()
            Text("\(ingredient.total)  \(ingredient.totalType)")
        }
    }
}

//struct IngredientListCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        IngredientListCellView()
//    }
//}
