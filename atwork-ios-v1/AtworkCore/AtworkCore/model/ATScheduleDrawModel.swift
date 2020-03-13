//
//  ATScheduleDrawModel.swift
//  AtworkCore
//
//  Created by CuongNV on 10/16/18.
//  Copyright © 2018 Atwork. All rights reserved.
//

import UIKit

class ATScheduleDrawModel: NSObject {
    var schedule: ATScheduleModel!
    var numberSameCurrentTime: Int! = 0
//    var ListSame = [ATScheduleDrawModel]()
    var currentIndex: Int! = -1
    var startTimeIn: Int!
    var endTimeIn: Int!
    var startTimeHour: Int!
    var startTimeMin: Int!
    var endTimeHour: Int!
    var endTimeMin: Int!
//    var startTimeInt: Int! = 0
    
    func setSchedule(schedule: ATScheduleModel){
        self.schedule = schedule
//        let start = schedule.startTime?.components(separatedBy: ":")
        if(schedule.startTimeHour.count > 0){
            self.startTimeHour = Int(schedule.startTimeHour)! - HOUR_ADD
            self.startTimeMin = Int(schedule.startTimeMin)
//            self.startTimeIn = self.startTimeHour * 60 + self.startTimeMin
        }
        
//        let end = schedule.endTime?.components(separatedBy: ":")
        if(schedule.endTimeHour.count > 0){
            self.endTimeHour = Int(schedule.endTimeHour)! - HOUR_ADD
            self.endTimeMin = Int(schedule.endTimeMin)
        }
    }
}
