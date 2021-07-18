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
        VStack {
            HStack {
                Spacer()
                VStack {
                    if defaultFilter == "Expiry Soon" {
                        ZStack {
                            Ellipse()
                                .fill(LinearGradient(
                                      gradient: .init(colors: [colorBrand1, colorBrand2]),
                                    startPoint: .init(x: 0, y: 0.5),
                                      endPoint: .init(x: 0.5, y: 0.5)
                                ))
                                .frame(width: 46, height: 46)
                            Image("BtnExpirySoonActive")
                        }
                    } else {
                        ZStack {
                            Ellipse()
//                                    .strokeBorder(boxColor)
                                .fill(boxBackground)
                                .frame(width: 46, height: 46)
                            Image("BtnExpirySoon")
                        }
                    }
                    Text("Expiry Soon")
                        .font(.system(size: 12))
                        .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                }.onTapGesture {
                    defaultFilter = "Expiry Soon"
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
                                      endPoint: .init(x: 0.5, y: 0.5)
                                ))
                                .frame(width: 46, height: 46)
                            Image("BtnFridgeActive")
                        }
                    } else {
                        ZStack {
                            Ellipse()
//                                    .strokeBorder(boxColor)
                                .fill(boxBackground)
                                .frame(width: 46, height: 46)
                            Image("BtnFridge")
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
                                      endPoint: .init(x: 0.5, y: 0.5)
                                ))
                                .frame(width: 46, height: 46)
                            Image("BtnFreezerActive")
                        }
                    } else {
                        ZStack {
                            Ellipse()
//                                    .strokeBorder(boxColor)
                                .fill(boxBackground)
                                .frame(width: 46, height: 46)
                            Image("BtnFreezer")
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
                                      endPoint: .init(x: 0.5, y: 0.5)
                                ))
                                .frame(width: 46, height: 46)
                            Image("BtnOtherActive")
                        }
                    } else {
                        ZStack {
                            Ellipse()
//                                    .strokeBorder(boxColor)
                                .fill(boxBackground)
                                .frame(width: 46, height: 46)
                            Image("BtnOther")
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
            .background(RoundedRectangle(cornerRadius: 10).fill(boxBackground))
        }
        Text(defaultFilter).font(.system(size: 20, weight: .semibold)).foregroundColor(colorScheme == .dark ? Color.white : Color.black)
    }
}

//struct InventoryFilterView_Previews: PreviewProvider {
//    static var previews: some View {
//        InventoryFilterView()
//    }
//}
