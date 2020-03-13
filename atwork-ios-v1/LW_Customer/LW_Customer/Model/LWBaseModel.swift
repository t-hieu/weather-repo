//
//  LWBaseModel.swift
//  LiftWork
//
//  Created by VietND on 6/19/18.
//  Copyright © 2018 Trente. All rights reserved.
//

import UIKit
import ObjectMapper

class LWBaseModel: NSObject,Mappable {
    
    public override init() {
        super.init()
    }
    public required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
    }

}
