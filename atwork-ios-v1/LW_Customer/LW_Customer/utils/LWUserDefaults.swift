//
//  LWUserDefaults.swift
//  LiftWork
//
//  Created by CuongNV on 5/14/18.
//  Copyright © 2018 Trente. All rights reserved.
//

import UIKit
import TrenteCoreSwift

class LWUserDefaults: TRUserDefaults {
    
    public class func setConstructionId(val: String) {
        self.set(key: "LW_CONSTRUCTION_ID", val: val)
    }
    public class func setUserName(val: String) {
        self.set(key: "AT_ACCOUNT_UserName", val: val)
    }
    public class func getUserName() -> String{
        return self.get(key:"AT_ACCOUNT_UserName")
    }
    
    public class func setUserKana(val: String) {
        self.set(key: "AT_ACCOUNT_UserKana", val: val)
    }
    public class func getUserKana() -> String{
        return self.get(key:"AT_ACCOUNT_UserKana")
    }
    public class func setUserEmail(val: String) {
        self.set(key: "AT_ACCOUNT_UserEmail", val: val)
    }
    public class func getUserEmail() -> String{
        return self.get(key:"AT_ACCOUNT_UserEmail")
    }
    public class func setUserPhone(val: String) {
        self.set(key: "AT_ACCOUNT_UserPhone", val: val)
    }
    public class func getUserPhone() -> String{
        return self.get(key:"AT_ACCOUNT_UserPhone")
    }
    
    public class func getConstructionId() -> String{
        return self.get(key:"LW_CONSTRUCTION_ID")
    }
    
    public class func setConstructionName(val: String) {
        self.set(key: "LW_CONSTRUCTION_NAME", val: val)
    }
    
    public class func getConstructionName() -> String{
        return self.get(key:"LW_CONSTRUCTION_NAME")
    }
    public class func setCustomerId(val: String) {
        self.set(key: "LW_CUSTOMER_ID", val: val)
    }
    
    public class func getCustomerId() -> String{
        return self.get(key:"LW_CUSTOMER_ID")
    }
    
    public override class func clear() {
        super.clear()
        self.setConstructionId(val: "")
        self.setConstructionName(val: "")
    }
}
