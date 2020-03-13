//
//  LWTabbarViewController.swift
//  LiftWork
//
//  Created by VietND on 6/7/18.
//  Copyright © 2018 Trente. All rights reserved.
//

import UIKit
import TrenteCoreSwift
enum TabIndex:Int {
    case input
    case confirm
    case setting
}

let TABBAR_HEIGHT = CGFloat(80)

class LWTabbarViewController: UITabBarController,MainStoryboard {
    
    var index:Int = 0
    @IBOutlet var customTabbar: UIView!
    @IBOutlet weak var tabInput: LWTabBarButtonItem!
    @IBOutlet weak var tabSetting: LWTabBarButtonItem!
    @IBOutlet weak var tabConfirm: LWTabBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customTabbar.backgroundColor = LW_COLOR_GRAY
        customTabbar.frame.size.width = self.view.frame.width
        customTabbar.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(customTabbar)
        self.view.addConstraint(NSLayoutConstraint.init(item: customTabbar, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint.init(item: customTabbar, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint.init(item: customTabbar, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0))
        customTabbar.addConstraint(NSLayoutConstraint.init(item: customTabbar, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: TABBAR_HEIGHT))
        
        self.navigationController?.isNavigationBarHidden = true
        
        //tab 1
        let vc1 = LWPerformanceDetailViewController.createInstanceFromStoryboard()!
        let nav1 = UINavigationController.init(rootViewController: vc1)
        nav1.tabBarItem.title = NSLocalizedString("TAB_PERFORMANCE_INPUT", comment: "")
        
        //tab 2
        let vc2 = LWPerformaceConfirmViewController.createInstanceFromStoryboard()!
        let nav2 = UINavigationController.init(rootViewController: vc2)
        nav2.tabBarItem.title = NSLocalizedString("TAB_PERFORMANCE_CONFIRM", comment: "")
        
        //tab 3
        let vc3 = LWSettingViewController.createInstanceFromStoryboard()!
        let nav3 = UINavigationController.init(rootViewController: vc3)
        nav3.tabBarItem.title = NSLocalizedString("TAB_SETTING", comment: "")
        
        self.viewControllers = [nav1,nav2,nav3]
       
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
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    @IBAction func changedTab(_ sender: UIButton) {
        if self.selectedIndex == 0 && sender.tag == 0{
            NotificationCenter.default.post(name: NSNotification.Name.init(LW_NOTIFICATION_DOUBLE_TAP_ON_TABBAR), object: nil)
        }
        self.selectedIndex = sender.tag
        self.focusTab()
    }

    func focusTab(){
        self.tabInput.changeSelected(isSelected: false)
         self.tabConfirm.changeSelected(isSelected:false)
         self.tabSetting.changeSelected(isSelected:false)
        switch self.selectedIndex {
        case 0:
            self.tabInput.changeSelected(isSelected:true)
            break
        case 1:
            self.tabConfirm.changeSelected(isSelected:true)
            break
        case 2:
            self.tabSetting.changeSelected(isSelected:true)
            break
        default:
            break
        }
    }
}
