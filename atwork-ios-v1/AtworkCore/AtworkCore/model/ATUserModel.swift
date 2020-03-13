//
//  LWUserModel.swift
//  LiftWork
//
//  Created by CuongNV on 5/14/18.
//  Copyright © 2018 Trente. All rights reserved.
//

import UIKit
import ObjectMapper

class ATUserModel: ATBaseModel {
 
    var userId: Int?
    var userName: String?
    var userNameKana: String?
    var userAccount: String?
    var userEmail: String?
    var token: String?
    var avatarPath: String?
    var companyId: Int?
    var status: Int?
    var systemAdmin:Int?
    var companyAdmin:Int?
    var companyName: String?
    var customerId: Int!
    var userPhone:String?

    
    override public func mapping(map: Map) {
        self.companyId <- map["companyId"]
        self.userId <- map["key"]
        self.userName <- map["userName"]
        self.userNameKana <- map["userKana"]
        self.userAccount <- map["userCode"]
        self.userEmail <- map["userEmail"]
        self.avatarPath <- map["avatarPath"]
        self.token <- map["token"]
        self.status <- map["status"]
        self.systemAdmin <- map["systemAdmin"]
        self.companyAdmin <- map["companyAdmin"]
        self.companyName <- map["companyName"]
        self.customerId <- map["customerId"]
        self.userPhone <- map["userPhone"]
    }
}
