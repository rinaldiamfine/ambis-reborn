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
            VStack {
                HStack(spacing: 0) {
                    Spacer()
                    VStack {
                        Rectangle()
                            .fill(defaultFilter == "Expire Soon" ? Color("BrandColor") : boxBackground)
                            .cornerRadius(radius: 5, corners: [.bottomLeft, .bottomRight])
                            .frame(width: 26, height: 4, alignment: .center)
                        
                        ZStack {
                            Ellipse()
                                .fill(boxBackground)
                                .frame(width: 46, height: 46)
                            Image("BtnExpirySoonActive")
                                .resizable().frame(width: 26, height: 26)
                        }
                        Text("Expire Soon")
                            .fontWeight(defaultFilter == "Expire Soon" ? .medium : .medium)
                            .font(.system(size: 12, design: .rounded))
                            .foregroundColor(defaultFilter == "Expire Soon" ? Color("BackgroundInverse") : Color.secondary)
                    }.onTapGesture {
                        defaultFilter = "Expire Soon"
                    }
                    .padding(.bottom)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    
                    VStack {
                        Rectangle()
                            .fill(defaultFilter == "Fridge" ? Color("BrandColor") : boxBackground)
                            .cornerRadius(radius: 5, corners: [.bottomLeft, .bottomRight])
                            .frame(width: 26, height: 4, alignment: .center)
                        
                        ZStack {
                            Ellipse()
                                .fill(boxBackground)
                                .frame(width: 46, height: 46)
                            Image("BtnFridgeActive")
                                .resizable().frame(width: 26, height: 26)
                        }
                        Text("Fridge")
                            .fontWeight(defaultFilter == "Fridge" ? .medium : .medium)
                            .font(.system(size: 12, design: .rounded))
                            .foregroundColor(defaultFilter == "Fridge" ? Color("BackgroundInverse") : Color.secondary)
                    }.onTapGesture {
                        defaultFilter = "Fridge"
                    }
                    .padding(.bottom)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    
                    VStack {
                        Rectangle()
                            .fill(defaultFilter == "Freezer" ? Color("BrandColor") : boxBackground)
                            .cornerRadius(radius: 5, corners: [.bottomLeft, .bottomRight])
                            .frame(width: 26, height: 4, alignment: .center)
                        
                        ZStack {
                            Ellipse()
                                .fill(boxBackground)
                                .frame(width: 46, height: 46)
                            Image("BtnFreezerActive")
                                .resizable().frame(width: 26, height: 26)
                        }
                        Text("Freezer")
                            .fontWeight(defaultFilter == "Freezer" ? .medium : .medium)
                            .font(.system(size: 12, design: .rounded))
                            .foregroundColor(defaultFilter == "Freezer" ? Color("BackgroundInverse") : Color.secondary)
                    }.onTapGesture {
                        defaultFilter = "Freezer"
                    }
                    .padding(.bottom)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    
                    VStack {
                        Rectangle()
                            .fill(defaultFilter == "Other" ? Color("BrandColor") : boxBackground)
                            .cornerRadius(radius: 5, corners: [.bottomLeft, .bottomRight])
                            .frame(width: 26, height: 4, alignment: .center)
                        
                        ZStack {
                            Ellipse()
                                .fill(boxBackground)
                                .frame(width: 46, height: 46)
                            Image("BtnOtherActive")
                                .resizable().frame(width: 26, height: 26)
                        }
                        Text("Other")
                            .fontWeight(defaultFilter == "Other" ? .medium : .medium)
                            .font(.system(size: 12, design: .rounded))
                            .foregroundColor(defaultFilter == "Other" ? Color("BackgroundInverse") : Color.secondary)
                    }.onTapGesture {
                        defaultFilter = "Other"
                    }
                    .padding(.bottom)
                    .frame(minWidth: 0, maxWidth: .infinity)
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
