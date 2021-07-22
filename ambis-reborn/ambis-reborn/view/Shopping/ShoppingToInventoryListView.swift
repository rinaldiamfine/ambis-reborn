//
//  ShoppingToInventoryListView.swift
//  ambis-reborn
//
//  Created by Muhammad Rizki Miftha Alhamid on 7/15/21.
//

import SwiftUI
import CoreData

struct ShoppingToInventoryListView: View {
    @ObservedObject var shoppingViewModel = ShoppingViewModel()
    var shopping: ShoppingModel
    
    var storeAvailable = AppGlobalData.generateDataStore()
    @State var isClicked = false
    @Binding var expiryDate: Date
    @Binding var purchaseDate: Date
    @Binding var store: String
    
    @State var counterToAdjustExpDate: Int = 0
    @State var expiryDatePickerChangeCounter: Int = 0
    
    func formatSubtitle() -> String {
        var format = ""
        format = String(self.shopping.total) + " " + self.shopping.totalType
        return format
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                if shopping.foodCategory != FoodCategory() {
                    if shopping.shopping.toFoodCategory != nil {
                        Text(shopping.foodCategory.imageString ?? "")
                            .font(.system(size: 18))
                    }
                }
                VStack(alignment: .leading) {
                    Text(shopping.name).font(.system(size: 15))
                    Text(formatSubtitle()).font(.system(size: 13))
                }
                Spacer()
                if isClicked {
                    Image(systemName: "chevron.down")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(Color.init(UIColor.systemGray2))
                } else {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 13, weight: .bold))
                        .foregroundColor(Color.init(UIColor.systemGray2))
                }
            }
            .contentShape(Rectangle())
            .onTapGesture {
                counterToAdjustExpDate += 1
                if counterToAdjustExpDate == 1 {
                    if shopping.shopping.toFoodCategory != nil {
                        expiryDate = Calendar.current.date(byAdding: .day, value: Int(shopping.foodCategory.expiryEstimation ), to: Date())!
                    }
                    isClicked.toggle()
                }
            }
            if isClicked {
                Section(header: Text("Storing Type")) {
                    Picker("", selection: $store) {
                        ForEach(storeAvailable, id: \.self.name) {
                            Text($0.name)
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                    if shoppingViewModel.detailDisclaimer != "" {
                        HStack {
                            Spacer()
                            Text(shoppingViewModel.detailDisclaimer)
                                .lineLimit(nil).contentShape(Rectangle())
                                .multilineTextAlignment(.center)
                                .font(.system(size: 14))
                                .foregroundColor(Color.init(UIColor.systemGreen))
                                .lineSpacing(/*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                                .padding(.top, 10).padding(.bottom, 10)
                            Spacer()
                        }
                    }
                }.padding(.top, 10)
                
                Section(header: Text("Date Information")) {
                    DatePicker("Buy", selection: Binding<Date> (
                                get: { purchaseDate },
                                set: { purchaseDate = $0
                                    if expiryDate < $0 {
                                        expiryDate = $0
                                    }
                                    if shopping.shopping.toFoodCategory != nil {
                                        expiryDate = Calendar.current.date(byAdding: .day, value: Int(shopping.foodCategory.expiryEstimation), to: $0)!
                                    }
                                }), displayedComponents: .date)
                    DatePicker("Expiry", selection: $expiryDate, in: purchaseDate..., displayedComponents: .date)
                }
//                Section(header: Text("Disclaimer")) {
//                    Text("The numbers provided below are rough estimates on how long an item in the category you have chosen can last in different situations.\n\nThe best indicators on whether a food has expired is to look for signs of spoilage, such as foul odor, fungi and mold growth, and sour taste")
//                        .font(.system(size: 14))
//                        .foregroundColor(.gray)
//                        .padding(.top, 10).padding(.bottom, 10)
//                }
            }
        }
    }
}
//struct ShoppingToInventoryListView_Previews: PreviewProvider {
//    static var previews: some View {
//        ShoppingToInventoryListView()
//    }
//}
