//
//  LWOperatorModel.swift
//  LiftWork
//
//  Created by CuongNV on 5/28/18.
//  Copyright © 2018 Trente. All rights reserved.
//

import UIKit
import ObjectMapper

public class ATOperatorModel: ATBaseModel {
    var userId: Int?
    var userName: String?
    var userKana: String?
    var account: String?
    var status: Int?
    

    
    override public func mapping(map: Map) {
        self.userId <- map["userId"]
        self.account <- map["account"]
        self.userName <- map["userName"]
        self.userKana <- map["userKana"]
        self.status <- map["status"]
    }
    
    public func copyWith(op: ATOperatorModel) {
        self.userId = op.userId
        self.account = op.account
        self.userName = op.userName
        self.userKana = op.userKana
        self.status = op.status
    }
}
