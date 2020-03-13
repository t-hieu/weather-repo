//
//  LWLiftMaterialModel.swift
//  LiftWork
//
//  Created by CuongNV on 5/24/18.
//  Copyright © 2018 Trente. All rights reserved.
//

import UIKit
import ObjectMapper
class LWGoodModel: LWBaseModel {
    
    var goodId: Int?
    var goodName: String?
    var goodNameKana: String?
    var companyId: Int?
    var status: Int?
    
//    override init() {
//        super.init()
//    }
//    
//    public init(response: [String : Any]) {
//        super.init()
//        
//        self.companyId = response["companyId"] as? Int
//        self.goodId = response["goodId"] as? Int
//        self.goodName = response["name"] as? String
//        self.goodNameKana = response["name2"] as? String
//        self.status = response["status"] as? Int
//        }
//    
    override func mapping(map: Map) {
        self.companyId <- map["companyId"]
         self.goodId <- map["goodId"]
         self.goodName <- map["name"]
         self.goodNameKana <- map["name2"]
         self.status <- map["status"]
    }
}
