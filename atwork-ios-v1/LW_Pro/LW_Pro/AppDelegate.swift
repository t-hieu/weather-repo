//
//  AppDelegate.swift
//  LW_Pro
//
//  Created by CuongNV on 11/6/18.
//  Copyright © 2018 Atwork. All rights reserved.
//

import UIKit
import AtworkCore

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, ATAppDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        UINavigationBar.appearance().isHidden = true
        ATUserDefaults.setCustomerUserFlag(val: "0")
        initRootViewController(index:0)
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
    var ishidden = false
    func ishiddenTabbar(ishidden:Bool)  {
        if self.tabbar != nil {
            self.tabbar.hideTabbar(isHidden: ishidden)
        }
    }
    var tabbar:LWTabbarViewController!
    func initRootViewController(index:Int){
        
        if(ATUserDefaults.getUserId().isEmpty){
            let vc = ATSignInViewController.init(nibName: ATSignInViewController.className, bundle: Bundle.init(for: ATSignInViewController.self))
                let nav = UINavigationController.init(rootViewController: vc)
                nav.isNavigationBarHidden = true
                self.window?.rootViewController = nav
                self.window?.makeKeyAndVisible()
            
        }else{
            if let tabbar = LWTabbarViewController.createInstanceFromStoryboard() as? LWTabbarViewController{
                self.tabbar = tabbar
                tabbar.index = index
                if ishidden  {
                    tabbar.hideTabbar(isHidden: true)
                    
                }
                else {
                    tabbar.hideTabbar(isHidden: false)
                }
//                tabbar.hideTabbar(isHidden: isHidden)
//                tabbar.tabBarController?.tabBar.isHidden = true
//                tabbar.navigationController?.isToolbarHidden = true
//                tabbar.navigationController?.isNavigationBarHidden = true
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
}

