//
//  ambis_rebornApp.swift
//  watch Extension
//
//  Created by Rinaldi LNU on 18/08/21.
//

import SwiftUI

@main
struct ambis_rebornApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
