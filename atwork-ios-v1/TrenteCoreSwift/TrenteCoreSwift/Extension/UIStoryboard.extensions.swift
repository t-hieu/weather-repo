//
//  UIStoryboard.extensions.swift
//  rider-IOS
//
//  Created by VietND on 12/4/17.
//  Copyright © 2017 Portalbeanz. All rights reserved.
//

import Foundation
import UIKit

public protocol StoryboardHelper {
    static func createInstanceFromStoryboard() -> UIViewController?
}

public protocol MainStoryboard : StoryboardHelper {}
public extension MainStoryboard {
     static func createInstanceFromStoryboard() -> UIViewController? {
        let className = String(describing: self)
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: className)
    }
}
