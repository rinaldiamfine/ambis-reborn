//
//  PrepareFilterView.swift
//  ambis-reborn
//
//  Created by Rinaldi LNU on 28/07/21.
//

import SwiftUI

struct PrepareFilterView: View {
    @Binding var defaultFilter: String
    @State var isExpirySoon: Bool = false
    @Binding var isSearchActive: Bool
    
    @Binding var searchText: String
    @Binding var showCancelButton: Bool
    
    @State private var boxBackground = Color("BoxBackground")
    @State private var boxColor = Color("BoxColor")
    @State private var colorBrand1 = Color("GradientBar1")
    @State private var colorBrand2 = Color("GradientBar2")
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("Search", text: $searchText, onEditingChanged: { isEditing in
                    self.showCancelButton = true
                }, onCommit: {
                    print("onCommit")
                })
                .foregroundColor(.primary)
                .font(.system(.body, design: .rounded))
                
                Button(action: {
                    self.searchText = ""
                }) {
                    Image(systemName: "xmark.circle.fill").opacity(searchText == "" ? 0 : 1)
                }
            }
            .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
            .foregroundColor(.secondary)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(boxBackground)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10).stroke(Color.secondary, lineWidth: 0.1)
                    )
            )
            if showCancelButton  {
                Button("Cancel") {
                    UIApplication.shared.endEditing(true)
                    self.searchText = ""
                    self.showCancelButton = false
                }
                .foregroundColor(Color("BrandColor"))
                .font(.system(.body, design: .rounded))
            }
        }
        .navigationBarHidden(showCancelButton)
        .padding(.vertical)
        
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
                            .font(.system(size: 12, design: .rounded))
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
                            .font(.system(size: 12, design: .rounded))
                            .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                    }.onTapGesture {
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
                            .font(.system(size: 12, design: .rounded))
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
                            .font(.system(size: 12, design: .rounded))
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
//            HStack {
//                Text(defaultFilter).font(.system(size: 20, weight: .semibold)).foregroundColor(colorScheme == .dark ? Color.white : Color.black)
//                Spacer()
//            }
//            .onDisappear(perform: {
//                print("DISSAPERA")
//            })
        }
    }
}

//struct PrepareFilterView_Previews: PreviewProvider {
//    static var previews: some View {
//        PrepareFilterView()
//    }
//}
