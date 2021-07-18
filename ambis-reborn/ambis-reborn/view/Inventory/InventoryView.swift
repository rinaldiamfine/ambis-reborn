//
//  InventoryView.swift
//  ambis-reborn
//
//  Created by Rinaldi LNU on 05/07/21.
//

import SwiftUI
import UIKit
import CoreData
import UserNotifications

struct InventoryView: View {
    @ObservedObject var inventoryViewModel = InventoryViewModel()
    @ObservedObject var foodCategoryViewModel = FoodCategoryViewModel()
    @ObservedObject var searchBar: SearchBar = SearchBar()
    @State private var defaultFilter = "Expiry Soon"
    @Environment(\.colorScheme) var colorScheme
    
    @State private var searchText = ""
    @State private var showCancelButton: Bool = false
    
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
                HStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                        TextField("Search", text: $searchText, onEditingChanged: { isEditing in
                            self.showCancelButton = true
                        }, onCommit: {
                            print("onCommit")
                        }).foregroundColor(.primary)
                        Button(action: {
                            self.searchText = ""
                        }) {
                            Image(systemName: "xmark.circle.fill").opacity(searchText == "" ? 0 : 1)
                        }
                    }
                    .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
                    .foregroundColor(.secondary)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10.0)
                    if showCancelButton  {
                        Button("Cancel") {
                            UIApplication.shared.endEditing(true)
                            self.searchText = ""
                            self.showCancelButton = false
                        }
                        .foregroundColor(Color("BrandColor"))
                    }
                }
                .padding(.horizontal)
                .navigationBarHidden(showCancelButton)
                
                if inventoryViewModel.inventoryCount > 0 {
                    ScrollView {
                        Section(header: InventoryFilterView(defaultFilter: $defaultFilter)) {
                            ForEach (inventoryViewModel.inventory.filter {
                                if defaultFilter == "Expiry Soon" {
                                    return true
                                } else {
                                    if searchText.isEmpty {
                                        return $0.store.localizedStandardContains(defaultFilter)
                                    } else {
                                        return $0.name.localizedStandardContains(searchText) && $0.store.localizedStandardContains(defaultFilter)
                                    }
                                }
                            }, id:\.id) {
                                inventory in InventoryListView(inventory: inventory)
                                    .environmentObject(InventoryViewModel())
                                    .contextMenu {
                                        Button {
                                            inventoryViewModel.editData(index: inventory)
                                        } label: {
                                            Label("Update Inventory", systemImage: "square.and.pencil")
                                        }
                                        
                                        Button {
                                            print("share")
                                        } label: {
                                            Label("Share", systemImage: "arrowshape.turn.up.forward")
                                        }
                                        
                                        Divider()
                                        Button {
                                            inventoryViewModel.deleteItemByContextMenu(index: inventory)
                                        } label: {
                                            Text("Remove")
                                            Image(systemName: "trash")
                                        }
                                    }
                            }
                        }.textCase(nil)
                    }
                    .padding()
                    .background(Color("AppBackground"))
                    .listStyle(InsetGroupedListStyle())
                    
                } else {
                    InventoryListEmptyView()
                }
            }
            .navigationBarTitle("Inventory")
            .navigationBarItems(
                trailing: Button(action: inventoryViewModel.prepareCreateData, label: {
                    Image(systemName: "plus").imageScale(.large)
                }).contentShape(Circle())
            )
//            .add(self.searchBar)
        }
        .sheet(isPresented: $inventoryViewModel.isPresented) {
            InventoryFormView(inventoryViewModel: inventoryViewModel, foodCategoryViewModel: foodCategoryViewModel, isPresented: $inventoryViewModel.isPresented)
        }
        .onAppear(perform: {
            inventoryViewModel.loadList()
            foodCategoryViewModel.getData()
        })
        .onDisappear(perform: {
            inventoryViewModel.loadList()
            foodCategoryViewModel.getData()
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
