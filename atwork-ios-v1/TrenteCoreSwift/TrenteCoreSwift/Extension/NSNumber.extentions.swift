//
//  NSNumber.extentions.swift
//  B1029
//
//  Created by Nguyen Duc Viet on 10/13/17.
//  Copyright © 2017 Portalbeanz. All rights reserved.
//

import Foundation
import UIKit

extension NSNumber{
    func formatCurrency()->String{
        let formatter = NumberFormatter()
        formatter.locale = Locale.init(identifier: "en_SG") //Singapore
        formatter.numberStyle = .currency
        formatter.currencyCode = ""
//        formatter.currencySymbol = ""
        if let formattedTipAmount = formatter.string(from: self) {
            return formattedTipAmount
        }
        return ""
    }
}
extension CGFloat {
    static var random: CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
