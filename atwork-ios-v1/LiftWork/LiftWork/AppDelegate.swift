//
//  AppDelegate.swift
//  LiftWork
//
//  Created by CuongNV on 5/3/18.
//  Copyright © 2018 Trente. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import TrenteCoreSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //statusBar
        application.isStatusBarHidden = false
        
        //IQkeyboardmanager
//        IQKeyboardManager.shared.enable = true
//        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
//        IQKeyboardManager.shared.shouldShowToolbarPlaceholder = false
//        IQKeyboardManager.shared.enableAutoToolbar = false
        
        //NavigationBar
        UINavigationBar.appearance().isHidden = true
//        UINavigationBar.appearance().barStyle = .default
//        UINavigationBar.appearance().barTintColor = LW_COLOR_BLUE_LIGHT
//        UINavigationBar.appearance().tintColor = UIColor.white
//        UINavigationBar.appearance().backgroundColor = UIColor.clear
//        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: UIBarMetrics.default)
//        UINavigationBar.appearance().shadowImage = UIImage()
//        UINavigationBar.appearance().isTranslucent = false
//
//        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white,NSAttributedStringKey.font:UIFont.boldFont(size: 25)]
        
        initRootViewController(index:0)
        return true
    }
    
    func initRootViewController(index:Int){
        
        if(LWUserDefaults.getUserId().isEmpty){
            if let vc = SignInViewController.createInstanceFromStoryboard(){
                let nav = UINavigationController.init(rootViewController: vc)
                nav.isNavigationBarHidden = true
                self.window?.rootViewController = nav
                self.window?.makeKeyAndVisible()
            }
        }else{
            if let tabbar = LWTabbarViewController.createInstanceFromStoryboard() as? LWTabbarViewController{
                tabbar.index = index
                tabbar.navigationController?.isNavigationBarHidden = true
                self.window?.rootViewController = tabbar
                self.window?.makeKeyAndVisible()
            }
        }
    }
    
    func clearAll(){
        LWUserDefaults.clear()
        UIApplication.shared.applicationIconBadgeNumber = 1
        UIApplication.shared.applicationIconBadgeNumber = 0
        self.initRootViewController(index: 0)
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
    
    
}

