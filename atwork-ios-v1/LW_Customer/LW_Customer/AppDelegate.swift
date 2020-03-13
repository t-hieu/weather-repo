//
//  AppDelegate.swift
//  LW_Customer
//
//  Created by TrungND on 9/12/18.
//  Copyright © 2018 Trente. All rights reserved.
//

import UIKit
import AtworkCore
import UserNotifications
import Firebase

@UIApplicationMain
    class AppDelegate: UIResponder, UIApplicationDelegate, ATAppDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        ATUserDefaults.setCustomerUserFlag(val: "1")
        //NavigationBar
        UINavigationBar.appearance().isHidden = true
        //Firebase
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        //Notification
        // [START register_for_notifications]
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        application.registerForRemoteNotifications()
        // [END register_for_notifications]
        
        
        
        var pushNotification = false
        if #available(iOS 10.0, *) {
            //nothing
        }else{
            //redirect notification
            if launchOptions != nil {
                // opened from a push notification when the app is closed
                if let userInfo = launchOptions![.remoteNotification] as? [AnyHashable: Any]{
                    self.application(application, didReceiveRemoteNotification: userInfo)
                    pushNotification = true
                }
            }
        }
        
        if !pushNotification{
            initRootViewController(index:0)
        }
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    var tabbar:LWTabbarViewController!
    func ishiddenTabbar(ishidden:Bool)  {
        if self.tabbar != nil {
            self.tabbar.hideTabbar(isHidden: ishidden)
        }
        
    }
    
    func initRootViewController(index:Int){
        
        if(LWUserDefaults.getUserId().isEmpty){
            let vc = ATSignInViewController.init(nibName: ATSignInViewController.className, bundle: Bundle.init(for: ATSignInViewController.self))
            let nav = UINavigationController.init(rootViewController: vc)
            nav.isNavigationBarHidden = true
            self.window?.rootViewController = nav
            self.window?.makeKeyAndVisible()
            
        }else{
            if let tabbar = LWTabbarViewController.createInstanceFromStoryboard() as? LWTabbarViewController{
                self.tabbar = tabbar
                tabbar.index = index
                tabbar.navigationController?.isNavigationBarHidden = true
                self.window?.rootViewController = tabbar
                self.window?.makeKeyAndVisible()
            }
        }
        
        
    }
    func clearAll(){
        ATUserDefaults.clear()
        UIApplication.shared.applicationIconBadgeNumber = 1
        UIApplication.shared.applicationIconBadgeNumber = 0
        self.initRootViewController(index: 0)
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        if let token = Messaging.messaging().fcmToken{
            print("Firebase token: \(token)")
        }
        
        if !deviceTokenString.isEmpty {
            ATUserDefaults.setDeviceToken(val: deviceTokenString)
        }
        Messaging.messaging().apnsToken = deviceToken
        
    }
    
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("i am not available in simulator \(error)")
    }
  
}

//Receive notification IOS 9 and below
extension AppDelegate{
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        Messaging.messaging().appDidReceiveMessage(userInfo)
        self.receivePushNotification(userInfo:userInfo)
        
    }
    @nonobjc func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                              fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        Messaging.messaging().appDidReceiveMessage(userInfo)
        self.receivePushNotification(userInfo:userInfo)
        completionHandler(UIBackgroundFetchResult.newData)
    }
    
    //go to screen when click on push notification here
    func receivePushNotification(userInfo:[AnyHashable: Any]){
        print(userInfo)
        let state = UIApplication.shared.applicationState
        if(state != UIApplicationState.active){
//            let type = userInfo["type"] as! String
            let key = userInfo["key"] as! String
            let siteId = userInfo["parentKey"] as! String
            if let tabbar = LWTabbarViewController.createInstanceFromStoryboard() as? LWTabbarViewController{
                tabbar.index = 1
                tabbar.navigationController?.isNavigationBarHidden = true
                self.window?.rootViewController = tabbar
                self.window?.makeKeyAndVisible()
                let navigationController = tabbar.viewControllers![1] as! UINavigationController
                
                let vc = ATRequestEditController.init(nibName: ATRequestEditController.className, bundle: Bundle.init(for: ATRequestEditController.self))
//                vc.currentDate = self.currentDate
                vc.tableId = Int(key)
                vc.siteId = Int(siteId)
                navigationController.pushViewController(vc, animated: false)
                
                
            }
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let mainTabbarController = storyboard.instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
//            if type.elementsEqual("KD001") || type.elementsEqual("KD002") || type.elementsEqual("KD003") || type.elementsEqual("KD004") || type.elementsEqual("KD005") {
//                print("goto detail")
//                mainTabbarController.selectedIndex = 2;
//                let documentNavigationController = mainTabbarController.viewControllers![2] as! UINavigationController
//
//                let noticeDetail:NoticeDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: NoticeDetailViewController.className) as! NoticeDetailViewController
//                noticeDetail.noteId = key
//
//                documentNavigationController.pushViewController(noticeDetail, animated: false)
//            }
//            self.window?.rootViewController = mainTabbarController
//            self.window?.makeKeyAndVisible()
        }
    }
    
}


extension AppDelegate:UNUserNotificationCenterDelegate{
    // The method will be called on the delegate only if the application is in the foreground. If the method is not implemented or the handler is not called in a timely manner then the notification will not be presented. The application can choose to have the notification presented as a sound, badge, alert and/or in the notification list. This decision should be based on whether the information in the notification is otherwise visible to the user.
    @available(iOS 10.0, *)
    public func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Swift.Void){
        if UIApplication.shared.applicationState == .active{
            //self.receivePushNotification(userInfo:notification.request.content.userInfo)
            completionHandler([.badge,.alert])
        }else{
            completionHandler([.badge,.sound,.alert])
        }
    }
    
    
    // The method will be called on the delegate when the user responded to the notification by opening the application, dismissing the notification or choosing a UNNotificationAction. The delegate must be set before the application returns from applicationDidFinishLaunching:.
    @available(iOS 10.0, *)
    public func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Swift.Void){
        Messaging.messaging().appDidReceiveMessage(response.notification.request.content.userInfo)
        self.receivePushNotification(userInfo:response.notification.request.content.userInfo)
        completionHandler()
    }
}

//Receive notification on IOS 10 and above
extension AppDelegate : MessagingDelegate {
    // [START refresh_token]
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("Firebase registration token: \(fcmToken)")
    }
    // [END refresh_token]
    //handle data message in foregrounded
    func application(received remoteMessage: MessagingRemoteMessage){
    }
}
