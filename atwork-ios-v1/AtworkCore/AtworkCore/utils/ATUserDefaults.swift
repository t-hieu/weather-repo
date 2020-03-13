//
//  ATUserDefaults.swift
//  AtworkCore
//
//  Created by CuongNV on 10/4/18.
//  Copyright © 2018 Atwork. All rights reserved.
//

import UIKit
import TrenteCoreSwift

public class ATUserDefaults: TRUserDefaults {
    
    public class func setConstructionId(val: String) {
        self.set(key: "LW_CONSTRUCTION_ID", val: val)
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
    
    public class func setDayForDaily(val: String) {
        self.set(key: "LW_DAY_FOR_DAILY", val: val)
    }
    
    public class func getDayForDaily() -> String{
        return self.get(key:"LW_DAY_FOR_DAILY")
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
    public class func setCompanyName(val: String) {
        self.set(key: "AT_ACCOUNT_CompanyName", val: val)
    }
    public class func getCompanyName() -> String{
        return self.get(key:"AT_ACCOUNT_CompanyName")
    }
    
    public class func setCustomerUserFlag(val: String) {
        self.set(key: "customerUserFlag", val: val)
    }
    public class func getCustomerUserFlag() -> String{
        return self.get(key:"customerUserFlag")
    }
    
    public override class func clear() {
        super.clear()
        self.setConstructionId(val: "")
        self.setConstructionName(val: "")
    }
}
