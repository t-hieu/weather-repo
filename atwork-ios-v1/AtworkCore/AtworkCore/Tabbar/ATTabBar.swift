//
//  ATTabBar.swift
//  AtworkCore
//
//  Created by CuongNV on 10/4/18.
//  Copyright © 2018 Atwork. All rights reserved.
//

import UIKit

public class ATTabBar: UITabBar {

    override public func sizeThatFits(_ size: CGSize) -> CGSize {
        var sz = super.sizeThatFits(size)
        sz.height = 40
        return sz
    }

}
