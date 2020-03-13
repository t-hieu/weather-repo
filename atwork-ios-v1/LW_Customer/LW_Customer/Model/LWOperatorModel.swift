//
//  LWOperatorModel.swift
//  LiftWork
//
//  Created by CuongNV on 5/28/18.
//  Copyright © 2018 Trente. All rights reserved.
//

import UIKit
import ObjectMapper

class LWOperatorModel: LWBaseModel {
    var userId: Int?
    var userName: String?
    var userKana: String?
    var account: String?
    var status: Int?
    
//    override init() {
//        super.init()
//    }
//
//    public init(response: [String : Any]) {
//        super.init()
//
//        self.userId = response["userId"] as? Int
//        self.account = response["account"] as? String
//        self.userName = response["userName"] as? String
//        self.userKana = response["userKana"] as? String
//        self.status = response["status"] as? Int
//
//    }
    
    override func mapping(map: Map) {
        self.userId <- map["userId"]
        self.account <- map["account"]
        self.userName <- map["userName"]
        self.userKana <- map["userKana"]
        self.status <- map["status"]
    }
    
    func copyWith(op: LWOperatorModel) {
        self.userId = op.userId
        self.account = op.account
        self.userName = op.userName
        self.userKana = op.userKana
        self.status = op.status
    }
}
