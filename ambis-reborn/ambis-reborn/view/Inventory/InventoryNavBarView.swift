//
//  InventoryNavBarView.swift
//  ambis-reborn
//
//  Created by Rinaldi LNU on 11/08/21.
//

import SwiftUI

struct InventoryNavBarTitle: View {
    @Binding var navTitle: String
    @Binding var offset: CGFloat
    var topEdge : CGFloat
    
    var body: some View {
        HStack {
            Text(navTitle)
                .font(.system(size: 40, design: .rounded))
                .bold()
            Spacer()
        }
        .padding()
        .padding(.bottom)
        .opacity(Double(getOpacity()))
    }
    
    func getOpacity() -> CGFloat {
        let progress = -offset / 50
        let opacity = 1 - progress
        return offset < 0 ? opacity : 1
    }
}

struct InventoryNavBar: View {
    @State var navTitle: String
    @State var offset: CGFloat = 0
    var topEdge: CGFloat
    let maxHeight = UIScreen.screenHeight/4.3
    
    @StateObject var inventoryViewModel = InventoryViewModel()
    @StateObject var foodCategoryViewModel = FoodCategoryViewModel()
    @AppStorage("expiry", store: UserDefaults(suiteName: "group.inventoryUD")) var inventoryData : Data = Data()
    
    @ObservedObject var searchBar: SearchBar = SearchBar()
    @State private var defaultFilter = "Freezer"
    @Environment(\.colorScheme) var colorScheme
    
    @State private var searchText = ""
    @State private var showCancelButton: Bool = false
    @State private var needRefresh = true
    
    func getOpacityNavBarSmallTitle() -> CGFloat {
        let progress = -offset / 50
        return progress < 1 ? progress : 1
    }
    
    func filterList(expiryDate: Date, name: String, store: String) -> Bool {
        print(inventoryViewModel.inventory ,"LIST INVNT")
        if defaultFilter == "Expire Soon" {
            if !showCancelButton {
                if expiryDate <= Date().addingTimeInterval(24 * 60 * 60 * 3) {
                    return true
                } else {
                    return false
                }
            } else {
                return name.localizedStandardContains(searchText)
            }
        } else {
            if !showCancelButton  {
                return store.localizedStandardContains(defaultFilter)
            } else {
                return name.localizedStandardContains(searchText)
            }
        }
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 15) {
                GeometryReader(content: { geometry in
                    VStack(alignment: .leading, spacing: 15) {
                        InventoryNavBarTitle(navTitle: $navTitle, offset: $offset, topEdge: topEdge)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: getHeaderHeight(), alignment: .bottom)
                    .background(
                        ZStack {
                            CustomCorner(corners: [.bottomRight], radius: getCornerRadius()).fill(
//                                Color(.red)
                                Color("Gradient1")
    //                            LinearGradient(
    //                                gradient: .init(colors: [Color("Gradient1"), Color("Gradient2")]),
    //                                startPoint: .init(x: 0, y: 0),
    //                                endPoint: .init(x: 0, y: 1)
    //                            )
                            )
                            HStack(alignment: .top) {
                                Spacer()
                                Image("OvalImage")
                            }
                        }
                    ).overlay(
                        HStack(alignment: .center, spacing: 0) {
                            
                            Button(action: {
                                //Action
                            }, label: {
                                
                            }).frame(width: UIScreen.screenWidth*0.25, alignment: .topLeading)
                            
                            Text(navTitle)
                                .font(.system(size: 18, design: .rounded))
                                .bold()
                                .opacity(Double(getOpacityNavBarSmallTitle()))
                                .frame(width: UIScreen.screenWidth*0.50)
                            
                            Button(action: {
                                //Action
                            }, label: {
                                Image(systemName: "plus")
                                    .imageScale(.large)
                                    .accentColor(.primary)
                            })
                            .padding(.horizontal)
                            .frame(width: UIScreen.screenWidth*0.25, alignment: .topTrailing)
                        }
                        .frame(height: 80)
                        .padding(.top, topEdge)
                        , alignment: .top
                    )
                    
                })
                .frame(height: maxHeight)
                .offset(y: -offset)
                .zIndex(1)
                
                VStack(spacing: 15) {
                    ForEach (inventoryViewModel.inventory.filter {
                        let filter = filterList(expiryDate: $0.expiryDate, name: $0.name, store: $0.store)
                        return filter
                    }, id:\.id) {
                        inventory in
//                        VStack(spacing: 10) {
                            if !showCancelButton {
                                // EXPIRE SOON
                                if defaultFilter == "Expire Soon" {
                                    InventoryListExpiryView(inventory: inventory, inventoryViewModel: inventoryViewModel, counterGate: inventoryViewModel.inventoryCount)
                                        .padding(.horizontal)
                                        .onTapGesture {
//                                            presentModalForEdit()
                                        }
                                }
                                //NOT EXPIRE SOON
                                else {
                                    InventoryListView(inventory: inventory, inventoryViewModel: inventoryViewModel)
                                        .padding(.horizontal)
                                }
                            } else {
                                //ON FILTER
                                InventoryListFilterView(inventory: inventory, inventoryViewModel: inventoryViewModel, counterGate: inventoryViewModel.inventoryCount)
                                    .padding(.horizontal)
                            }
//                        }
//
                    }
                }
                .zIndex(0)
                
            }
            .onAppear(perform: {
                foodCategoryViewModel.getData()
                inventoryViewModel.loadList()
                NotificationCenter.default.addObserver(inventoryViewModel, selector: #selector(inventoryViewModel.refresh), name: NSNotification.Name(rawValue: "inventoryUpdated"), object: nil)
//                setupWidgetContent()
            })
            .modifier(OffsetModifier(offset: $offset))
        }
        .coordinateSpace(name: "scroll")
    }
    
    func getHeaderHeight() -> CGFloat {
        let topHeight = maxHeight + offset
        return topHeight > (80 + topEdge) ? topHeight : (80 + topEdge)
    }
    
    func getCornerRadius() -> CGFloat {
        let progress = -offset / (maxHeight - (80 + topEdge))
        let value = 1 - progress
        let radius = value * 50
        return offset < 0 ? radius : 50
    }
}

struct CustomCorner: Shape {
    var corners: UIRectCorner
    var radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct OffsetModifier: ViewModifier {
    @Binding var offset: CGFloat
    
    func body(content: Content) -> some View {
        content.overlay(
            GeometryReader { geometry -> Color in
                let minY = geometry.frame(in: .named("scroll")).minY
                DispatchQueue.main.async {
                    self.offset = minY
                }
                return Color(.clear)
            }, alignment: .top
        )
    }
}
