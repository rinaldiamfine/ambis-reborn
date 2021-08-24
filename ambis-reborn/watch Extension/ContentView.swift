//
//  ContentView.swift
//  watch Extension
//
//  Created by Rinaldi LNU on 18/08/21.
//

import SwiftUI
import CoreData
import UserNotifications

struct FormatInventory : Identifiable {
    var id = UUID()
    var title: String
    var subtitle: String
    var expiryInt: Int
    var icon: String
}

struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
//    @FetchRequest(entity: Inventory.entity(), sortDescriptors: []) var invent: FetchedResults<Inventory>
    
    @ObservedObject var inventoryViewModel = InventoryViewModel()
    @StateObject var foodCategoryViewModel = FoodCategoryViewModel()
    
    @State var dataInventory : [FormatInventory] = [
        FormatInventory(title: "Paha Ayam", subtitle: "Fridge ・ 1Kg", expiryInt: 3, icon: "🥩"),
        FormatInventory(title: "Sayur", subtitle: "Freezer ・ 10Pcs", expiryInt: 5, icon: "🥦")
    ]
    
    func checker() {
//        var inv = PersistenceController.shared.getInventoryData().map(InventoryModel.init).sorted { $0.expiryDate < $1.expiryDate }
//        print(invent.count , "GET INV DATA")
//        print(res.count, "RES")
//        print(inventoryViewModel.inventory , "GET INVENT")
//        print(foodCategoryViewModel.getData(), "FCTG")
    }
    
    var body: some View {
        NavigationView {
            GeometryReader(content: { geometry in
                ScrollView {
                    ExpireSoonProgressBarView()
                        .ignoresSafeArea(.all, edges: .bottom)
                        .frame(width: geometry.size.width, height: geometry.safeAreaInsets.bottom + geometry.size.height)
                    
                    ExpireSoonListView().onTapGesture {
                        
                    }
                    notify
                }
            })
            .navigationTitle("Expiremind")
        }.onAppear(perform: {
            foodCategoryViewModel.getData()
            inventoryViewModel.loadList()
//                    NotificationCenter.default.addObserver(inventoryViewModel, selector: #selector(inventoryViewModel.refresh), name: NSNotification.Name(rawValue: "inventoryUpdated"), object: nil)
            checker()
        })
    }
    
    var notify: some View {
        VStack{
            Button("Request permission"){
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge]) { (success, error) in
                    if success{
                        print("All set")
                    } else if let error = error {
                        print(error.localizedDescription)
                    }
                }
            }
            Button("Schedule Notification")
            {
                let content = UNMutableNotificationContent()
                
                content.title = "Expiring in 3 days or less"
                content.subtitle = "Paha Ayam"
                content.body = "and 4 other items"
                content.sound = .default
                content.categoryIdentifier = "myCategory"
                let category = UNNotificationCategory(identifier: "myCategory", actions: [], intentIdentifiers: [], options: [])
                UNUserNotificationCenter.current().setNotificationCategories([category])
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                let request = UNNotificationRequest(identifier: "myCategory", content: content, trigger: trigger)
                UNUserNotificationCenter.current().add(request) { (error) in
                    if let error = error{
                        print(error.localizedDescription)
                    }else{
                        print("scheduled successfully")
                    }
                }
            }
        }
        
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
