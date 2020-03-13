//
//  ATAccountModel.swift
//  AtworkCore
//
//  Created by CuongNV on 11/6/18.
//  Copyright © 2018 Atwork. All rights reserved.
//

import UIKit

class ATAccountModel: NSObject {
    var account: String!
    var userName: String!
    var userKana: String!
    var userEmail: String!
    var userPhone: String!
    var password: String!
    var customerId: Int!
    var companyName: String!
    var companyCode: String!
    
    override init() {
        super.init()
    }
}
