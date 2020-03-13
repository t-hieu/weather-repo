//
//  UIWindow+extensions.swift
//  TrenteCoreSwift
//
//  Created by VietND on 6/4/18.
//  Copyright © 2018 Trente. All rights reserved.
//

import Foundation
public extension UIWindow {
    public func topMostWindowController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topMostWindowController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topMostWindowController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topMostWindowController(controller: presented)
        }
        return controller
    }
}
//
//public extension UIWindow {
//
//    /** @return Returns the current Top Most ViewController in hierarchy.   */
//    public func topMostWindowController()->UIViewController? {
////
////
////        var controllersHierarchy = [UIViewController]()
////
////        if var topController = window?.rootViewController {
////            controllersHierarchy.append(topController)
////
////            while let presented = topController.presentedViewController {
////
////                topController = presented
////
////                controllersHierarchy.append(presented)
////            }
////
////            var matchController :UIResponder? = viewContainingController()
////
////            while matchController != nil && controllersHierarchy.contains(matchController as! UIViewController) == false {
////
////                repeat {
////                    matchController = matchController?.next
////
////                } while matchController != nil && matchController is UIViewController == false
////            }
////
////            return matchController as? UIViewController
////
////        } else {
////            return viewContainingController()
////        }
//    }
//
//    private func viewContainingController()->UIViewController?{
//        var nextResponder: UIResponder? = self
//
//        repeat {
//            nextResponder = nextResponder?.next
//
//            if let viewController = nextResponder as? UIViewController {
//                return viewController
//            }
//
//        } while nextResponder != nil
//
//        return nil
//    }
//}
