//
//  SiteBreakTime.swift
//  AtworkCore
//
//  Created by CuongNV on 10/18/18.
//  Copyright © 2018 Atwork. All rights reserved.
//

import UIKit
import ObjectMapper

class SiteBreakTime: ATBaseModel {
    var breakStartTime: String!
    var breakEndTime: String!
    
    override public func mapping(map: Map) {
        self.breakStartTime <- map["breakStartTime"]
        self.breakEndTime <- map["breakEndTime"]
    }
}
