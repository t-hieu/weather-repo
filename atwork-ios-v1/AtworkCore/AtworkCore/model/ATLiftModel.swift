//
//  LWLiftModel.swift
//  LiftWork
//
//  Created by CuongNV on 5/28/18.
//  Copyright © 2018 Trente. All rights reserved.
//

import UIKit
import ObjectMapper

public class ATLiftModel: ATBaseModel {
    var liftId: Int?
    var liftName: String?
    var companyId: Int?
    var status: Int?
    var no: String?
    var schedules = [ATScheduleModel]()
    
    
    public func copyWith(lift: ATLiftModel){
        self.companyId = lift.companyId
        self.liftId = lift.liftId
        self.liftName = lift.liftName
        self.status = lift.status
        self.no = lift.no
    }
    
    override public func mapping(map: Map) {
        self.companyId <- map["companyId"]
         self.liftId <- map["liftId"]
         self.self.liftName <- map["name"]
         self.status <- map["status"]
         self.no <- map["no"]
        self.schedules <- map["schedules"]
    }
}
