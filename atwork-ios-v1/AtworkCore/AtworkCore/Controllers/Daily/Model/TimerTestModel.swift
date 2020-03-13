//
//  TimerTestModel.swift
//  LW_Customer
//
//  Created by CuongNV on 9/25/18.
//  Copyright © 2018 Trente. All rights reserved.
//

import UIKit

class TimerTestModel: NSObject {
    var schedule: ATScheduleModel!
    var titleLabel: String!
    var numberSameCurrentTime: Int! = 0
    var currentIndex: Int! = -1
    var startTimeHour: Int!
    var startTimeMin: Int!
    var endTimeHour: Int!
    var endTimeMin: Int!
    
    func setDefault(startimeH: Int, starttimeM: Int, endtimeH: Int, endtimeM: Int, title: String) {
        self.startTimeMin = starttimeM
        self.startTimeHour = startimeH
        self.endTimeMin = endtimeM
        self.endTimeHour = endtimeH
        self.titleLabel = title
    }
    
    func setSchedule(schedule: ATScheduleModel){
        self.schedule = schedule
        
    }

}
