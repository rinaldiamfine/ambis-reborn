//
//  RecipeSortView.swift
//  ambis-reborn
//
//  Created by Rio Sudarsono on 02/08/21.
//

import SwiftUI

struct RecipeSortView: View {
    
    @Binding var toSort: Bool
    @Binding var sortDish: [RecipeSort]
    @Binding var sortPortion: [RecipeSort]
    @Binding var sortEquipment: [RecipeSort]
    
    var body: some View {
        NavigationView {
            List {
                Section(header: viewHeader(title: "Dish Category")) {
                    ForEach(0..<sortDish.count) { data in
                        HStack{
                            Text(sortDish[data].name).font(.system(size: 16))
                            Spacer()
                            if sortDish[data].isChoose {
                                Image(systemName: "checkmark").foregroundColor(Color("AccentColor"))
                            }
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            sortDish[data].isChoose = !sortDish[data].isChoose
                        }
                    }
                }
//                .textCase(nil)
                Section(header: viewHeader(title: "Portion")) {
                    ForEach(0..<sortPortion.count) { data in
                        HStack{
                            Text(sortPortion[data].name).font(.system(size: 16))
                            Spacer()
                            if sortPortion[data].isChoose {
                                Image(systemName: "checkmark").foregroundColor(Color("AccentColor"))
                            }
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            sortPortion[data].isChoose = !sortPortion[data].isChoose
                        }
                    }
                    
                }
                Section(header: viewHeader(title: "Kitchen Equipment")) {
                    ForEach(0..<sortEquipment.count) { data in
                        HStack{
                            Text(sortEquipment[data].name).font(.system(size: 16))
                            Spacer()
                            if sortEquipment[data].isChoose {
                                Image(systemName: "checkmark").foregroundColor(Color("AccentColor"))
                            }
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            sortEquipment[data].isChoose = !sortEquipment[data].isChoose
                        }
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
