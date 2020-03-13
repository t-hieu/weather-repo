//
//  LWLiftUsageModel.swift
//  LiftWork
//
//  Created by CuongNV on 5/28/18.
//  Copyright © 2018 Trente. All rights reserved.
//

import UIKit
import TrenteCoreSwift
import ObjectMapper

class LWLiftUsageModel: LWBaseModel {
    var key: Int?
    var customer: LWCustomerModel?
    var lift: LWLiftModel?
    var goodType: String?
    var constructionSite: LWConstructionModel?
    var good: LWGoodModel?
    var expandGoods: [LWGoodModel]?
    var Operator: LWOperatorModel?
    var goodQuantity: Int?
    var times: Int?
    var departure: String?
    var arrial: String?
    var startTime: String?
    var companyId: Int?
    var costStatus: String?
    var carryTypeName:String?
    
    
//    public init(response: [String : Any]) {
//        super.init()
//
//        self.companyId = response["companyId"] as? Int
//        self.key = response["tableId"] as? Int
//        if(response["customer"] != nil){
//            self.customer = LWCustomerModel.init(response: response["customer"]as! [String: Any])
//        }else {
//            self.customer = LWCustomerModel.init()
//        }
//        if(response["lift"] != nil){
//            self.lift = LWLiftModel.init(response: response["lift"] as! [String: Any])
//        }else {
//            self.lift = LWLiftModel.init()
//        }
//        self.goodType = response["goodType"] as? String
//        if(response["constructionSite"] != nil){
//            self.constructionSite = LWConstructionModel.init(response: response["constructionSite"] as! [String: Any])
//        } else {
//            self.constructionSite = LWConstructionModel.init()
//        }
//        if(response["good"] != nil){
//            self.good = LWGoodModel.init(response: response["good"] as! [String: Any])
//        }else {
//            self.good = LWGoodModel.init()
//        }
//        if(response["awUser"] != nil){
//            self.Operator = LWOperatorModel.init(response: response["awUser"] as! [String: Any])
//        }else {
//            self.Operator = LWOperatorModel.init()
//        }
//        self.goodQuantity = response["goodQuantity"] as? Int
//        self.times = response["times"] as? Int
//        self.departure = response["departure"] as? String
//        self.arrial = response["arrival"] as? String
//
//        self.startTime = response["startTime"] as? String

//    }
    
    override func mapping(map: Map) {
        self.companyId <- map["companyId"]
        self.key <- map["tableId"]
        self.customer <- map["customer"]
        self.lift <- map["lift"]
        self.goodType <- map["goodType"]
        self.constructionSite <- map["constructionSite"]
        self.good <- map["good"]
        self.expandGoods <- map["expandGoods"]
        self.self.Operator <- map["awUser"]
        self.goodQuantity <- map["goodQuantity"]
        self.times <- map["times"]
        self.departure <- map["departure"]
        self.arrial <- map["arrival"]
        self.startTime <- map["startTime"]
        self.carryTypeName <- map["carryTypeName"]
        var cost: Int?
        cost <- map["costStatus"]
        self.costStatus = cost?.description
        
    }
    
    
    func getTime() -> String {
        if(self.startTime == nil || (self.startTime?.isEmpty)!){
            return ""
        }
        let date = TRDateUtil.makeDateCustom(date: self.startTime!, format: "yyyy/MM/dd HH:mm")
        let substring = TRFormatUtil.formatDateCustom(date: date, format: "HH:mm")
        return substring
    }
    
    func getDateCreate() -> Date {
        let date = TRDateUtil.makeDateCustom(date: self.startTime!, format: "yyyy/MM/dd HH:mm")
        return date!
    }
    
    
    func getFromToString() -> String {
        if(self.departure == nil){
            self.departure = ""
        }
        if(self.arrial == nil){
            self.arrial = ""
        }
        return self.departure! + " → " + self.arrial!
    }
    
    func getElvName() -> String {
        if(self.lift != nil && self.lift?.liftName != nil){
            return (self.lift?.liftName)!
        }
        return ""
    }
    
    func getOperatorName() -> String{
        if(self.Operator == nil||self.Operator?.userName == nil){
            return ""
        }
        return (self.Operator?.userName)!
    }
    
    func getCustomerName() -> String{
        if(self.customer == nil||self.customer?.customerName == nil){
            return ""
        }
        return (self.customer?.customerName)!
    }
   
    func copyLiftUsage(liftUsage: LWLiftUsageModel?){
        
        self.companyId = liftUsage?.companyId
        self.key = liftUsage?.key
        self.customer = liftUsage?.customer
        self.lift = LWLiftModel.init()
        self.lift?.copyWith(lift: (liftUsage?.lift)!)
        self.goodType = liftUsage?.goodType
        self.constructionSite = liftUsage?.constructionSite
        self.good = liftUsage?.good
        self.expandGoods = liftUsage?.expandGoods
        self.Operator = LWOperatorModel.init()
        self.Operator?.copyWith(op: (liftUsage?.Operator)!)
        self.goodQuantity = liftUsage?.goodQuantity
        self.times = liftUsage?.times
        self.departure = liftUsage?.departure
        self.arrial = liftUsage?.arrial
        self.startTime = liftUsage?.startTime
        self.costStatus = liftUsage?.costStatus
        self.carryTypeName = liftUsage?.carryTypeName
    }
    
}

