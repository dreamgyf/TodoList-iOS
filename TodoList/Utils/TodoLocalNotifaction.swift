//
//  TodoLocalNotifaction.swift
//  TodoList
//
//  Created by 高云峰 on 2020/11/26.
//

import UIKit

class TodoLocalNotifactionUtils {
    
    private static let notifactionCenter = UNUserNotificationCenter.current()
    
    static var isNotifactionEnable = false
    
    static func requestPermission() {
        notifactionCenter.requestAuthorization(options: [.alert, .badge, .sound]) { (res, error) in
            isNotifactionEnable = res
            print(res)
//            if !res {
//                guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
//                if UIApplication.shared.canOpenURL(url) {
//                    UIApplication.shared.open(url, completionHandler: nil)
//                }
//            }
        }
    }
    
    static func addNotifaction(id: String, date: Date, title: String, subtitle: String, body: String, action: ((Error?) -> Void)? = nil) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subtitle
        content.sound = .default
        content.body = body
        
        let componentSet: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute]
        let dateComponents = Calendar.current.dateComponents(componentSet, from: date)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
        notifactionCenter.add(request) { err in
            action?(err)
        }
    }
    
    static func removeNotifaction(id: String) {
        removeNotifaction(ids: [id])
    }
    
    static func removeNotifaction(ids: [String]) {
        notifactionCenter.removePendingNotificationRequests(withIdentifiers: ids)
    }
    
}
