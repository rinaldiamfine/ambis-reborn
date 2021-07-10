//
//  ambis_rebornApp.swift
//  ambis-reborn
//
//  Created by Rinaldi LNU on 05/07/21.
//

import SwiftUI
import CoreData

@main
struct ambis_rebornApp: App {
    let persistenceController = PersistenceController.shared
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some Scene {
        WindowGroup {
            TabBarView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        .onChange(of: scenePhase) { phase in
            switch phase {
                case .active:
                    print("active")
                    persistenceController.getInventoryData()
                case .inactive:
                    print("inactive")
                case .background:
                    print("background")
                    persistenceController.saveData()
            }
        }
    }
}
