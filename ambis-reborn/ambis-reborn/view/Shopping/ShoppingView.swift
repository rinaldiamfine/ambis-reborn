//
//  ShoppingView.swift
//  ambis-reborn
//
//  Created by Muhammad Rizki Miftha Alhamid on 7/14/21.
//

import SwiftUI
import UIKit
import CoreData

struct ShoppingView: View {
    @StateObject private var shoppingViewModel = ShoppingViewModel()
    @StateObject private var foodCategoryViewModel = FoodCategoryViewModel()
    @State var selectedIndex = 0
    @State var status = ""
    @State var isPresented = false
    
    func loadList() {
        shoppingViewModel.getData()
        foodCategoryViewModel.getData()
    }
    func getIconName() -> Image {
        return Image(systemName: "bag.fill")
    }
    func gettabName() -> Text {
        return Text("Shopping List")
    }
    
    
    func createData() {
        self.status = "create"
        self.isPresented = true
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 50) {
                if shoppingViewModel.shoppingCount > 0 {
                    List {
                        ForEach(shoppingViewModel.shopping, id:\.id) {
                            shopping in ShoppingListView(shopping: shopping)
                            //context menu
                        }
                    }
                    .listStyle(InsetGroupedListStyle())
                } else {
                    ShoppingListEmptyView()
                }
            }
            .navigationBarTitle("Shopping List")
            .navigationBarItems(trailing: Button(action: createData, label: {
                Image(systemName: "plus")
            }))
        }
        .sheet(isPresented: $isPresented) {
            ShoppingFormView(shoppingViewModel: self.shoppingViewModel, foodCategoryViewModel: self.foodCategoryViewModel, isPresented: $isPresented, status: $status, selectedIndex: $selectedIndex)
        }
        .onAppear(perform: {
            loadList()
        })
    }
    

}

//struct ShoppingView_Previews: PreviewProvider {
//    static var previews: some View {
//        ShoppingView()
//    }
//}
