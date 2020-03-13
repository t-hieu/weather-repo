//
//  LWLiftMaterialModel.swift
//  LiftWork
//
//  Created by CuongNV on 5/24/18.
//  Copyright © 2018 Trente. All rights reserved.
//

import UIKit
import ObjectMapper
public class ATGoodModel: ATBaseModel {
    
    var goodId: Int?
    var goodName: String?
    var goodNameKana: String?
    var companyId: Int?
    var status: Int?
    
    override public func mapping(map: Map) {
        self.companyId <- map["companyId"]
         self.goodId <- map["goodId"]
         self.goodName <- map["name"]
         self.goodNameKana <- map["name2"]
         self.status <- map["status"]
    }
}
