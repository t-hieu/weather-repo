//
//  UITextField.extensions.swift
//  rider-IOS
//
//  Created by VietND on 12/21/17.
//  Copyright © 2017 Portalbeanz. All rights reserved.
//

import UIKit
extension UITextField{
    var trimText:String?{
        return self.text?.trimmingCharacters(in: CharacterSet.whitespaces)
    }
}
