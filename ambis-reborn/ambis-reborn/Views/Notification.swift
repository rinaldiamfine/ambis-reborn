//
//  Notification.swift
//  ambis-reborn
//
//  Created by Rinaldi LNU on 13/07/21.
//

import SwiftUI
import UserNotifications

class Notification {
    static let instance = Notification()
    
    func requestAuthorization() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) {
            (success, error) in
            if let error = error {
                print("Error : \(error)")
            }
        }
        
    }
    
    func sendNotification(inventId: String, itemName: String, reminderDate: Date) {
        let content = UNMutableNotificationContent()
        content.title = "Inventory Has Expired"
        content.body = "Your Item \(itemName) has expired."
        content.sound = .default
//        content.badge = 1
        let dateMatching = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: reminderDate)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateMatching, repeats: false)
        let request = UNNotificationRequest(identifier: inventId, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
}
