//
//  MonthlyView.swift
//  LW_Customer
//
//  Created by CuongNV on 9/17/18.
//  Copyright © 2018 Trente. All rights reserved.
//

import UIKit

class MonthlyView: UIView {
    @IBOutlet weak var weekOne: WeekDayView!
    @IBOutlet weak var weekTwo: WeekDayView!
    @IBOutlet weak var weekThree: WeekDayView!
    @IBOutlet weak var weekFour: WeekDayView!
    @IBOutlet weak var weekFive: WeekDayView!
    @IBOutlet weak var weekSix: WeekDayView!
    
    var currentMonthIndex: Int = 0
    var currentYear: Int = 0
    var numOfDaysInMonth = [31,28,31,30,31,30,31,31,30,31,30,31]
    var firstWeekDayOfMonth = 0   //(Sunday-Saturday 1-7)
    var dates = [Int]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubview()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSubview()
    }
    
    func initSubview() {
        fromNib()
       
    }
    
    func initDataInMonth(){
//        let date: Date
//        date.mo
    }
    
    func weeksInMonth(month: Int, year: Int) {
        didChangeMonth(monthIndex: month, year: year)

//        let calendar = NSCalendar.current
//
//        let comps = NSDateComponents()
//        comps.month = month+1
//        comps.year = year
//        comps.day = 0
//
//        guard let last = calendar.date(from: comps as DateComponents)
//            else {
//            return nil
//        }
//        // Note: Could get other options as well
//        let tag = calendar.dateComponents([.weekOfMonth,.weekOfYear,
//                                       .weekday,.quarter],from: last)
//        print("week: \(String(describing: tag.weekOfMonth))")
//        print("week: \(String(describing:tag.weekday))")
//        print("week: \(String(describing:tag.day))")
//
//        return tag.weekOfMonth

    }
    
    
    func didChangeMonth(monthIndex: Int, year: Int) {
        currentMonthIndex=monthIndex+1
        currentYear = year
        
        //for leap year, make february month of 29 days
//        if monthIndex == 1 {
            if currentYear % 4 == 0 {
                numOfDaysInMonth[1] = 29
            } else {
                numOfDaysInMonth[1] = 28
            }
//        }
        //end
        
        firstWeekDayOfMonth=getFirstWeekDay() - 1
        dates.removeAll()
        
        // add day in previous month
        if(firstWeekDayOfMonth > 0) {
            var previousMonth = monthIndex - 1
            if previousMonth < 0 {
                previousMonth = 11
            }
            for index in 0..<firstWeekDayOfMonth {
                dates.append(numOfDaysInMonth[previousMonth] - firstWeekDayOfMonth + 1 + index)
            }
        }
        // add day in this month
        for index in 1...numOfDaysInMonth[monthIndex]{
            dates.append(index)
        }
        //add day next month
        let temp = 7 - (dates.count % 7)
        if(temp > 0){
            for index in 1...temp {
                dates.append(index)
            }
        }
        
        //number week
        let numberWeek = dates.count / 7
        
        self.weekOne.fillData(dates: dates, index: 0)
        
        self.weekOne.fillColor(state: "-1")
        
        self.weekTwo.fillData(dates: dates, index: 7)
        self.weekTwo.fillColor(state: "-1")
        
        self.weekThree.fillData(dates: dates, index: 14)
        self.weekThree.fillColor(state: "-1")
        
        self.weekFour.fillData(dates: dates, index: 21)
        self.weekFour.fillColor(state: "0")
        
        if numberWeek < 6 {
            self.weekSix.isHidden = true
        }else {
            self.weekSix.isHidden = false
             self.weekSix.fillData(dates: dates, index: 35)
            self.weekSix.fillColor(state: "1")
        }
        if numberWeek < 5 {
            self.weekFive.isHidden = true
        }else {
            self.weekFive.isHidden = false
             self.weekFive.fillData(dates: dates, index: 28)
            self.weekFive.fillColor(state: "1")
        }
    }
    
    
    func getFirstWeekDay() -> Int {
        let day = ("\(currentYear)-\(currentMonthIndex)-01".date?.firstDayOfTheMonth.weekday)!
        //return day == 7 ? 1 : day
        return day
    }

}

//get first day of the month
extension Date {
    var weekday: Int {
        return Calendar.current.component(.weekday, from: self)
    }
    var firstDayOfTheMonth: Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year,.month], from: self))!
    }
}

//get date from string
extension String {
    static var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    var date: Date? {
        return String.dateFormatter.date(from: self)
    }
}

