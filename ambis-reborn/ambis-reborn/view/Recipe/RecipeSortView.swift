//
//  RecipeSortView.swift
//  ambis-reborn
//
//  Created by Rio Sudarsono on 02/08/21.
//

import SwiftUI

struct RecipeSortView: View {
    
    @Binding var toSort: Bool
//    @Binding var sortDish: Array<RecipeSort>
//    @Binding var sortPortion: [RecipeSort]
//    @Binding var sortEquipment: [RecipeSort]
    
    var body: some View {
        NavigationView {
            
            List {
                Section(header: viewHeader(title: "Dish Category")) {
                    HStack{
                        Text("Appetizer").font(.system(size: 16))
                        Spacer()
                        Image(systemName: "checkmark").foregroundColor(Color("AccentColor"))
                    }
                    HStack{
                        Text("Main Dish").font(.system(size: 16))
                        Spacer()
                        Image(systemName: "checkmark").foregroundColor(Color("AccentColor"))
                    }
                    HStack{
                        Text("Dessert").font(.system(size: 16))
                        Spacer()
                        Image(systemName: "checkmark").foregroundColor(Color("AccentColor"))
                    }
                }
//                .textCase(nil)
                Section(header: viewHeader(title: "Dish Category")) {
                    HStack{
                        Text("Appetizer").font(.system(size: 16))
                        Spacer()
                        Image(systemName: "checkmark").foregroundColor(Color("AccentColor"))
                    }
                    HStack{
                        Text("Main Dish").font(.system(size: 16))
                        Spacer()
                        Image(systemName: "checkmark").foregroundColor(Color("AccentColor"))
                    }
                    HStack{
                        Text("Dessert").font(.system(size: 16))
                        Spacer()
                        Image(systemName: "checkmark").foregroundColor(Color("AccentColor"))
                    }
                }
                Section(header: viewHeader(title: "Dish Category")) {
                    HStack{
                        Text("Appetizer").font(.system(size: 16))
                        Spacer()
                        Image(systemName: "checkmark").foregroundColor(Color("AccentColor"))
                    }
                    HStack{
                        Text("Main Dish").font(.system(size: 16))
                        Spacer()
                        Image(systemName: "checkmark").foregroundColor(Color("AccentColor"))
                    }
                    HStack{
                        Text("Dessert").font(.system(size: 16))
                        Spacer()
                        Image(systemName: "checkmark").foregroundColor(Color("AccentColor"))
                    }
                }
            }
                
            .navigationBarTitle("Sort By", displayMode: .inline)
            .navigationBarItems(
                leading:
                    Button(action: actionDone, label: {
                        Text("Done")
                    }))
            
            
        }
    
    }
    
    func viewHeader(title: String) -> some View {
        return HStack {
            Text(title).bold().font(.system(size: 14))
            Spacer()
        }
        .foregroundColor(.gray)
        .padding(.leading, 16)
        .padding(.top, 16)
        .background(Color(.systemBackground))
        .listRowInsets(EdgeInsets())
    }
    
    
    
    
    func actionDone() {
        self.toSort.toggle()
    }
}



//struct RecipeSortView_Previews: PreviewProvider {
//    static var previews: some View {
//        RecipeSortView(toSort: $true)
//    }
//}
