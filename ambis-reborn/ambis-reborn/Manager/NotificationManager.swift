//
//  NotificationManager.swift
//  ExpiRemind
//
//  Created by Rinaldi LNU on 03/03/22.
//

import Foundation
import SwiftUI
import UserNotifications

class NotificationManager: NSObject, UNUserNotificationCenterDelegate {
    static let shared: NotificationManager = NotificationManager()
    let notificationCenter = UNUserNotificationCenter.current()
    
    private override init(){
        super.init()
        //This assigns the delegate
        notificationCenter.delegate = self
    }

    func requestAuthorization() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        notificationCenter.requestAuthorization(options: options) {
            (success, error) in
            if let error = error {
                print("Error : \(error)")
            }
        }
        
    }

    func clearPendingNotification() {
        notificationCenter.removeAllPendingNotificationRequests()
    }
    
    func pushNotification(inventory: InventoryViewModel) {
        let content = UNMutableNotificationContent()
        content.title = "Inventory Has Expired"
        content.subtitle = "Your Item \(inventory.name) has expired."
        content.sound = UNNotificationSound.default
        // NEED TO FIX THIS TO ADD BADGES
         content.badge = 1
        let timeIntervalMinutes = 1
        let formatExpiryDate = inventory.expiryDate.addingTimeInterval(Double(-timeIntervalMinutes * 60))
        let dateMatching = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: formatExpiryDate)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateMatching, repeats: false)
        let request = UNNotificationRequest(identifier: inventory.inventoryId.uuidString, content: content, trigger: trigger)
        notificationCenter.add(request)
    }

    func showPendingNotifications() {
        notificationCenter.getPendingNotificationRequests { request in
            for req in request{
                if req.trigger is UNCalendarNotificationTrigger{
                    print((req.trigger as! UNCalendarNotificationTrigger).nextTriggerDate()?.description ?? "invalid next trigger date")
                }
            }
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler(.banner)
    }
}
