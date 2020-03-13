//
//  TRUserDefault.swift
//  TrenteCoreSwift
//
//  Created by HtHoan on 1/23/18.
//  Copyright © 2018 Trente. All rights reserved.
//

import UIKit
open class TRUserDefaults: NSObject {
    
    public class func set(key: String, val: String) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(val, forKey: key)
        userDefaults.synchronize()
    }
    
    public class func get(key: String) -> String{
        let userDefaults = UserDefaults.standard
        let val = userDefaults.string(forKey: key)
        return TRStringUtil.toString(data: val)
    }
    
    public class func getBoolean(key:String) -> Bool {
        return NSString(string: get(key: key)).boolValue
    }
    
    public class func setBoolean(key:String, val: Bool) {
        set(key: key, val: String(val))
    }
    
    public class func setUserAccount(val: String) {
        self.set(key: "WF_USER_ACCOUNT", val: val)
    }
    
    public class func getUserAccount() -> String{
        return self.get(key:"WF_USER_ACCOUNT")
    }
    
    public class func setUserId(val: String) {
        self.set(key: "WF_USER_ID", val: val)
    }
    
    public class func getUserId() -> String{
        return self.get(key:"WF_USER_ID")
    }
    
    
    public class func setCompanyId(val: String) {
        self.set(key: "WF_COMPANY_ID", val: val)
    }
    
    public class func getCompanyId() -> String{
        return self.get(key:"WF_COMPANY_ID")
    }
    
    public class func setToken(val: String) {
        self.set(key: "WF_USER_TOKEN", val: val)
    }
    
    public class func getToken() -> String{
        return self.get(key:"WF_USER_TOKEN")
    }
    
    public class func setDeviceToken(val: String) {
        self.set(key: "WF_DEVICE_TOKEN", val: val)
    }
    
    public class func getDeviceToken() -> String{
        return self.get(key:"WF_DEVICE_TOKEN")
    }



    open class func clear() {
        self.setUserId(val: "")
        self.setCompanyId(val: "")
        self.setToken(val: "")
    }
}
