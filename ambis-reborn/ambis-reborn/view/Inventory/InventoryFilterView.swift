//
//  InventoryFilterView.swift
//  ambis-reborn
//
//  Created by Rinaldi LNU on 18/07/21.
//

import SwiftUI

struct InventoryFilterView: View {
    @Binding var defaultFilter: String
    @State var isExpirySoon: Bool = false
    @Binding var isSearchActive: Bool
    
    
    @State var isFridge: Bool = false
    @State var isFreezer: Bool = false
    @State var isOther: Bool = false
    @State private var boxBackground = Color("BoxBackground")
    @State private var boxColor = Color("BoxColor")
    @State private var colorBrand1 = Color("GradientBar1")
    @State private var colorBrand2 = Color("GradientBar2")
    @Environment(\.colorScheme) var colorScheme
    
    func removeFilter() {
        isExpirySoon = false
        isFridge = false
        isFreezer = false
        isOther = false
    }
    
    var body: some View {
        if !isSearchActive {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                VStack {
                    if defaultFilter == "Expire Soon" {
                        ZStack {
                            Ellipse()
                                .fill(LinearGradient(
                                    gradient: .init(colors: [colorBrand1, colorBrand2]),
                                    startPoint: .init(x: 0, y: 0.5),
                                    endPoint: .init(x: 0.8, y: 0.5)
                                ))
                                .frame(width: 46, height: 46)
                            Image("BtnExpirySoonActive")
                                .resizable().frame(width: 26, height: 26)
                        }
                    } else {
                        ZStack {
                            Ellipse()
//                                    .strokeBorder(boxColor)
                                .fill(boxBackground)
                                .frame(width: 46, height: 46)
                            Image("BtnExpirySoon")
                                .resizable()
                                .frame(width: 26, height: 26)
                        }
                    }
                    Text("Expire Soon")
                        .font(.system(size: 12))
                        .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                }.onTapGesture {
                    defaultFilter = "Expire Soon"
                }
                .padding(.top)
                .padding(.bottom)
                Spacer()
                VStack {
                    if defaultFilter == "Fridge" {
                        ZStack {
                            Ellipse()
                                .fill(LinearGradient(
                                    gradient: .init(colors: [colorBrand1, colorBrand2]),
                                    startPoint: .init(x: 0, y: 0.5),
                                    endPoint: .init(x: 0.8, y: 0.5)
                                ))
                                .frame(width: 46, height: 46)
                            Image("BtnFridgeActive")
                                .resizable()
                                .frame(width: 26, height: 26)
                        }
                    } else {
                        ZStack {
                            Ellipse()
//                                    .strokeBorder(boxColor)
                                .fill(boxBackground)
                                .frame(width: 46, height: 46)
                            Image("BtnFridge")
                                .resizable()
                                .frame(width: 26, height: 26)
                        }
                    }
                    Text("   Fridge   ")
                        .font(.system(size: 12))
                        .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                }.onTapGesture {
                    removeFilter()
                    isFridge = true
                    defaultFilter = "Fridge"
                }
                .padding(.top)
                .padding(.bottom)
                Spacer()
                VStack {
                    if defaultFilter == "Freezer" {
                        ZStack {
                            Ellipse()
                                .fill(LinearGradient(
                                    gradient: .init(colors: [colorBrand1, colorBrand2]),
                                    startPoint: .init(x: 0, y: 0.5),
                                    endPoint: .init(x: 0.8, y: 0.5)
                                ))
                                .frame(width: 46, height: 46)
                            Image("BtnFreezerActive")
                                .resizable()
                                .frame(width: 26, height: 26)
                        }
                    } else {
                        ZStack {
                            Ellipse()
//                                    .strokeBorder(boxColor)
                                .fill(boxBackground)
                                .frame(width: 46, height: 46)
                            Image("BtnFreezer")
                                .resizable()
                                .frame(width: 26, height: 26)
                        }
                    }
                    Text("   Freezer   ")
                        .font(.system(size: 12))
                        .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                }.onTapGesture {
                    defaultFilter = "Freezer"
                }
                .padding(.top)
                .padding(.bottom)
                Spacer()
                VStack {
                    if defaultFilter == "Other" {
                        ZStack {
                            Ellipse()
                                .fill(LinearGradient(
                                    gradient: .init(colors: [colorBrand1, colorBrand2]),
                                    startPoint: .init(x: 0, y: 0.5),
                                    endPoint: .init(x: 0.8, y: 0.5)
                                ))
                                .frame(width: 46, height: 46)
                            Image("BtnOtherActive")
                                .resizable()
                                .frame(width: 26, height: 26)
                        }
                    } else {
                        ZStack {
                            Ellipse()
//                                    .strokeBorder(boxColor)
                                .fill(boxBackground)
                                .frame(width: 46, height: 46)
                            Image("BtnOther")
                                .resizable()
                                .frame(width: 26, height: 26)
                        }
                    }
                    Text("   Other   ")
                        .font(.system(size: 12))
                        .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                }.onTapGesture {
                    defaultFilter = "Other"
                }
                .padding(.top)
                .padding(.bottom)
                Spacer()
            }
            .background(RoundedRectangle(cornerRadius: 15).fill(boxBackground))
        }
        .padding(.bottom)
        HStack {
            Text(defaultFilter).font(.system(size: 20, weight: .semibold)).foregroundColor(colorScheme == .dark ? Color.white : Color.black)
            Spacer()
        }
        }
    }
}

//struct InventoryFilterView_Previews: PreviewProvider {
//    static var previews: some View {
//        InventoryFilterView()
//    }
//}
