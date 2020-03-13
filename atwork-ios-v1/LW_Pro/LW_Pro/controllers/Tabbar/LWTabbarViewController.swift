//
//  LWTabbarViewController.swift
//  LW_Customer
//
//  Created by CuongNV on 9/27/18.
//  Copyright © 2018 Trente. All rights reserved.
//

import UIKit
import TrenteCoreSwift
import AtworkCore
enum TabIndex:Int {
    case input
    case confirm
    case setting
}

let TABBAR_HEIGHT = CGFloat(50)

public class LWTabbarViewController: UITabBarController,MainStoryboard, ATMonthlyControllerDelegate {
    
    var index:Int = 0
    @IBOutlet var customTabbar: UIView!
    @IBOutlet weak var tabMonthly: ATTabBarButtonItem!
    @IBOutlet weak var tabSetting: ATTabBarButtonItem!
    @IBOutlet weak var tabDaily: ATTabBarButtonItem!
    @IBOutlet weak var tabBasic: ATTabBarButtonItem!
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        customTabbar.backgroundColor = AT_COLOR_GRAY
        customTabbar.frame.size.width = self.view.frame.width
        customTabbar.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(customTabbar)
        self.view.addConstraint(NSLayoutConstraint.init(item: customTabbar, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint.init(item: customTabbar, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: 0))
        if #available(iOS 11.0, *) {
            self.view.addConstraint(NSLayoutConstraint.init(item: customTabbar, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view.safeAreaLayoutGuide, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 0))
        } else {
            self.view.addConstraint(NSLayoutConstraint.init(item: customTabbar, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 0))
        }
        customTabbar.addConstraint(NSLayoutConstraint.init(item: customTabbar, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: TABBAR_HEIGHT))
       
        
        self.navigationController?.isNavigationBarHidden = true
        
        //tab 1
//        let vc1 = ATMonthlyController.createInstanceFromStoryboard()!
        let vc1 = ATMonthlyController.init(nibName: ATMonthlyController.className, bundle: Bundle.init(for: ATMonthlyController.self))
        vc1.delegate = self
        let nav1 = UINavigationController.init(rootViewController: vc1)
        nav1.tabBarItem.title = NSLocalizedString("Monthly", comment: "")
        
        //tab 2
//        let vc2 = DailyController.createInstanceFromStoryboard()!
        let vc2 = ATDailyController.init(nibName: ATDailyController.className, bundle: Bundle.init(for: ATDailyController.self))
        let nav2 = UINavigationController.init(rootViewController: vc2)
        nav2.tabBarItem.title = NSLocalizedString("Daily", comment: "")
        
        //tab 3
        let vc3 = ATReservationViewController.init(nibName: ATReservationViewController.className, bundle: Bundle.init(for: ATReservationViewController.self))
        
        let nav3 = UINavigationController.init(rootViewController: vc3)
        nav3.tabBarItem.title = NSLocalizedString("予約管理", comment: "")
        
        //tab 4
        let vc4 = ATSettingViewController.init(nibName: ATSettingViewController.className, bundle: Bundle.init(for: ATSettingViewController.self))
        let nav4 = UINavigationController.init(rootViewController: vc4)
        nav4.tabBarItem.title = NSLocalizedString("Setting", comment: "")
        
        self.viewControllers = [nav1,nav2,nav3,nav4]
        
        self.selectedIndex = index
        self.focusTab()
        //        self.tabInput.addTarget(self, action: #selector(multipleTap(_:event:)), for: UIControlEvents.touchUpInside)
    }
    //     @objc func multipleTap(_ sender: UIButton, event: UIEvent) {
    //        let touch: UITouch = event.allTouches!.first!
    //        if (touch.tapCount == 2) {
    //        if self.selectedIndex == 0{
    //            NotificationCenter.default.post(name: NSNotification.Name.init(LW_NOTIFICATION_DOUBLE_TAP_ON_TABBAR), object: nil)
    //        }
    //        }
    //    }
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func hideTabbar(isHidden: Bool){
        self.customTabbar.isHidden = isHidden
    }
    
    @IBAction func changedTab(_ sender: UIButton) {
//        if self.selectedIndex == 0 && sender.tag == 0{
//            NotificationCenter.default.post(name: NSNotification.Name.init(LW_NOTIFICATION_DOUBLE_TAP_ON_TABBAR), object: nil)
//        }
        if !ATUserDefaults.getConstructionId().isEmpty || sender.tag == 0 || sender.tag == 3{
            self.selectedIndex = sender.tag
            self.focusTab()
        }
        
    }
    
    func focusTab(){
        self.tabMonthly.changeSelected(isSelected: false)
        self.tabDaily.changeSelected(isSelected:false)
        self.tabSetting.changeSelected(isSelected:false)
        self.tabBasic.changeSelected(isSelected:false)
        
        switch self.selectedIndex {
        case 0:
            self.tabMonthly.changeSelected(isSelected:true)
            break
        case 1:
            self.tabDaily.changeSelected(isSelected:true)
            
            break
        case 2:
            self.tabBasic.changeSelected(isSelected:true)
            break
        default:
            self.tabSetting.changeSelected(isSelected:true)
            break
        }
        if let topController = UIApplication.topViewController() {
            topController.navigationController?.popToRootViewController(animated: false)
        }
    }
    
    
    
    //Delegate
    
    public func changeTapToDaily() {
        self.selectedIndex = 1
        self.focusTab()
    }
    
    
}
extension UIApplication {
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}
