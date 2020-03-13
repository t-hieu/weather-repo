//
//  LWCustomerModel.swift
//  LiftWork
//
//  Created by CuongNV on 5/24/18.
//  Copyright © 2018 Trente. All rights reserved.
//

import UIKit
import ObjectMapper

class LWCustomerModel: LWBaseModel {
    var customerId: Int?
    var customerName: String?
    var customerNameKana: String?
    var postalCode: String?
    var address1: String?
    var address2: String?
    var companyId: Int?
    var goods = [LWGoodModel]()
    var status: Int?
    
//    override init() {
//        super.init()
//    }
//
//    public init(response: [String : Any]) {
//        super.init()
//        self.companyId = response["companyId"] as? Int
//        self.customerId = response["customerId"] as? Int
//        self.customerName = response["name"] as? String
//        self.customerNameKana = response["name2"] as? String
//        self.postalCode = response["postalCode"] as? String
//        self.address1 = response["address1"] as? String
//        self.address2 = response["address2"] as? String
//        self.status = response["status"] as? Int
//
//        self.goods.removeAll()
//        if(response["goods"] != nil){
//            for res in response["goods"] as! NSArray{
//                let good = LWGoodModel.init(response: res as! [String: Any])
//                self.goods.append(good)
//            }
//        }
//      }
    
  override func mapping(map: Map) {
    self.companyId <- map["companyId"]
    self.customerId <- map["customerId"]
    self.customerName <- map["name"]
    self.customerNameKana <- map["name2"]
    self.postalCode <- map["postalCode"]
    self.address1 <- map["address1"]
    self.address2 <- map["address2"]
    self.status <- map["status"]
    self.goods <- map["goods"]
    }
}
