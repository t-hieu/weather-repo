//
//  ATAppDelegate.swift
//  AtworkCore
//
//  Created by CuongNV on 10/5/18.
//  Copyright © 2018 Atwork. All rights reserved.
//

import UIKit

public protocol ATAppDelegate {
    func initRootViewController(index:Int)
    func clearAll()
    func ishiddenTabbar(ishidden:Bool)
}
