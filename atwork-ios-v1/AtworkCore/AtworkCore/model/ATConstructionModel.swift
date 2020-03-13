//
//  LWConstructionModel.swift
//  LiftWork
//
//  Created by CuongNV on 5/21/18.
//  Copyright © 2018 Trente. All rights reserved.
//

import UIKit
import ObjectMapper

public class ATConstructionModel: ATBaseModel {
    var key: Int?
    var constructionName: String?
    var constructionKana: String?
    var constructionAddress: String?
    var stairStart: String?
    var stairEnd: String?
    
    var constructionBuilding: String?
    var operatorStart: NSDate?
    var operatorEnd: NSDate?
    var siteArea: String?
    var other: String?
    var status: Int?
    var operators:[ATOperatorModel]?
    var lifts:[ATLiftModel]?
    
    var constructionNote: String?
    var siteBreakTimes = [SiteBreakTime]()//
    var reservationSetting: ReservationSettingModel!
    

    public override init() {
        super.init()
    }
    
    public required init?(map: Map) {
        super.init(map: map)
    }
    
    override public func mapping(map: Map) {
        self.key <- map["constructionId"]
         self.constructionName <- map["constructionName"]
         self.constructionKana <- map["constructionKana"]
         self.constructionAddress <- map["constructionAddress"]
         self.stairStart <- map["stairStart"]
         self.stairEnd <- map["stairEnd"]
         self.constructionBuilding <- map["constructionBuilding"]
         self.operatorStart <- map["operatorStart"]
         self.operatorEnd <- map["useoperatorEndrMail"]
        self.siteArea <- map["siteArea"]
        self.other <- map["other"]
        self.status <- map["status"]
        self.operators <- map["operators"]
        self.lifts <- map["lifts"]
        
        self.constructionNote <- map["constructionNote"]
        self.siteBreakTimes <- map["siteBreakTimes"]
        self.reservationSetting <- map["reservationSetting"]
        
    }
}
