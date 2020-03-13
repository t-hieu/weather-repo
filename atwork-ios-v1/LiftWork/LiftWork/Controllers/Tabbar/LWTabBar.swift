//
//  LWTabBar.swift
//  LiftWork
//
//  Created by VietND on 6/13/18.
//  Copyright © 2018 Trente. All rights reserved.
//

import UIKit

class LWTabBar: UITabBar {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var sz = super.sizeThatFits(size)
        sz.height = 80
        return sz
    }

}
