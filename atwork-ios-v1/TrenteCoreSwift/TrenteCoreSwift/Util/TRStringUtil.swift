//
//  TRStringUtil.swift
//  TrenteCoreSwift
//
//  Created by TrungND on 5/29/17.
//  Copyright © 2017 Trente. All rights reserved.
//

import UIKit

public class TRStringUtil {
    
//    public class func isEmpty(data: String?) -> Bool{
//        if(data == nil){
//            return true
//        }else{
//            return (data?.count)! == 0
//        }
//    }

    public class func toString(data: Any?) -> String{
        if(data == nil){
            return ""
        }else{
            return "\(data!)"
        }
    }
    
    public class func append(array: [String]?) -> String{
        if(array == nil){
            return ""
        }else{
            var value = ""
            for data in array! {
                if !data.isEmpty{
                    value += data
                }
            }
            return value
        }
    }
}
