//
//  PrepareView.swift
//  ambis-reborn
//
//  Created by Rinaldi LNU on 28/07/21.
//

import SwiftUI

struct PrepareView: View {
    @StateObject var inventoryViewModel = InventoryViewModel()
    @StateObject var foodCategoryViewModel = FoodCategoryViewModel()
    @ObservedObject var searchBar: SearchBar = SearchBar()
    @State private var defaultFilter = "Expire Soon"
    @Environment(\.colorScheme) var colorScheme
    
    @State private var searchText = ""
    @State private var showCancelButton: Bool = false
    @State private var needRefresh = true
    @State var totalItemSelected: Int = 0
    @State private var isMovedToRecipeList = false
    @State private var action: Int? = 0
    
    func getIconName() -> Image {
        return Image(systemName: "flame.fill")
    }
    func gettabName() -> Text {
        return Text("Prepare")
    }
    func getTotalItemSelected() -> Int {
        return inventoryViewModel.prepareSelectedInventory.count
    }
    
    var storeAvailable = AppGlobalData.generateDataStore()
    
    func filterList(expiryDate: Date, name: String, store: String) -> Bool {
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
        NavigationView {
            VStack(spacing: 10) {
                if inventoryViewModel.inventoryCount > 0 {
                    ZStack {
                        ScrollView {
                            //SETUP SEARCH AND FILTER
                            VStack(spacing: 10) {
                                PrepareFilterView(defaultFilter: $defaultFilter, isSearchActive: $showCancelButton, searchText: $searchText, showCancelButton: $showCancelButton)
                                    .padding(.horizontal)
                            }
                            
                            //SETUP LIST
                            Section {
                                ForEach (inventoryViewModel.inventory.filter {
                                    filterList(expiryDate: $0.expiryDate, name: $0.name, store: $0.store)
                                }, id:\.id) {
                                    inventory in
                                    VStack(spacing: 10) {
                                        if !showCancelButton {
                                            // EXPIRE SOON
                                            if defaultFilter == "Expire Soon" {
                                                PrepareListExpiryView(inventory: inventory, inventoryViewModel: inventoryViewModel, counterGate: inventoryViewModel.inventoryCount)
                                            }
                                            //NOT EXPIRE SOON
                                            else {
                                                PrepareListView(inventory: inventory, inventoryViewModel: inventoryViewModel)
                                            }
                                        } else {
                                            //ON FILTER
                                            PrepareListFilterView(inventory: inventory, inventoryViewModel: inventoryViewModel, counterGate: inventoryViewModel.inventoryCount)
                                        }
                                    }
                                    .padding(.horizontal)
                                }
                            }
                        }
                        .frame(width: UIScreen.screenWidth)
                        .background(Color("AppBackground"))
                        
                        VStack {
                            Spacer()
                            HStack {
                                Text("Item Selected:").font(.system(size: 12))
                                Spacer()
                                Text("\(getTotalItemSelected()) Items").font(.system(size: 12))
                            }
                            .padding(.horizontal, 15)
                            .padding(.bottom, 5)
                            NavigationLink(
                                destination: RecipeListView(),
                                tag: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/,
                                selection: $action){
                                ButtonView(inventoryViewModel: inventoryViewModel)
                            }
                        }
                    }
                    
                } else {
                    Spacer()
                    InventoryListEmptyView()
                        .onTapGesture {
                            inventoryViewModel.isPresented = true
                        }
                    Spacer()
                }
            }
            .navigationBarTitle("Prepare")
//            .navigationBarItems(
//                trailing: Button(action: inventoryViewModel.prepareCreateData, label: {
//                    Image(systemName: "plus")
//                        .imageScale(.large)
//                        .foregroundColor(Color("BackgroundInverse"))
//                }).contentShape(Circle())
//            )
        }
        .sheet(isPresented: $inventoryViewModel.isPresented) {
            InventoryFormView(inventoryViewModel: inventoryViewModel, foodCategoryViewModel: foodCategoryViewModel, isPresented: $inventoryViewModel.isPresented, defaultFilter: $defaultFilter)
        }
//        .sheet(isPresented: $isMovedToRecipeList){
//            RecipeListView()
//        }
        .onAppear(perform: {
            inventoryViewModel.getData()
            inventoryViewModel.loadList()
            foodCategoryViewModel.getData()
        })
    }
}

struct ButtonView: View {
    @StateObject var inventoryViewModel = InventoryViewModel()
    
    var body: some View {
        if !inventoryViewModel.prepareSelectedInventory.isEmpty {
            Button {
                print(inventoryViewModel.prepareSelectedInventory.count, "TOTAL SELECTED")
            } label: {
                Text("Find Recipe")
                    .font(.system(size: 18))
                    .foregroundColor(.white)
            }
            .frame(width: UIScreen.screenWidth - 30, height: 50, alignment: .center)
            .background(Color("BrandColor"))
            .cornerRadius(15)
            .padding(.horizontal, 15)
            .padding(.bottom, 15)
        } else {
            Button {
                print(inventoryViewModel.prepareSelectedInventory.count, "TOTAL SELECTED")
            
            } label: {
                Text("Find Recipe")
                    .font(.system(size: 18))
                    .foregroundColor(Color("BackgroundInverse"))
            }
            .frame(width: UIScreen.screenWidth - 30, height: 50, alignment: .center)
            .background(Color.init(.systemGray))
            .cornerRadius(15)
            .padding(.horizontal, 15)
            .padding(.bottom, 15)
        }
    }
    
}

struct PrepareView_Previews: PreviewProvider {
    static var previews: some View {
        PrepareView()
    }
}
