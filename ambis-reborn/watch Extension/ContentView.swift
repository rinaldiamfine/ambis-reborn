//
//  ContentView.swift
//  watch Extension
//
//  Created by Rinaldi LNU on 18/08/21.
//

import SwiftUI
import CoreData

struct FormatInventory : Identifiable {
    var id = UUID()
    var title: String
    var subtitle: String
    var expiryInt: Int
    var icon: String
}

struct ContentView: View {
    @Environment(\.managedObjectContext) private var managedObjectContext
//    @FetchRequest(entity: Inventory.entity(), sortDescriptors: []) var invent: FetchedResults<Inventory>
    
    @StateObject var inventoryViewModel = InventoryViewModel()
    @StateObject var foodCategoryViewModel = FoodCategoryViewModel()
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Inventory.expiryDate, ascending: true)], animation: .default)
    private var myInvent: FetchedResults<Inventory>
    
    @State var dataInventory : [FormatInventory] = [
        FormatInventory(title: "Paha Ayam", subtitle: "Fridge ・ 1Kg", expiryInt: 3, icon: "🥩"),
        FormatInventory(title: "Sayur", subtitle: "Freezer ・ 10Pcs", expiryInt: 5, icon: "🥦")
    ]
    
    func checker() {
        print(inventoryViewModel.inventory, "INVENT")
        print(myInvent.count, "MY INVENT")
//        var inv = PersistenceController.shared.getInventoryData().map(InventoryModel.init).sorted { $0.expiryDate < $1.expiryDate }
//        print(invent.count , "GET INV DATA")
//        print(res.count, "RES")
//        print(inventoryViewModel.inventory , "GET INVENT")
//        print(foodCategoryViewModel.getData(), "FCTG")
    }
    
    func setupSubtitle(data: Inventory) -> String {
        let formatText = "\(data.store ?? "") ・ \(data.total)\(data.totalType ?? "")"
        return formatText
    }
    
    var body: some View {
        NavigationView {
            GeometryReader(content: { geometry in
                List {
                    ForEach(myInvent) { invent in
                        HStack {
                            ZStack {
                                Circle()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.black)
                                Text(invent.toFoodCategory?.imageString ?? "").font(.system(.body))
                            }
                            VStack(alignment: .leading) {
                                Text(invent.name ?? "").font(.system(.body, design: .rounded))
                                Text(setupSubtitle(data: invent)).font(.system(.footnote, design: .rounded))
                            }.padding(.all, 4)
                            Spacer()
                        }
                    }
                }
//                ScrollView {
//                    ExpireSoonProgressBarView()
//                        .ignoresSafeArea(.all, edges: .bottom)
//                        .frame(width: geometry.size.width, height: geometry.safeAreaInsets.bottom + geometry.size.height)
//
//                    ExpireSoonListView()
//                }
            })
            .navigationTitle("Expiremind")
        }.onAppear(perform: {
            foodCategoryViewModel.getData()
            inventoryViewModel.loadList()
//                    NotificationCenter.default.addObserver(inventoryViewModel, selector: #selector(inventoryViewModel.refresh), name: NSNotification.Name(rawValue: "inventoryUpdated"), object: nil)
            checker()
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
            EmptyStateContentView()
        }
    }
}


struct EmptyStateContentView: View {
    var body: some View {
        NavigationView {
            GeometryReader(content: { geometry in
                ScrollView {
                    VStack(alignment: .center, spacing: 5) {
                        Spacer()
                        ZStack {
                            Circle()
                                .stroke(style: StrokeStyle(lineWidth: 7.84, lineCap: .round, lineJoin: .round))
                                .foregroundColor(Color("BrandColor"))
                                .frame(width: 75.12)
                            Circle()
                                .foregroundColor(Color("BrandColor"))
                                .frame(width: 52.26)
                            Text("👍🏻").font(.title2)
                        }
                        Text("Congratulations")
                            .font(.system(.headline, design: .rounded))
                        Text("No item will reach\nexpired in 3 days")
                            .multilineTextAlignment(.center)
                            .font(.system(.footnote, design: .rounded))
                        Spacer()
                    }
                    .ignoresSafeArea(.all, edges: .bottom)
                    .frame(width: geometry.size.width, height: geometry.safeAreaInsets.bottom + geometry.size.height)
                }
            })
            .navigationTitle("Expiremind")
        }.onAppear(perform: {
        })
    }
}
