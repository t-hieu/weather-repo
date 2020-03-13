//
//  ATDatePickerController.swift
//  AtworkCore
//
//  Created by CuongNV on 11/15/18.
//  Copyright © 2018 Atwork. All rights reserved.
//

import UIKit
import FSCalendar

protocol ATDatePickerDelegate {
    func doneChoseDate(datePickerConstroller: ATDatePickerController, date: Date)
}
class ATDatePickerController: UIViewController, FSCalendarDataSource, FSCalendarDelegate {
    @IBOutlet weak var calendarView: FSCalendar!
    @IBOutlet weak var backgroundView: UIView!
    var delegate: ATDatePickerDelegate!
    var tagView: Int!
    var date: Date!
    @IBAction func tapTopBackground(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tapBottomBG(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
//        _calendar.appearance.headerDateFormat = [NSDateFormatter dateFormatFromTemplate:@"MMMM yy" options:0 locale:[NSLocale localeWithLocaleIdentifier:@"en-US"]];
        self.calendarView.appearance.headerDateFormat = DateFormatter.dateFormat(fromTemplate: "MMMM yyyy", options: 0, locale: NSLocale(localeIdentifier: "ja") as Locale)
        self.calendarView.locale = NSLocale(localeIdentifier: "ja") as Locale
        self.calendarView.appearance.caseOptions =  FSCalendarCaseOptions.weekdayUsesSingleUpperCase
        self.calendarView.delegate = self
        self.calendarView.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        self.calendarView.select(self.date)
    }

    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        self.delegate.doneChoseDate(datePickerConstroller: self, date: date)
        self.dismiss(animated: true, completion: nil)
    }
    
    func calendar(_ calendar: FSCalendar, didDeselect date: Date) {
    }
    

}
