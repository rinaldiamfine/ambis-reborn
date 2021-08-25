//
//  ambis_rebornApp.swift
//  watch Extension
//
//  Created by Rinaldi LNU on 18/08/21.
//

import SwiftUI
import CoreData

@main
struct ambis_rebornApp: App {
//    var managedObjectContext = (WKExtension.shared().delegate as! WatchPersistenceController).container.viewContext
    
    private let persistenceController = PersistenceController.shared
    private let watchManager = WatchManager.shared
    @Environment(\.scenePhase) private var scenePhase
    
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
        }.onChange(of: scenePhase) { phase in
            switch phase {
                case .active:
                    print("active")
                case .inactive:
                    print("inactive")
                case .background:
                    print("background")
//                    persistenceController.saveData()
                @unknown default:
                    print("Apple update status baru kah")
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
