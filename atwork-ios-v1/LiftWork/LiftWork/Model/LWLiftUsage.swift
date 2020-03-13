//
//  LWLiftUsage.swift
//  LiftWork
//
//  Created by CuongNV on 5/28/18.
//  Copyright © 2018 Trente. All rights reserved.
//

import UIKit

class LWLiftUsage: NSObject {
    var key: Int?
    var customer: LWCustomerModel?
    var lift: LWLiftModel?
    var goodType: String?
    var constructionSite: LWConstructionModel?
    var good: LWGoodModel?
    var Operator: LWOperatorModel?
    var goodQuantity: Int?
    var times: Int?
    var departure: String?
    var arrial: String?
    var startTime: Date?
    var companyId: Int?
    
    override init() {
        super.init()
    }
    
    public init(response: [String : Any]) {
        super.init()
        
        self.companyId = response["companyId"] as? Int
//        self.key = response["tableId"] as? Int
        self.customer = LWCustomerModel.init(response: response["customer"]as! [String: Any])
        self.lift = LWLiftModel.init(response: response["lift"] as! [String: Any])
        self.goodType = response["goodType"] as? String
        self.constructionSite = LWConstructionModel.init(response: response["constructionSite"] as! [String: Any])
        self.good = LWGoodModel.init(response: response["good"] as! [String: Any])
        self.Operator = LWOperatorModel.init(response: response["awUser"] as! [String: Any])
        self.goodQuantity = response["goodQuantity"] as? Int
        self.times = response["times"] as? Int
        self.departure = response["departure"] as? String
        self.arrial = response["arrival"] as? String
        self.startTime = response["startTime"] as? Date
        
    }

}
