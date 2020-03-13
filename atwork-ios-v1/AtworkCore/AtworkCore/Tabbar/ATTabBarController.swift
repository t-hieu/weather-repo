//
//  ATTabBarController.swift
//  AtworkCore
//
//  Created by CuongNV on 10/4/18.
//  Copyright © 2018 Atwork. All rights reserved.
//

import UIKit

let TABBAR_HEIGHT = CGFloat(50)
public class ATTabBarController: UITabBarController {

    public var index:Int = 0
    @IBOutlet var customTabbar: UIView!
    @IBOutlet weak var tabMonthly: ATTabBarButtonItem!
    @IBOutlet weak var tabSetting: ATTabBarButtonItem!
    @IBOutlet weak var tabDaily: ATTabBarButtonItem!
    @IBOutlet weak var tabBasic: ATTabBarButtonItem!
    override public func viewDidLoad() {
        super.viewDidLoad()
        
//        customTabbar.backgroundColor = AT_COLOR_GRAY
//        customTabbar.frame.size.width = self.view.frame.width
//        customTabbar.translatesAutoresizingMaskIntoConstraints = false
//        self.view.addSubview(customTabbar)
//        self.view.addConstraint(NSLayoutConstraint.init(item: customTabbar, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: 0))
//        self.view.addConstraint(NSLayoutConstraint.init(item: customTabbar, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: 0))
//        self.view.addConstraint(NSLayoutConstraint.init(item: customTabbar, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 0))
//        customTabbar.addConstraint(NSLayoutConstraint.init(item: customTabbar, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: TABBAR_HEIGHT))
//
        self.navigationController?.isNavigationBarHidden = true
        
//        //tab 1
//        let vc1 = MonthlyController.createInstanceFromStoryboard()!
//        let nav1 = UINavigationController.init(rootViewController: vc1)
//        nav1.tabBarItem.title = NSLocalizedString("Monthly", comment: "")
//        
//        //tab 2
//        let vc2 = DailyController.createInstanceFromStoryboard()!
//        let nav2 = UINavigationController.init(rootViewController: vc2)
//        nav2.tabBarItem.title = NSLocalizedString("Daily", comment: "")
//        
//        //tab 3
//        let vc3 = BaseController.createInstanceFromStoryboard()!
//        let nav3 = UINavigationController.init(rootViewController: vc3)
//        nav3.tabBarItem.title = NSLocalizedString("Basic", comment: "")
//        
//        //tab 4
//        let vc4 = SettingController.createInstanceFromStoryboard()!
//        let nav4 = UINavigationController.init(rootViewController: vc4)
//        nav4.tabBarItem.title = NSLocalizedString("Setting", comment: "")
//        
//        self.viewControllers = [nav1,nav2,nav3,nav4]
//        
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
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    @IBAction func changedTab(_ sender: UIButton) {
        //        if self.selectedIndex == 0 && sender.tag == 0{
        //            NotificationCenter.default.post(name: NSNotification.Name.init(LW_NOTIFICATION_DOUBLE_TAP_ON_TABBAR), object: nil)
        //        }
        self.selectedIndex = sender.tag
        self.focusTab()
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
    }

}
