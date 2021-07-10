//
//  CategoryView.swift
//  ambis-reborn
//
//  Created by Rinaldi LNU on 05/07/21.
//

import SwiftUI
import CoreData

struct CategoryView: View {
    @StateObject private var foodCategoryViewModel = FoddCategoryViewModel()
    
    @State var isPresented = false
    @ObservedObject var searchBar: SearchBar = SearchBar()
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(foodCategoryViewModel.foodCategories, id:\.id) {
                        category in
                        NavigationLink(destination: CategoryFormView(foodCategoryViewModel: self.foodCategoryViewModel, isPresented: $isPresented)) {
                            CategoryListView(title: category.name)
                        }
                    }
                }.listStyle(InsetGroupedListStyle())
            }
            .navigationBarTitle("Category")
            .navigationBarItems(trailing: Button(action: createData, label: {
                Image(systemName: "plus")
            }))
        }.sheet(isPresented: $isPresented, content: {
            CategoryFormView(foodCategoryViewModel: self.foodCategoryViewModel, isPresented: $isPresented)
        }).onAppear(perform: {
            foodCategoryViewModel.getData()
        })
    }
    
    func createData() {
        print("Yuk create data", self.isPresented)
        self.isPresented = true
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
