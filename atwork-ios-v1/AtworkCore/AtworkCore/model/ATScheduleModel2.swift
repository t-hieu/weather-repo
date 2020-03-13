//
//  ATScheduleModel.swift
//  AtworkCore
//
//  Created by CuongNV on 10/9/18.
//  Copyright © 2018 Atwork. All rights reserved.
//

import UIKit
import ObjectMapper

class ATScheduleModel2: ATBaseModel {
    var siteId: Int!
    var goodQuantity: Int!
    var tableId: Int!
    var times: Int! = -1
    var goodType: String?
    var categoryId: Int! = 0
    var gate: Int! = -1
    var isForkLift: Int! = -1
    var vehicles = [VehicleModel]()
    var companyId: Int!
    var status: Int! = 1
    var statusString: String!
    var customer: ATCustomerModel!
    var note: String?
    var arrival: String?
    var arrival2: String?
    var arrival3: String?
    var departure: String?
    var packingMethodIds: String? = ""
    var constructionSite: ATConstructionModel?
    var goods = [ATGoodModel]()
    var liftIds = [Int]()
    var liftNames: String! = ""
    var scheduleType: Int?
    var startTimeHour: String! = ""
    var startTimeMin: String! = ""
    var endTimeHour: String! = ""
    var endTimeMin: String! = ""
    var startDate: String?
    var endDate: String?
    var imagePath: String?
    var createDateStr: String!
    var updateDateStr: String!
    var createUserName: String!
    var updateUserName: String!
    
    var scheduleBGColor: String!
    var scheduleTextColor: String!
    var createUserModel: ATUserModel!
    var reservationOperationStart:String!
    var reservationOperationEnd:String!
    var applicableStr:String!
    var decicedDateStr:String!
    var breakTimeStr:String!
    var breakTimeEnable : Int! = -1
    override init() {
        super.init()
    }
    
    public required init?(map: Map) {
        super.init(map: map)
    }
    
    override public func mapping(map: Map) {
        self.gate <- map["gate"]
        self.siteId <- map["siteId"]
        self.goodQuantity <- map["goodQuantity"]
        self.tableId <- map["tableId"]
        self.times <- map["times"]
        self.goodType <- map["goodType"]
        self.categoryId <- map["categoryId"]
        self.status <- map["status"]
        self.isForkLift <- map["isForkLift"]
        self.vehicles <- map["vehicles"]
        self.companyId <- map["companyId"]
        self.customer <- map ["customer"]
        self.note <- map ["note"]
        self.arrival <- map ["arrival"]
        self.arrival2 <- map ["arrival2"]
        self.arrival3 <- map ["arrival3"]
        self.departure <- map ["departure"]
        self.packingMethodIds <- map ["packingMethodIds"]
        self.constructionSite <- map ["constructionSite"]
        self.goods <- map ["goods"]
        self.scheduleType <- map ["scheduleType"]
        self.reservationOperationStart <- map["reservationOperationStart"]
        self.reservationOperationEnd <- map["reservationOperationEnd"]
        self.applicableStr <- map["applicableStr"]
        self.breakTimeStr <- map["breakTimeStr"]
        self.decicedDateStr <- map["decicedDateStr"]
        self.breakTimeEnable <- map["breakTimeEnable"]
        var liftString: String! = ""
        liftString <- map["liftIds"]
        
        if(liftString.count > 0){
            let lifts = liftString.components(separatedBy: ",")
            for temp in lifts {
                self.liftIds.append(Int(temp)!)
            }
        }
        self.liftNames <- map["liftNames"]
        self.imagePath <- map ["imagePath"]
        var start : String = ""
        start <- map ["startDate"]
        if start.count > 5 {
            let array = start.components(separatedBy: " ")
            if array.count > 1 {
                self.startDate = array[0]
            }
        }
        if tableId == 0 && self.gate == 0 {
            self.gate = -1
        }
        if tableId == 0 && self.isForkLift == 0 {
            self.isForkLift = -1
        }
        
        var startTimeString : String = ""
        startTimeString <- map ["startTime"]
        let startTime = startTimeString.components(separatedBy: ":")
        if startTime.count > 1 {
            self.startTimeHour = startTime[0]
            self.startTimeMin = startTime[1]
        }
        
        
        var end : String = ""
        end <- map ["endDate"]
        if end.count > 5 {
            let array = end.components(separatedBy: " ")
            if array.count > 1 {
                self.endDate = array[0]
            }
        }
        
        var endTimeString : String = ""
        endTimeString <- map ["endTime"]
        let endTime = endTimeString.components(separatedBy: ":")
        if endTime.count > 1 {
            self.endTimeHour = endTime[0]
            self.endTimeMin = endTime[1]
        }
        if self.startTimeHour.elementsEqual("00") && self.startTimeMin.elementsEqual("00") && self.endTimeHour.elementsEqual("00") && self.endTimeMin.elementsEqual("00") {
            self.startTimeHour = ""
            self.startTimeMin = ""
            self.endTimeHour = ""
            self.endTimeMin = ""
        }
        self.createUserModel <- map["createUserModel"]
        
        self.createDateStr <- map ["createDate"]
        self.updateDateStr <- map ["updateDateStr"]
        self.createUserName <- map ["createUserName"]
        self.updateUserName <- map ["updateUserName"]
        
        if self.customer != nil && self.customer.textColorCode != nil && self.customer.textColorCode.count > 0 {
            self.scheduleTextColor = self.customer.textColorCode
        }else {
            self.scheduleTextColor = "#ffffff"
        }
        
        if self.customer != nil && self.customer.colorCode != nil && (self.customer.colorCode?.count)! > 0 {
            self.scheduleBGColor = self.customer.colorCode
        }else {
            self.scheduleBGColor = "#000000"
        }
    }
    
