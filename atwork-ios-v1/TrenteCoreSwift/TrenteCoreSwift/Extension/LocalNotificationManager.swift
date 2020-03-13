//
//  LocalNotificationManager.swift
//  B1029
//
//  Created by Nguyen Duc Viet on 10/23/17.
//  Copyright © 2017 Portalbeanz. All rights reserved.
//

import UIKit
import UserNotifications
class LocalNotificationManager: NSObject {
    static let shared = LocalNotificationManager()
    func addNewLocalNotification(identifier:String,body:String,hour:Int?,minute:Int?){
        let displayName = Bundle.main.infoDictionary!["CFBundleName"] as! String
        if #available(iOS 10.0, *) {
            let content = UNMutableNotificationContent()
            content.title = NSString.localizedUserNotificationString(forKey: displayName, arguments: nil)
            content.body = NSString.localizedUserNotificationString(forKey: body,
                                                                    arguments: nil)
            //            content.categoryIdentifier = "TIMER_EXPIRED"
            
            var dateInfo = DateComponents()
            dateInfo.hour = hour
            dateInfo.minute = minute
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateInfo, repeats: false)
            
            // Create the request object.
            let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
            
            // Schedule the request.
            let center = UNUserNotificationCenter.current()
            center.add(request) { (error : Error?) in
                if let theError = error {
                    print(theError.localizedDescription)
                }
            }
        } else {
            // Fallback on earlier versions
            let n = UILocalNotification()
            n.userInfo = ["identifier":identifier]
            n.alertTitle = displayName
            n.alertBody = body
            
            n.timeZone = Calendar.init(identifier: .gregorian).timeZone
            var dateInfo = DateComponents()
            dateInfo.hour = hour
            dateInfo.minute = minute
            n.fireDate = Calendar.init(identifier: .gregorian).date(from: dateInfo)
            UIApplication.shared.scheduleLocalNotification(n)
        }
    }
    func stopLocalNotification(identifier:String){
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identifier])
            UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: [identifier])
        }else{
            for oneEvent in UIApplication.shared.scheduledLocalNotifications! {
                let notification = oneEvent as UILocalNotification
                let userInfoCurrent = notification.userInfo! as! [String:AnyObject]
                let uid = userInfoCurrent["identifier"]! as! String
                if uid == identifier {
                    //Cancelling local notification
                    UIApplication.shared.cancelLocalNotification(notification)
                    break
                }
            }
        }
    }
    func removeAllNotification(){
        let application = UIApplication.shared
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().removeAllDeliveredNotifications()
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        }else{
            UIApplication.shared.cancelAllLocalNotifications()
        }
        application.applicationIconBadgeNumber = 1
        application.applicationIconBadgeNumber = 0
    }
}
