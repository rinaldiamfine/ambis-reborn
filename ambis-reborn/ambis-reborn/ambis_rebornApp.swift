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
    private let watchManager = WatchManager.shared
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some Scene {
        WindowGroup {
            TabBarView()
                .onAppear(perform: UIApplication.shared.addTapGestureRecognizer)
        }
        .onChange(of: scenePhase) { phase in
            switch phase {
                case .active:
                    print("active")
                case .inactive:
                    print("inactive")
                case .background:
                    print("background")
//                    persistenceController.saveData()
                @unknown default:
                    print("unknown")
            }
        }
    }
}
