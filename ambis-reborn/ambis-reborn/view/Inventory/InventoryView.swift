//
//  InventoryView.swift
//  ambis-reborn
//
//  Created by Rinaldi LNU on 05/07/21.
//

import SwiftUI
//import UIKit
import CoreData
import UserNotifications

struct InventoryView: View {
    @StateObject var inventoryViewModel = InventoryViewModel()
    @StateObject var foodCategoryViewModel = FoodCategoryViewModel()
    @ObservedObject var searchBar: SearchBar = SearchBar()
    @State private var defaultFilter = "Expire Soon"
    @Environment(\.colorScheme) var colorScheme
    
    @State private var searchText = ""
    @State private var showCancelButton: Bool = false
    @State private var needRefresh = true
    @State var totalInventSearch: Int = 0
    
    var storeAvailable = AppGlobalData.generateDataStore()
    
    func getIconName() -> Image {
        return Image(systemName: "list.dash")
    }
    func gettabName() -> Text {
        return Text("Inventory")
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                if inventoryViewModel.inventoryCount > 0 {
                    ScrollView {
                        VStack(spacing: 10) {
                            InventoryFilterView(defaultFilter: $defaultFilter, isSearchActive: $showCancelButton, searchText: $searchText, showCancelButton: $showCancelButton)
                        }
                        .padding(.horizontal)
                        
                        Section {
                            ForEach (inventoryViewModel.inventory.filter {
                                if defaultFilter == "Expire Soon" {
                                    if !showCancelButton {
                                        if $0.expiryDate <= Date().addingTimeInterval(24 * 60 * 60 * 3) {
                                            return true
                                        } else {
                                            return false
                                        }
                                    } else {
                                        return $0.name.localizedStandardContains(searchText)
                                    }
                                } else {
                                    if !showCancelButton  {
                                        return $0.store.localizedStandardContains(defaultFilter)
                                    } else {
                                        return $0.name.localizedStandardContains(searchText)
                                    }
                                }
                            }, id:\.id) {
                                inventory in
                                VStack(spacing: 10) {
                                    if !showCancelButton {
                                        // EXPIRE SOON
                                        if defaultFilter == "Expire Soon" {
                                            InventoryListExpiryView(inventory: inventory, inventoryViewModel: inventoryViewModel, counterGate: inventoryViewModel.inventoryCount)
                                        }
                                        //NOT EXPIRE SOON
                                        else {
                                            InventoryListView(inventory: inventory, inventoryViewModel: inventoryViewModel)
                                        }
                                    } else {
                                        //ON FILTER
                                        InventoryListFilterView(inventory: inventory, inventoryViewModel: inventoryViewModel, counterGate: inventoryViewModel.inventoryCount)
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                    .frame(width: UIScreen.screenWidth)
                    .background(Color("AppBackground"))
                } else {
                    Spacer()
                    InventoryListEmptyView()
                        .onTapGesture {
                            inventoryViewModel.isPresented = true
                        }
                    Spacer()
                }
            }
            .navigationBarTitle("Inventory")
            .navigationBarItems(
                trailing: Button(action: inventoryViewModel.prepareCreateData, label: {
                    Image(systemName: "plus").imageScale(.large)
                }).contentShape(Circle())
            )
        }
        .sheet(isPresented: $inventoryViewModel.isPresented) {
            InventoryFormView(inventoryViewModel: inventoryViewModel, foodCategoryViewModel: foodCategoryViewModel, isPresented: $inventoryViewModel.isPresented, defaultFilter: $defaultFilter)
        }
        .onAppear(perform: {
            inventoryViewModel.getData()
            inventoryViewModel.loadList()
            foodCategoryViewModel.getData()
            NotificationCenter.default.addObserver(inventoryViewModel, selector: #selector(inventoryViewModel.refresh), name: NSNotification.Name(rawValue: "inventoryUpdated"), object: nil)
        })
    }
}

//struct InventoryView_Previews: PreviewProvider {
//    static var previews: some View {
//        InventoryView()
//    }
//}

extension UIApplication {
    func endEditing(_ force: Bool) {
        self.windows
            .filter{$0.isKeyWindow}
            .first?
            .endEditing(force)
    }
}

struct ResignKeyboardOnDragGesture: ViewModifier {
    var gesture = DragGesture().onChanged{_ in
        UIApplication.shared.endEditing(true)
    }
    func body(content: Content) -> some View {
        content.gesture(gesture)
    }
}

extension View {
    func resignKeyboardOnDragGesture() -> some View {
        return modifier(ResignKeyboardOnDragGesture())
    }
}
