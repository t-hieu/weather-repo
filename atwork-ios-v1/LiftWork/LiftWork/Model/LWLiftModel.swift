//
//  LWLiftModel.swift
//  LiftWork
//
//  Created by CuongNV on 5/28/18.
//  Copyright © 2018 Trente. All rights reserved.
//

import UIKit
import ObjectMapper

class LWLiftModel: LWBaseModel {
    var liftId: Int?
    var liftName: String?
    var companyId: Int?
    var status: Int?
    var no: String?
    
//    override init() {
//        super.init()
//    }
//    
//    public init(response: [String : Any]) {
//        super.init()
//        
//        self.companyId = response["companyId"] as? Int
//        self.liftId = response["liftId"] as? Int
//        self.liftName = response["name"] as? String
//        self.status = response["status"] as? Int
//        self.no = response["no"] as? String
//        
//    }
    
    func copyWith(lift: LWLiftModel){
        self.companyId = lift.companyId
        self.liftId = lift.liftId
        self.liftName = lift.liftName
        self.status = lift.status
        self.no = lift.no
    }
    
    override func mapping(map: Map) {
        self.companyId <- map["companyId"]
         self.liftId <- map["liftId"]
         self.self.liftName <- map["name"]
         self.status <- map["status"]
         self.no <- map["no"]
    }
}
