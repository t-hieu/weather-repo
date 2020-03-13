//
//  TRNumberUtil.swift
//  TrenteCoreSwift
//
//  Created by TrungND on 8/27/17.
//  Copyright © 2017 Trente. All rights reserved.
//

import UIKit

public class TRNumberUtil: NSObject {

    public class func toInt(data: String?) -> Int{
        if(data == nil){
            return 0
        }else{
            return Int.init(data!)!
        }
    }
}
