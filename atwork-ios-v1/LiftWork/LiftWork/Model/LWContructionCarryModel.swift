//
//  LWContructionCarry.swift
//  LiftWork
//
//  Created by Trần Tiến Anh on 10/24/18.
//  Copyright © 2018 Trente. All rights reserved.
//

import UIKit
import ObjectMapper
class LWContructionCarryModel: LWBaseModel {
    var status : Bool?
    var carryTypeName : String?
    var categoryId : Int?
    override func mapping(map: Map) {
        self.carryTypeName <- map["carryTypeName"]
        self.status <- map["status"]
        self.categoryId <- map["categoryId"]
      
    }
    
}
