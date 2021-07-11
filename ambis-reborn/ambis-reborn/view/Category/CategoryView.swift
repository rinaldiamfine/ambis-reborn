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
    @ObservedObject var searchBar: SearchBar = SearchBar()
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section(header:
                        Text("Food Category")) {
                            ForEach(foodCategoryViewModel.foodCategories, id:\.id) {
                                category in
                                NavigationLink(destination: CategoryFormView(foodCategoryViewModel: self.foodCategoryViewModel, isPresented: $isPresented, foodCategory: category)
                                    .navigationBarTitleDisplayMode(.inline)) {
                                    CategoryListView(foodCategory: category)
                                }
                            }
                        }
                }
                .listStyle(InsetGroupedListStyle())
            }
            .navigationBarTitle("Category")
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

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView()
    }
}
