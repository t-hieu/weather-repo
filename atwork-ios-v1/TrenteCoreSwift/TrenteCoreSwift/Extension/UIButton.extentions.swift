//
//  UIButton.extentions.swift
//  B1029
//
//  Created by Nguyen Duc Viet on 10/16/17.
//  Copyright © 2017 Portalbeanz. All rights reserved.
//

import UIKit
import Foundation

extension UIButton{
    func rightToLeft(padding:CGFloat){
        self.sizeToFit()
        self.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: -(self.imageView?.frame.size.width )! - padding, bottom: 0, right: (self.imageView?.frame.size.width )! + padding)
        self.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: (self.titleLabel?.frame.size.width)!, bottom: 0, right: -(self.titleLabel?.frame.size.width)!)
    }
}
