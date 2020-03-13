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

public class ATLiftUsageModel: ATBaseModel {
    var key: Int?
    var customer: ATCustomerModel?
    var lift: ATLiftModel?
    var goodType: String?
    var constructionSite: ATConstructionModel?
    var good: ATGoodModel?
    var Operator: ATOperatorModel?
    var goodQuantity: Int?
    var times: Int?
    var departure: String?
    var arrial: String?
    var startTime: String?
    var companyId: Int?
    var costStatus: String?
    

    
    override public func mapping(map: Map) {
        self.companyId <- map["companyId"]
        self.key <- map["tableId"]
        self.customer <- map["customer"]
        self.lift <- map["lift"]
        self.goodType <- map["goodType"]
        self.constructionSite <- map["constructionSite"]
        self.good <- map["good"]
        self.self.Operator <- map["awUser"]
        self.goodQuantity <- map["goodQuantity"]
        self.times <- map["times"]
        self.departure <- map["departure"]
        self.arrial <- map["arrival"]
        self.startTime <- map["startTime"]
        var cost: Int?
        cost <- map["costStatus"]
        self.costStatus = cost?.description
        
    }
    
    
    public func getTime() -> String {
        if(self.startTime == nil || (self.startTime?.isEmpty)!){
            return ""
        }
        let date = TRDateUtil.makeDateCustom(date: self.startTime!, format: "yyyy/MM/dd HH:mm")
        let substring = TRFormatUtil.formatDateCustom(date: date, format: "HH:mm")
        return substring
    }
    
    public func getDateCreate() -> Date {
        let date = TRDateUtil.makeDateCustom(date: self.startTime!, format: "yyyy/MM/dd HH:mm")
        return date!
    }
    
    
    public func getFromToString() -> String {
        if(self.departure == nil){
            self.departure = ""
        }
        if(self.arrial == nil){
            self.arrial = ""
        }
        return self.departure! + " → " + self.arrial!
    }
    
    public func getElvName() -> String {
        if(self.lift != nil && self.lift?.liftName != nil){
            return (self.lift?.liftName)!
        }
        return ""
    }
    
    public func getOperatorName() -> String{
        if(self.Operator == nil||self.Operator?.userName == nil){
            return ""
        }
        return (self.Operator?.userName)!
    }
    
    public func getCustomerName() -> String{
        if(self.customer == nil||self.customer?.customerName == nil){
            return ""
        }
        return (self.customer?.customerName)!
    }
   
    public func copyLiftUsage(liftUsage: ATLiftUsageModel?){
        
        self.companyId = liftUsage?.companyId
        self.key = liftUsage?.key
        self.customer = liftUsage?.customer
        self.lift = ATLiftModel.init()
        self.lift?.copyWith(lift: (liftUsage?.lift)!)
        self.goodType = liftUsage?.goodType
        self.constructionSite = liftUsage?.constructionSite
        self.good = liftUsage?.good
        self.Operator = ATOperatorModel.init()
        self.Operator?.copyWith(op: (liftUsage?.Operator)!)
        self.goodQuantity = liftUsage?.goodQuantity
        self.times = liftUsage?.times
        self.departure = liftUsage?.departure
        self.arrial = liftUsage?.arrial
        self.startTime = liftUsage?.startTime
        self.costStatus = liftUsage?.costStatus
    }
    
}

