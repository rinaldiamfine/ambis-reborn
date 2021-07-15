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
    
    func getIconName() -> Image {
        return Image(systemName: "bag.fill")
    }
    func gettabName() -> Text {
        return Text("Shopping List")
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
            .navigationBarItems(trailing: Button(action: shoppingViewModel.prepareCreateData, label: {
                Image(systemName: "plus")
            }))
        }
        .sheet(isPresented: $shoppingViewModel.isPresented) {
            ShoppingFormView(shoppingViewModel: self.shoppingViewModel, foodCategoryViewModel: self.foodCategoryViewModel, isPresented: $shoppingViewModel.isPresented)
        }
        .onAppear(perform: {
            shoppingViewModel.loadList()
            foodCategoryViewModel.getData()
        })
        .onDisappear {
            shoppingViewModel.loadList()
            foodCategoryViewModel.getData()
        }
    }
    

}

//struct ShoppingView_Previews: PreviewProvider {
//    static var previews: some View {
//        ShoppingView()
//    }
//}
