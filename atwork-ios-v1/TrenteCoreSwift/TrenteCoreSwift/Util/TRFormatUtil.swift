//
//  TRFormatUtil.swift
//  TrenteCoreSwift
//
//  Created by TrungND on 8/23/17.
//  Copyright © 2017 Trente. All rights reserved.
//

import UIKit

public class TRFormatUtil: NSObject {
    
    public class func formatDateCustom(date: Date?, format: String) -> String{
        if(date == nil){
            return ""
        }
        
        let formatter = DateFormatter.shared
        formatter.dateFormat = format
        
        return formatter.string(from: date!)
    }

    public class func formatAmount(value: String) -> String{
        let number = NSNumber.init(value: Double.init(value)!)
        let numberFormatter: NumberFormatter = NumberFormatter()
        numberFormatter.groupingSeparator = ","
        numberFormatter.groupingSize = 3
        numberFormatter.usesGroupingSeparator = true
        numberFormatter.decimalSeparator = "."
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
//        numberFormatter.minimumFractionDigits = 15
        let theString: String = numberFormatter.string(from: number)!
        return theString
    }
    
    public class func formatAmountWith2FractionDigits(value: String) -> String{
        let number = NSNumber.init(value: Double.init(value)!)
        let numberFormatter: NumberFormatter = NumberFormatter()
        numberFormatter.groupingSeparator = ","
        numberFormatter.groupingSize = 3
        numberFormatter.usesGroupingSeparator = true
        numberFormatter.decimalSeparator = "."
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        //        numberFormatter.minimumFractionDigits = 15
        let theString: String = numberFormatter.string(from: number)!
        return theString
    }
    
//    public class func formatZero(value: Int) -> String{
//        
//        return theString
//    }
}
