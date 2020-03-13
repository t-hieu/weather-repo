//
//  LWParams.swift
//  LW_Customer
//
//  Created by CuongNV on 9/27/18.
//  Copyright © 2018 Trente. All rights reserved.
//

import UIKit

class LWParams: NSObject {

    public class func initParams() -> [String : String] {
        
        var dict = [String: String]()
        dict["loginUserId"] = ATUserDefaults.getUserId()
        dict["companyId"] = ATUserDefaults.getCompanyId()
        dict["token"] = ATUserDefaults.getToken()
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
