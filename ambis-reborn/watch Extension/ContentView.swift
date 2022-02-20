//
//  ContentView.swift
//  watch Extension
//
//  Created by Rinaldi LNU on 18/08/21.
//

import SwiftUI
import CoreData
import UserNotifications
import WatchConnectivity

struct FormatInventory : Identifiable {
    var id = UUID()
    var title: String
    var subtitle: String
    var expiryInt: Int
    var icon: String
}

struct ContentView: View {
    @StateObject var inventoryViewModel = InventoryViewModel()
    @StateObject var foodCategoryViewModel = FoodCategoryViewModel()
    
    @State var dataInventory : [FormatInventory] = []
    @State var firstDataInventory : [FormatInventory] = []
    @State var secondDataInventory : [FormatInventory] = []
    
    let todayDate = Date().addingTimeInterval(24 * 60 * 60)
    let dangerDate = Date().addingTimeInterval(24 * 60 * 60 * 4)
    
    func setupData() {
        inventoryViewModel.inventory.filter { inv in
            if inv.expiryDate <= todayDate {
                dataInventory.append(FormatInventory(title: inv.name, subtitle: setupSubtitle(data: inv), expiryInt: 1, icon: inv.watchIcon))
                firstDataInventory.append(FormatInventory(title: inv.name, subtitle: setupSubtitle(data: inv), expiryInt: 1, icon: inv.watchIcon))
                return true
            } else if inv.expiryDate > todayDate && inv.expiryDate <= dangerDate {
                dataInventory.append(FormatInventory(title: inv.name , subtitle: setupSubtitle(data: inv), expiryInt: 1, icon: inv.watchIcon))
                secondDataInventory.append(FormatInventory(title: inv.name, subtitle: setupSubtitle(data: inv), expiryInt: 1, icon: inv.watchIcon))
                return true
            } else {
                return false
            }
        }
    }
    
    func setupSubtitle(data: InventoryModel) -> String {
        let formatText = "\(data.store ) ・ \(data.total) \(data.totalType)"
        return formatText
    }
    
    func DirectSetupNotif() {
        
        print(WCSession.default.applicationContext, "APPLICATIO CONTE")
        print(WCSession.default.receivedApplicationContext, "Direct APPLICATION CONTENXT")
        
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
    
    func setupNotification(data: Inventory) {
        let content = UNMutableNotificationContent()
        
        content.title = "Inventory Has Expired"
        content.body = "Your Item \(data.name ?? "") has expired."
        content.sound = .default
        
//        let dateMatching = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: data.expiryDate!)
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateMatching, repeats: false)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
    var body: some View {
        NavigationView {
            GeometryReader(content: { geometry in
                if (dataInventory.count != 0) {
                    List {
                        if firstDataInventory.count != 0 {
                            Section(header: Text("In 1 day or less")) {
                                ForEach(firstDataInventory) { data in
                                    HStack {
                                        ZStack {
                                            Circle()
                                                .frame(width: 30, height: 30)
                                                .foregroundColor(.black)
                                            Text(data.icon).font(.system(.body))
                                        }
                                        VStack(alignment: .leading) {
                                            Text(data.title).font(.system(.body, design: .rounded))
                                            Text(data.subtitle).font(.system(.footnote, design: .rounded))
                                        }.padding(.all, 4)
                                        Spacer()
                                    }
                                }
                            }
                        }
                        
                        if secondDataInventory.count != 0 {
                            Section(header: Text("In 2-3 days")) {
                                ForEach(secondDataInventory) { data in
                                    HStack {
                                        ZStack {
                                            Circle()
                                                .frame(width: 30, height: 30)
                                                .foregroundColor(.black)
                                            Text(data.icon).font(.system(.body))
                                        }
                                        VStack(alignment: .leading) {
                                            Text(data.title).font(.system(.body, design: .rounded))
                                            Text(data.subtitle).font(.system(.footnote, design: .rounded))
                                        }.padding(.all, 4)
                                        Spacer()
                                    }
                                }
                            }
                        }
                    }
                } else {
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
//                        .onTapGesture {
//                            DirectSetupNotif()
//                        }
                        Text("Congratulations")
                            .font(.system(.headline, design: .rounded))
//                            .onTapGesture {
//                                DirectSetupNotif()
//                            }
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
            foodCategoryViewModel.getData()
            inventoryViewModel.loadList()
            setupData()
            
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge]) { (success, error) in
                if success{
                    print("All set")
                } else if let error = error {
                    print(error.localizedDescription)
                }
            }
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
