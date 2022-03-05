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
    
    func inventoryPushNotification(inventory: InventoryViewModel, type: String) {
        let content = UNMutableNotificationContent()
        let timeIntervalMinutes = 1
        let timeIntervalDays = 24 * 60 * 60
        var addTimeInterval = Double(-timeIntervalMinutes * 60)
        if type == "expiry-soon" {
            content.title = "Inventory is About to Expire"
            content.body = "Your Item \(inventory.name) is about to expire soon. Use it or share it with someone you know."
            addTimeInterval = Double(-timeIntervalMinutes * 60) + Double(-timeIntervalDays * 3) //3 DAYS BEFORE EXPIRED
        } else if type == "expiry-today" {
            content.title = "Inventory Expires Today"
            content.body = "Your Item \(inventory.name) expires today. Check whether it is still usable, and use it as soon as possible."
        } else if type == "expired" {
            content.title = "Inventory Has Expired"
            content.body = "Your Item \(inventory.name) has expired."
            addTimeInterval = Double(-timeIntervalMinutes * 60) + Double(timeIntervalDays) // + 1 DAYS (EXPIRED)
        }
        content.sound = UNNotificationSound.default
        // NEED TO FIX THIS TO ADD BADGES
         content.badge = 1
        let formatIdentifier = type + "-" + inventory.inventoryId.uuidString
        let formatExpiryDate = inventory.expiryDate.addingTimeInterval(addTimeInterval)
        let dateMatching = Calendar.current.dateComponents(
            [.year, .month, .day, .hour, .minute, .second],
            from: formatExpiryDate)
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: dateMatching,
            repeats: false)
        let request = UNNotificationRequest(
            identifier: formatIdentifier, content: content,
            trigger: trigger)
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
