//
//  TRMonthPickerView.swift
//  TrenteCoreSwift
//
//  Created by TrungND on 8/24/17.
//  Copyright © 2017 Trente. All rights reserved.
//

import UIKit

public class TRMonthPickerView: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let bigRowCount = 1000
    let MONTH = 1
    let YEAR = 0
    let LABEL_TAG = 43
    let monthPickerNumberOfComponents = 2

    var monthFont: UIFont?
    var monthSelectedFont: UIFont?
    var yearFont: UIFont?
    var yearSelectedFont: UIFont?
    
    var minYear: Int?
    var maxYear: Int?
    public var years: NSArray?
    public var months: NSArray?
    
    var rowHeight: CGFloat?
    var todayIndexPath: IndexPath?
    var monthTextColor: UIColor?
    var monthSelectedTextColor: UIColor?
    var yearTextColor: UIColor?
    var yearSelectedTextColor: UIColor?
    
    public init(){
        super.init(frame: CGRect.init())
        self.loadDefaultsParameters()
    }
    
    public override init(frame: CGRect){
        super.init(frame: frame)
        self.loadDefaultsParameters()
    }
    public required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        self.loadDefaultsParameters()
    }

    func loadDefaultsParameters() {
        self.minYear = 1900
        self.maxYear = 2100
        self.rowHeight = 44
//        numberOfComponents = 2
        
        self.months = self.nameOfMonths()
        self.years = self.nameOfYears()
        self.todayIndexPath = self.todayPath()
        
        self.delegate = self;
        self.dataSource = self;
        
        self.monthSelectedTextColor = UIColor.blue
        self.monthTextColor = UIColor.black
        self.yearSelectedTextColor = UIColor.blue
        self.yearTextColor = UIColor.black
        
        self.monthSelectedFont = UIFont.boldSystemFont(ofSize: 17)
        self.monthFont = UIFont.boldSystemFont(ofSize: 17)
        
        self.yearSelectedFont = UIFont.boldSystemFont(ofSize: 17)
        self.yearFont = UIFont.boldSystemFont(ofSize: 17)
    }
    
//    Pragma Mark - UIPickerViewDelegate
    public func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return self.componentWidth()
    }
    
    public func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var selected = false
        if(component == MONTH) {
            let monthCount = self.months?.count
            let monthName = self.months?.object(at: (row % monthCount!))
            let currentMonthName = self.currentMonthName()
            if(currentMonthName == (monthName as! String)){
                selected = true
            }
        } else {
            let yearCount = self.years?.count
            let yearName = self.years?.object(at: (row % yearCount!))
            let currentYearName = self.currentYearName()
            if(currentYearName == (yearName as! String)){
                selected = true
            }
        }
        
        var returnView: UILabel? = nil
        if(view?.tag == LABEL_TAG) {
            returnView = view as? UILabel
        } else {
            returnView = self.labelForComponent(component: component)
        }
        
        returnView?.font = selected ? self.selectedFontForComponent(component: component) : self.fontForComponent(component: component)
        returnView?.textColor = selected ? self.selectedColorForComponent(component: component) : self.colorForComponent(component: component)
        
        returnView?.text = self.titleForRow(row: row, component: component)
        return returnView!
    }
    
    public func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return self.rowHeight!
    }
    
//    Pragma Mark - UIPickerViewDataSource
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return monthPickerNumberOfComponents
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(component == MONTH){
            return self.bigRowMonthCount()
        }
        return self.bigRowYearCount()
    }
    
//    Mark: Class function
    func nameOfMonths() -> NSArray{
        return ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"]
    }
    
    func nameOfYears() -> NSArray {
        let years = NSMutableArray.init(array: [])
        
        for year in minYear! ... maxYear! {
            let yearStr = TRStringUtil.toString(data: year)
            years.add(yearStr)
        }
    return years;
    }
    
    // row - month ; section - year
    func todayPath() -> IndexPath {
        var row = 0
        var section = 0
    
        let month = self.currentMonthName()
        let year  = self.currentYearName()
    
        //set table on the middle
        for cellMonth in self.months! {
            if(month == (cellMonth as! String)){
                row = (self.months?.index(of: cellMonth))!
                row = row + self.bigRowMonthCount() / 2
                break
            }
        }
        
        for cellYear in self.years! {
            if(year == (cellYear as! String)){
                section = (self.years?.index(of: cellYear))!
                section = section + self.bigRowYearCount() / 2;
                break
            }
        }
    
        return IndexPath.init(row: row, section: section)
    }
    
    func currentMonthName() -> String {
        return TRFormatUtil.formatDateCustom(date: Date.init(), format: "MM")
    }
    
    func currentYearName() -> String {
        return TRFormatUtil.formatDateCustom(date: Date.init(), format: "yyyy")
    }
    
    func bigRowMonthCount() -> Int {
        return self.months!.count  * bigRowCount;
    }
    
    func bigRowYearCount() -> Int {
        return self.years!.count  * bigRowCount
    }
    
    func componentWidth() -> CGFloat {
        return self.bounds.size.width / CGFloat(monthPickerNumberOfComponents)
    }
    
    func labelForComponent(component: Int) -> UILabel {
        let frame = CGRect.init(x: 0, y: 0, width: self.componentWidth(), height: self.rowHeight!)
        let label = UILabel.init(frame: frame)
        label.textAlignment = NSTextAlignment.center
        label.backgroundColor = UIColor.clear
        label.isUserInteractionEnabled = false
        label.tag = LABEL_TAG
    
        return label;
    }
    
    func selectedFontForComponent(component: Int) -> UIFont {
        if (component == 0) {
            return self.monthSelectedFont!
        }
        return self.yearSelectedFont!
    }
    
    func fontForComponent(component: Int) -> UIFont {
        if (component == 0){
            return self.monthFont!
        }
        return self.yearFont!
    }
    
    func selectedColorForComponent(component: Int) -> UIColor {
        if (component == 0) {
            return self.monthSelectedTextColor!
        }
        return self.yearSelectedTextColor!
    }
    
    func colorForComponent(component: Int) -> UIColor {
        if (component == 0) {
            return self.monthTextColor!
        }
        return self.yearTextColor!
    }
    
    func titleForRow(row: Int, component: Int) -> String {
        if(component == MONTH){
            let monthCount = self.months?.count
            return self.months?.object(at: (row % monthCount!)) as! String
        }
        let yearCount = self.years?.count
        return self.years?.object(at: (row % yearCount!)) as! String
    }
    
    public func selectToday() {
        self.selectRow((self.todayIndexPath?.row)!, inComponent: MONTH, animated: false)
        self.selectRow((self.todayIndexPath?.section)!, inComponent: YEAR, animated: false)
    }
    
    public func selectExistDay(exisDayString: String) {
        let dateStringArr = exisDayString.components(separatedBy: ".")
        var row = 0
        var section = 0
        
        let month = dateStringArr[1]
        let year  = dateStringArr[0]
        
        //set table on the middle
        for cellMonth in self.months! {
            if(month == (cellMonth as! String)){
                row = (self.months?.index(of: cellMonth))!
                row = row + self.bigRowMonthCount() / 2;
                break;
            }
        }
        
        for cellYear in self.years! {
            if(year == (cellYear as! String)){
                section = (self.years?.index(of: cellYear))!
                section = section + self.bigRowYearCount() / 2;
                break;
            }
        }
        
        self.selectRow(row, inComponent: MONTH, animated: false)
        self.selectRow(section, inComponent: YEAR, animated: false)
    }
}
