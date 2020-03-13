//
//  LWLiftUsage.swift
//  LiftWork
//
//  Created by CuongNV on 5/28/18.
//  Copyright © 2018 Trente. All rights reserved.
//

import UIKit

public class ATLiftUsage: NSObject {
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
    var startTime: Date?
    var companyId: Int?
    
    override init() {
        super.init()
    }
    
    public init(response: [String : Any]) {
        super.init()
        
        self.companyId = response["companyId"] as? Int
//        self.key = response["tableId"] as? Int
//        self.customer = ATCustomerModel.init(response: response["customer"] as! [String: Any])
//        self.lift = ATLiftModel.init(response: response["lift"] as! [String: Any])
//        self.goodType = response["goodType"] as? String
//        self.constructionSite = ATConstructionModel.init(response: response["constructionSite"] as! [String: Any])
//        self.good = ATGoodModel.init(response: response["good"] as! [String: Any])
//        self.Operator = ATOperatorModel.init(response: response["awUser"] as! [String: Any])
        self.goodQuantity = response["goodQuantity"] as? Int
        self.times = response["times"] as? Int
        self.departure = response["departure"] as? String
        self.arrial = response["arrival"] as? String
        self.startTime = response["startTime"] as? Date
        
    }

}
