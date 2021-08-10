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
    @Environment(\.colorScheme) var colorScheme
    
    @State private var boxBackground = Color("BoxBackground")
    @State private var iconBackground1 = Color("IconBackground1")
    @State private var iconBackground2 = Color("IconBackground2")
    
    var shopping: ShoppingModel
    
    var storeAvailable = AppGlobalData.generateDataStore()
    @State var isClicked = false
    @Binding var expiryDate: Date
    @Binding var purchaseDate: Date
    @Binding var store: String
    
    @Binding var selectedArrayShowPicker: Int
    @Binding var isShowPickerStore: Bool
    var counterList : Int
    
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
                        ZStack {
                            Ellipse()
                                .fill(LinearGradient(
                                    gradient: .init(colors: [iconBackground1, iconBackground2]),
                                    startPoint: .init(x: 0, y: 0.5),
                                    endPoint: .init(x: 0.8, y: 0.5)
                                ))
                                .frame(width: 46, height: 46)
                            Text(shopping.foodCategory.imageString ?? "").font(.system(size: 28))
                        }
                    }
                }
                VStack(alignment: .leading, spacing: 5) {
                    Text(shopping.name).font(.system(size: 15, design: .rounded))
                    Text(formatSubtitle()).font(.system(size: 13, design: .rounded))
                }
                .padding(.leading, 2)
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
                }
                isClicked.toggle()
            }
            
            if isClicked {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Storing Type")
                                    .font(.system(.caption, design: .rounded)).padding(.top, 5)
                        VStack {
                            HStack {
                                Text("Storing Type")
                                    .font(.system(.callout, design: .rounded))
                                Spacer()
                                Text(store)
                                    .font(.system(.callout, design: .rounded))
                                    Image(systemName: "chevron.right")
                                        .font(.system(size: 13, weight: .bold))
                                        .foregroundColor(Color.init(UIColor.systemGray2))
                            }
                            .contentShape(Rectangle())
                            .onTapGesture {
                                isShowPickerStore.toggle()
                                selectedArrayShowPicker = counterList
                            }
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(colorScheme == .dark ? Color("BoxBackground") : Color("BoxColor"))
                        )
                    }
                }
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("Date Information")
                                    .font(.system(.caption, design: .rounded))
                        VStack {
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
                                .font(.system(.callout, design: .rounded))
                            DatePicker("Expiry", selection: $expiryDate, in: purchaseDate..., displayedComponents: .date)
                                .font(.system(.callout, design: .rounded))
                        }.padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(colorScheme == .dark ? Color("BoxBackground") : Color("BoxColor"))
                        )
                    }
                }
            }
        }
        .padding(.all, 8)
        .background(RoundedRectangle(cornerRadius: 15).fill(boxBackground))
    }
}
//struct ShoppingToInventoryListView_Previews: PreviewProvider {
//    static var previews: some View {
//        ShoppingToInventoryListView()
//    }
//}
