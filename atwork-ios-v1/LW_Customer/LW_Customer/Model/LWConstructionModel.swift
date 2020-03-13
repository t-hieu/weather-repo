//
//  LWConstructionModel.swift
//  LiftWork
//
//  Created by CuongNV on 5/21/18.
//  Copyright © 2018 Trente. All rights reserved.
//

import UIKit
import  ObjectMapper

class LWConstructionModel: LWBaseModel {
    var key: Int?
    var constructionName: String?
    var constructionKana: String?
    var constructionAddress: String?
    var stairStart: String?
    var stairEnd: String?
    
    var constructionBuilding: String?
    var operatorStart: NSDate?
    var operatorEnd: NSDate?
    var siteArea: String?
    var other: String?
    var status: Int?
    var operators:[LWOperatorModel]?
    var lifts:[LWLiftModel]?
    
    //
//    public init(response: [String : Any]) {
//        super.init()
//        self.key = response["constructionId"] as? Int
//        self.constructionName = response["constructionName"] as? String
//        self.constructionKana = response["constructionKana"] as? String
//        self.constructionAddress = response["constructionAddress"] as? String
//        self.stairStart = response["stairStart"] as? String
//        self.stairEnd = response["stairEnd"] as? String
//        self.constructionBuilding = response["constructionBuilding"] as? String
//        self.operatorStart = response["operatorStart"] as? NSDate
//        self.operatorEnd = response["useoperatorEndrMail"] as? NSDate
//        self.siteArea = response["siteArea"] as? String
//        self.other = response["other"] as? String
//        self.status = response["status"] as? Int
//        if(response["operators"] != nil){
//            for resOperator in response["operators"] as! NSArray{
//                let mOperator = LWOperatorModel.init(response: resOperator as! [String: Any])
//                self.operators.append(mOperator)
//            }
//        }
//        if(response["lifts"] != nil){
//            for resOperator in response["lifts"] as! NSArray{
//                let mLift = LWLiftModel.init(response: resOperator as! [String: Any])
//                self.lifts.append(mLift)
//            }
//        }
//    }
    override func mapping(map: Map) {
        self.key <- map["constructionId"]
         self.constructionName <- map["constructionName"]
         self.constructionKana <- map["constructionKana"]
         self.constructionAddress <- map["constructionAddress"]
         self.stairStart <- map["stairStart"]
         self.stairEnd <- map["stairEnd"]
         self.constructionBuilding <- map["constructionBuilding"]
         self.operatorStart <- map["operatorStart"]
         self.operatorEnd <- map["useoperatorEndrMail"]
        self.siteArea <- map["siteArea"]
        self.other <- map["other"]
        self.status <- map["status"]
        self.operators <- map["operators"]
        self.lifts <- map["lifts"]
    }
}
