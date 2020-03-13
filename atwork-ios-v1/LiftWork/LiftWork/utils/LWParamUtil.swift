//
//  LWParamUtil.swift
//  LiftWork
//
//  Created by CuongNV on 5/14/18.
//  Copyright © 2018 Trente. All rights reserved.
//

import UIKit

class LWParamUtil: NSObject {

        public class func initParams() -> [String : String] {
            
            var dict = [String: String]()
            dict["loginUserId"] = LWUserDefaults.getUserId()
            dict["companyId"] = LWUserDefaults.getCompanyId()
            dict["token"] = LWUserDefaults.getToken()
            dict["deviceType"] = "I"
            
            dict["timezone"] = TimeZone.current.identifier
            dict["language"] = Locale.current.languageCode
//            dict["version"] = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
            dict["version"] = "1.5"
            return dict
        }
        
        public class func initParamsLW() -> [String : String] {
            
            var dict = self.initParams()
            dict["serviceCd"] = "LW"
            return dict
        }
}
