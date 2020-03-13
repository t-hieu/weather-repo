//
//  ReservationSettingModel.swift
//  AtworkCore
//
//  Created by CuongNV on 10/18/18.
//  Copyright © 2018 Atwork. All rights reserved.
//

import UIKit
import ObjectMapper

class ReservationSettingModel: ATBaseModel {
    var siteId: Int!
    var deadlinePeriod: Int!
    var workingEndTime: String!
    var bookingPeriod: Int!
    var isBreakTimeEnable: Bool!
    var isDeadlineEnable: Bool!
    var workingStartTime: String!
    var isNoneWorkingEnable: Bool!
    
    override public func mapping(map: Map) {
        self.siteId <- map["siteId"]
        self.deadlinePeriod <- map["deadlinePeriod"]
        self.workingEndTime <- map["workingEndTime"]
        self.bookingPeriod <- map["bookingPeriod"]
        self.isBreakTimeEnable <- map["isBreakTimeEnable"]
        self.isDeadlineEnable <- map["isDeadlineEnable"]
        self.workingStartTime <- map["workingStartTime"]
        self.isNoneWorkingEnable <- map["isNoneWorkingEnable"]
    }
}
