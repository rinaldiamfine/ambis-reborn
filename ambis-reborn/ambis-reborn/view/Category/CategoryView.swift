//
//  CategoryView.swift
//  ambis-reborn
//
//  Created by Rinaldi LNU on 05/07/21.
//

import SwiftUI
import CoreData

struct CategoryView: View {
    @StateObject private var foodCategoryViewModel = FoodCategoryViewModel()
    @State var isPresented = false
    @State private var selectCategory: Int = 0
    
    func getSelectedCategory(index: FoodCategoryModel) {
        var count = 0
        for data in foodCategoryViewModel.foodCategories {
            if data.id == index.id {
                break
            }
            count += 1
        }
        selectCategory = count
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section(header:
                                Text("Food Category").font(.system(.caption, design: .rounded))) {
                            ForEach(foodCategoryViewModel.foodCategories, id:\.id) {
                                category in
                                CategoryListView(foodCategory: category)
                                    .contentShape(Rectangle())
                                    .onTapGesture {
                                        isPresented = true
                                        getSelectedCategory(index: category)
                                    }
                            }
                        }
                }
                .listStyle(InsetGroupedListStyle())
            }
            .navigationBarTitle("Category")
            .sheet(isPresented: $isPresented) {
                CategoryFormView(foodCategoryViewModel: self.foodCategoryViewModel, isPresented: $isPresented, selectedCategory: $selectCategory)
            }
        }
        .onAppear(perform: {
            foodCategoryViewModel.getData()
        })
    }
    
    func getIconName() -> Image {
        return Image(systemName: "square.grid.2x2.fill")
    }
    func gettabName() -> Text {
        return Text("Category")
    }
}

//struct CategoryView_Previews: PreviewProvider {
//    static var previews: some View {
//        CategoryView()
//    }
//}
