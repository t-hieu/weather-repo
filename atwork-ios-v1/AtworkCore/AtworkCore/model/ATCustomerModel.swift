//
//  LWCustomerModel.swift
//  LiftWork
//
//  Created by CuongNV on 5/24/18.
//  Copyright © 2018 Trente. All rights reserved.
//

import UIKit
import ObjectMapper

public class ATCustomerModel: ATBaseModel {
    var customerId: Int?
    var customerName: String?
    var customerNameKana: String?
    var postalCode: String?
    var address1: String?
    var address2: String?
    var companyId: Int?
    var goods = [ATGoodModel]()
    var status: Int?
    var companyCode: String?
    var colorCode: String?
    var textColorCode: String!
    
    public override init() {
        super.init()
    }
    
    public required init?(map: Map) {
        super.init(map: map)
    }
    
    override public func mapping(map: Map) {
        self.companyId <- map["companyId"]
        self.customerId <- map["customerId"]
        self.customerName <- map["name"]
        self.customerNameKana <- map["name2"]
        self.postalCode <- map["postalCode"]
        self.address1 <- map["address1"]
        self.address2 <- map["address2"]
        self.status <- map["status"]
        self.goods <- map["goods"]
        self.companyCode <- map["companyCode"]
        self.colorCode <- map["colorCode"]
        self.textColorCode <- map["textColorCode"]
    }
}
