//
//  TRParamsUtil.swift
//  TrenteCoreSwift
//
//  Created by HtHoan on 1/23/18.
//  Copyright © 2018 Trente. All rights reserved.
//

import UIKit

class TRParamsUtil: NSObject {
    
    public class func initParams() -> [String : String] {
        
        var dict = [String: String]()
        dict["loginUserId"] = TRUserDefaults.getUserId()
        dict["companyId"] = TRUserDefaults.getCompanyId()
        dict["token"] = TRUserDefaults.getToken()
        dict["deviceType"] = "I"
        
        dict["timezone"] = TimeZone.current.identifier
        dict["language"] = Locale.current.languageCode
        dict["version"] = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        
        return dict
    }
    
    public class func initParamsOL() -> [String : String] {
        
        var dict = self.initParams()
        dict["serviceCd"] = "LW"
        return dict
    }
}