    public func copySchedule(scheduleModel: ATScheduleModel2){
        self.siteId = scheduleModel.siteId
        self.goodQuantity = scheduleModel.goodQuantity
        self.tableId = scheduleModel.tableId
        self.times = scheduleModel.times
        self.goodType = scheduleModel.goodType
        self.categoryId = scheduleModel.categoryId
        self.gate = scheduleModel.gate
        self.isForkLift = scheduleModel.isForkLift
        self.vehicles = scheduleModel.vehicles
        self.companyId = scheduleModel.companyId
        self.status = scheduleModel.status
        self.statusString = scheduleModel.statusString
        self.customer = scheduleModel.customer
        self.note = scheduleModel.note
        self.arrival = scheduleModel.arrival
        self.arrival2 = scheduleModel.arrival2
        self.arrival3 = scheduleModel.arrival3
        self.departure = scheduleModel.departure
        self.packingMethodIds = scheduleModel.packingMethodIds
        self.constructionSite = scheduleModel.constructionSite
        self.goods = scheduleModel.goods
        self.liftIds = scheduleModel.liftIds
        self.scheduleType = scheduleModel.scheduleType
        self.startTimeHour = scheduleModel.startTimeHour
        self.startTimeMin = scheduleModel.startTimeMin
        self.endTimeHour = scheduleModel.endTimeHour
        self.endTimeMin = scheduleModel.endTimeMin
        self.startDate = scheduleModel.startDate
        self.endDate = scheduleModel.endDate
        self.imagePath = scheduleModel.imagePath
        self.createDateStr = scheduleModel.createDateStr
        self.updateDateStr = scheduleModel.updateDateStr
        self.createUserName = scheduleModel.createUserName
        self.updateUserName = scheduleModel.updateUserName
        self.scheduleBGColor = scheduleModel.scheduleBGColor
        self.scheduleTextColor = scheduleModel.scheduleTextColor
    }
    
    
    
    func getStarttimeShow() -> String {
       
        if self.startTimeHour.count > 0 && self.startTimeMin.count > 0 {
//            var startimeHShow = String(Int(self.startTimeHour)! + HOUR_ADD)
//            if startimeHShow.count < 2 {
//                startimeHShow = "0" + startimeHShow
//            }
//            var starttimeMShow = self.startTimeMin
//            if (starttimeMShow?.count)! < 2 {
//                starttimeMShow = "0" + starttimeMShow!
//            }
            return  startTimeHour + ":" + startTimeMin!
        }
        return ""
    }

    func getEndtimeShow() -> String {
        
        if self.endTimeHour.count > 0 && self.endTimeMin.count > 0 {
//            var endtimeHShow = String(Int(self.endTimeHour)! + HOUR_ADD)
//            if endtimeHShow.count < 2 {
//                endtimeHShow = "0" + endtimeHShow
//            }
//            var endtimeMShow = self.endTimeMin
//            if (endtimeMShow?.count)! < 2 {
//                endtimeMShow = "0" + endtimeMShow!
//            }
            return  endTimeHour + ":" + endTimeMin!
        }
        return ""
    }
    func getStarttimeSend() -> String {
        if self.startTimeHour != nil && self.startTimeHour.count > 0 && self.startTimeMin != nil && self.startTimeMin.count > 0 {
//            var startimeHShow = String(Int(self.startTimeHour)! - HOUR_ADD)
//            if startimeHShow.count < 2 {
//                startimeHShow = "0" + startimeHShow
//            }
//            var starttimeMShow = self.startTimeMin
//            if (starttimeMShow?.count)! < 2 {
//                starttimeMShow = "0" + starttimeMShow!
//            }
            return  startTimeHour + ":" + startTimeMin!
        }
        return ""
    }
    
    func getEndtimeSend() -> String {
        if self.endTimeHour != nil && self.endTimeHour.count > 0 && self.endTimeMin != nil && self.endTimeMin.count > 0 {
//            var endtimeHShow = String(Int(self.endTimeHour)! - HOUR_ADD)
//            if endtimeHShow.count < 2 {
//                endtimeHShow = "0" + endtimeHShow
//            }
//            var endtimeMShow = self.endTimeMin
//            if (endtimeMShow?.count)! < 2 {
//                endtimeMShow = "0" + endtimeMShow!
//            }
            return  endTimeHour + ":" + endTimeMin!
        }
        return ""
    }
}
