//
//  CategoryFormView.swift
//  ambis-reborn
//
//  Created by Rinaldi LNU on 09/07/21.
//

import SwiftUI

struct CategoryFormView: View {
    @ObservedObject var foodCategoryViewModel: FoddCategoryViewModel
    @Binding var isPresented: Bool
    
    var body: some View {
        TextField("Enter Inventory Name", text: $foodCategoryViewModel.name).textFieldStyle(RoundedBorderTextFieldStyle())
        Button("Save") {
            foodCategoryViewModel.saveData()
            foodCategoryViewModel.getData()
            isPresented = false
        }
    }
}

//
//struct CategoryFormView_Previews: PreviewProvider {
//    static var previews: some View {
//        CategoryFormView()
//    }
//}
