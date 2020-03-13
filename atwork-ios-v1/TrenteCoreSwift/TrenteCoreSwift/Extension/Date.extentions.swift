//
//  Date.extenstions.swift
//  B1029
//
//  Created by Nguyen Duc Viet on 10/2/17.
//  Copyright © 2017 Portalbeanz. All rights reserved.
//

import Foundation
extension Date{
    func stringWith(format:String,locale:Locale?) -> String{
        let dateFormatter = DateFormatter.shared
        dateFormatter.dateFormat = format
        dateFormatter.locale = locale ?? Locale.current
        return dateFormatter.string(from: self)
    }
    
    var month:Int{
        get{
            
            let units: Set<Calendar.Component> = [ .month]
            let components = Calendar.init(identifier: .gregorian).dateComponents(units, from: self)
            return components.month!
        }
    }
    var year:Int{
        get{
            
            let units: Set<Calendar.Component> = [ .year]
            let components = Calendar.init(identifier: .gregorian).dateComponents(units, from: self)
            return components.year!
        }
    }
    var firstDayOfMonth:Date{
        get{
            
            let units: Set<Calendar.Component> = [ .month, .year]
            var components = Calendar.init(identifier: .gregorian).dateComponents(units, from: self)
            components.hour = 0
            components.minute = 0
            components.second = 0
            let startOfMonth =  Calendar.init(identifier: .gregorian).date(from: components)
            return startOfMonth!
            
        }
    }
    var lastDayOfMonth:Date{
        get{
            
            let units: Set<Calendar.Component> = [.month, .year]
            let components = Calendar.init(identifier: .gregorian).dateComponents(units, from: self)
            let startOfMonth =  Calendar.init(identifier: .gregorian).date(from:components)
            var comps2:DateComponents = DateComponents()
            comps2.month = 1
            comps2.day = -1
            comps2.hour = 23
            comps2.minute = 59
            comps2.second = 59
            let endOfMonth =  Calendar.init(identifier: .gregorian).date(byAdding: comps2, to: startOfMonth!)
            return endOfMonth!
            
        }
    }
    var prevMonth:Date{
        var comps2:DateComponents = DateComponents()
        comps2.month = -1
        let prevMonth =  Calendar.init(identifier: .gregorian).date(byAdding: comps2, to: self)
        return prevMonth!
    }
    var nextMonth:Date{
        var comps2:DateComponents = DateComponents()
        comps2.month = 1
        let nextMonth =  Calendar.init(identifier: .gregorian).date(byAdding: comps2, to: self)
        return nextMonth!
    }
     func monthFromNow(index:Int)->Date {
        var comps2:DateComponents = DateComponents()
        comps2.month = index
        let month =  Calendar.init(identifier: .gregorian).date(byAdding: comps2, to: self)
        return month!
    }
}
