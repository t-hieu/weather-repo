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
    
    public class func getConstructionId() -> String{
        return self.get(key:"LW_CONSTRUCTION_ID")
    }
    
    public class func setConstructionName(val: String) {
        self.set(key: "LW_CONSTRUCTION_NAME", val: val)
    }
    
    public class func getConstructionName() -> String{
        return self.get(key:"LW_CONSTRUCTION_NAME")
    }
    
    public override class func clear() {
        super.clear()
        self.setConstructionId(val: "")
        self.setConstructionName(val: "")
    }
}
