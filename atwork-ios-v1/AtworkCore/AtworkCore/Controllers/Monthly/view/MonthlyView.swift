//
//  MonthlyView.swift
//  LW_Customer
//
//  Created by CuongNV on 9/17/18.
//  Copyright © 2018 Trente. All rights reserved.
//

import UIKit

class MonthlyView: UIView {
    @IBOutlet var contentView: UIView!
    
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
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "MonthlyView", bundle: bundle)
        self.contentView = nib.instantiate(withOwner: self, options: nil).first as? UIView
        self.contentView.frame = self.bounds
        self.contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(contentView)
    }
    
    func weeksInMonth(month: Int, year: Int) {
        didChangeMonth(monthIndex: month, year: year)
   }
    
    func didChangeMonth(monthIndex: Int, year: Int) {
        currentMonthIndex=monthIndex+1
        currentYear = year
        
        //for leap year, make february month of 29 days
        if currentYear % 4 == 0 {
            numOfDaysInMonth[1] = 29
        } else {
            numOfDaysInMonth[1] = 28
        }
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
    }
    
    func getFirstWeekDay() -> Int {
        let day = ("\(currentYear)-\(currentMonthIndex)-01".date?.firstDayOfTheMonth.weekday)!
        //return day == 7 ? 1 : day
        return day
    }
}
