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
                        Text("Food Category")) {
                            ForEach(foodCategoryViewModel.foodCategories, id:\.id) {
                                category in
                                CategoryListView(foodCategory: category)
                                    .contentShape(Rectangle())
                                    .onTapGesture {
                                        isPresented = true
//                                        selectCategory = 0
                                        getSelectedCategory(index: category)
                                    }
                            }
                        }
                }
                .listStyle(InsetGroupedListStyle())
            }
            .navigationBarTitle("Settings")
            .sheet(isPresented: $isPresented) {
                CategoryFormView(foodCategoryViewModel: self.foodCategoryViewModel, isPresented: $isPresented, selectedCategory: $selectCategory)
            }
        }
        .onAppear(perform: {
            foodCategoryViewModel.getData()
        })
    }
    
    func getIconName() -> Image {
        return Image(systemName: "gearshape.fill")
    }
    func gettabName() -> Text {
        return Text("Settings")
    }
}

//struct CategoryView_Previews: PreviewProvider {
//    static var previews: some View {
//        CategoryView()
//    }
//}
