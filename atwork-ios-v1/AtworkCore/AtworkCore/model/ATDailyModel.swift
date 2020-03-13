//
//  ATDailyModel.swift
//  AtworkCore
//
//  Created by CuongNV on 10/16/18.
//  Copyright © 2018 Atwork. All rights reserved.
//

import UIKit
import ObjectMapper
import TrenteCoreSwift

class ATDailyModel: ATBaseModel {
    var schedules = [ATScheduleModel]()
    var progress: Int!
    var siteId: Int?
    var status: Int!
    var date: Date?//yyyy/MM/dd HH:mm
    var statusName: String?
    var bgColorCode: String?
    var textColorCode: String?
    var constructionName:String?
    var isShowStatus: Bool!
    
    override public func mapping(map: Map) {
        self.schedules <- map["schedules"]
        self.progress <- map["progress"]
        self.siteId <- map["siteId"]
        self.status <- map["status"]
        self.constructionName <- map["constructionName"]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
        
        if let dateString = map["date"].currentValue as? String, let _date = dateFormatter.date(from: dateString) {
            date = _date
        }
        
        self.statusName <- map["statusName"]
        self.bgColorCode <- map["bgColorCode"]
        self.textColorCode <- map["textColorCode"]
        
    }
}
