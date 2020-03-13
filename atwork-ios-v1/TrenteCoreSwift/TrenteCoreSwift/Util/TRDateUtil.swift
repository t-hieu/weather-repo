//
//  TRDateUtil.swift
//  TrenteCoreSwift
//
//  Created by TrungND on 8/23/17.
//  Copyright © 2017 Trente. All rights reserved.
//

import UIKit

public class TRDateUtil: NSObject {
    
    // MARK: - get date for month
    public class func getDate4Month(month: Int) -> Date{
        
        let calendar = Calendar.init(identifier: .gregorian)
        let date = Date()
        
        var dateComponents: DateComponents? = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        
        dateComponents?.month = month
        dateComponents?.day = 1
        return calendar.date(from: dateComponents!)!
    }
    
    public class func setYear(date: Date?, year: Int) -> Date{
        var tmpDate = date
        let calendar = Calendar.init(identifier: .gregorian)
        if(tmpDate == nil){
            tmpDate = Date()
        }
        
        var dateComponents: DateComponents? = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: tmpDate!)
        
        dateComponents?.year = year
        return calendar.date(from: dateComponents!)!
    }
    
    public class func setMonth(date: Date?, month: Int) -> Date{
        var tmpDate = date
        let calendar = Calendar.init(identifier: .gregorian)
        if(tmpDate == nil){
            tmpDate = Date()
        }
        
        var dateComponents: DateComponents? = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: tmpDate!)
        
        dateComponents?.month = month
        return calendar.date(from: dateComponents!)!
    }
    
    // MARK: - get date for custom format
    public class func makeDateCustom(date: String, format: String) -> Date?{
        if( date.isEmpty || format.isEmpty){
            return nil
        }
        
        let dateFormatter = DateFormatter.shared
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: date)
    }
}
