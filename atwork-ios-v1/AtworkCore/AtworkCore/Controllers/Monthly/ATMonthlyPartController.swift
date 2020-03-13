//
//  ATMonthlyPartController.swift
//  AtworkCore
//
//  Created by CuongNV on 10/18/18.
//  Copyright © 2018 Atwork. All rights reserved.
//

import UIKit
import ObjectMapper
import TrenteCoreSwift
protocol ATMonthlyPartControllerDelegate {
    func tapDayView(dayModel: ATDailyModel)
    func doneLoadData(construction: ATConstructionModel)
}

class ATMonthlyPartController: UIViewController, DayViewDelegate, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var monthDayView: UIView!
    
    @IBOutlet weak var tableView: UITableView!
//    var dayViewChose: DayView!
//    var dailyModelChose: ATDailyModel!
    var indexDayviewChose: Int! = -1
    var dayChose: Date!
    var delegate: ATMonthlyPartControllerDelegate!
    var currentMonthIndex: Int = 0
    var currentYear: Int = 0
    var numOfDaysInMonth = [31,28,31,30,31,30,31,31,30,31,30,31]
    var dateBegin: String! = ""
    var dateEnd: String! = ""
    
    var cellWidth: CGFloat! = 50
    var cellHeight: CGFloat! = 50
    
    var construction : ATConstructionModel!
    var dailies = [ATDailyModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.tableFooterView = UIView()
        self.tableView.register(UINib.init(nibName: "MonthlyViewCell", bundle: Bundle.init(for: MonthlyViewCell.self)), forCellReuseIdentifier: "MonthlyViewCell")

    }
    override func viewWillAppear(_ animated: Bool) {
//        if(animated){
//            loadDailies()
//        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadDailies()
//        self.tableView.reloadData()
    }
    
    override public func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        self.tableView.frame = CGRect.init(x: 0, y: 0, width: self.dailyPartView.frame.width, height: self.dailyPartView.frame.height);
        self.view.layoutIfNeeded()
//        self.tableView.reloadData()
    }
    
    func weeksInMonth(month: Int, year: Int) {
        didChangeMonth(monthIndex: month, year: year)
        
    }
    
    func didChangeMonth(monthIndex: Int, year: Int) {
        currentMonthIndex = monthIndex
        currentYear = year
        
        //for leap year, make february month of 29 days
        if currentYear % 4 == 0 {
            numOfDaysInMonth[1] = 29
        } else {
            numOfDaysInMonth[1] = 28
        }
        //end
        
        let firstWeekDayOfMonth = getFirstWeekDay()
        
        // find begin day of week in  month
        var previousMonth = monthIndex
        var previousYear = currentYear
        var previousDay = 1
        if(firstWeekDayOfMonth > 1) {
            previousMonth -= 1
            if previousMonth <= 0 {
                previousMonth = 12
                previousYear -= 1
            }
            previousDay = numOfDaysInMonth[previousMonth-1] - firstWeekDayOfMonth + 2
        }
        self.dateBegin = getDateFrom(year: previousYear, month: previousMonth, day: previousDay)
        
        
        let endDayOfWeekMonth = getEndWeekDay()
        
        // find begin day of week in  month
        var nextMonth = monthIndex
        var nextYear = currentYear
        var nextDay = self.numOfDaysInMonth[currentMonthIndex - 1]
        if(endDayOfWeekMonth < 7) {
            nextMonth += 1
            if nextMonth > 12 {
                nextMonth = 1
                nextYear += 1
            }
            nextDay = 7 - endDayOfWeekMonth
        }
        self.dateEnd = getDateFrom(year: nextYear, month: nextMonth, day: nextDay)

    }
    
    func loadDailies(){
        var params = LWParams.initParamsLW()
        //        params["tableId"] = self.tableId?.description
        params["siteId"] = ATUserDefaults.getConstructionId()
        params["startTime"] = self.dateBegin + " 00:00"
        params["endTime"] = self.dateEnd + " 23:59"
        params["customerId"] = ATUserDefaults.getCustomerId()
        params["currentDate"] = TRFormatUtil.formatDateCustom(date: Date(), format: "MM/dd/yyyy HH:mm")
        self.view.activityIndicatorView.startAnimating()
        AlamofireManager.shared.request(APIRouter.get(url: API.LW_URL_LIFTING_LIST_SCHEDULE, params: params, identifier: nil)) { (response) in
            
            if response != nil{
                self.view.activityIndicatorView.stopAnimating()
                guard let construction : ATConstructionModel = Mapper<ATConstructionModel>().map(JSONObject: response!["constructionSite"] ),
                    let dailies: [ATDailyModel] = Mapper<ATDailyModel>().mapArray(JSONObject: response!["dailies"] ),
                    let currentDateString :String = response!["currentDate"] as? String
                    else{
                        return
                }
                self.construction = construction
                self.dailies = dailies
                self.indexDayviewChose = -1
                var dayString = ""
                if self.dayChose != nil {
                    dayString = TRFormatUtil.formatDateCustom(date: self.dayChose, format: "yyyy/MM/dd") + " 00:00"
                }else {
                    dayString = currentDateString
                }
                for index in 0..<self.dailies.count {
                    if dayString.elementsEqual(TRFormatUtil.formatDateCustom(date: self.dailies[index].date, format: "yyyy/MM/dd") + " 00:00"){
//                            self.dailyModelChose = self.dailies[index]
                        self.indexDayviewChose = index
                        self.delegate.tapDayView(dayModel: self.dailies[index])
                        break
                    }
                }
                
//                let currentDate = Calendar.current.date(byAdding: .hour, value: -HOUR_ADD - 24, to: Date())
                let currentDate = TRDateUtil.makeDateCustom(date: currentDateString, format: "yyyy/MM/dd HH:mm")
//                print(currentDate)
                for daily in self.dailies {
                    if daily.status == 2 || (daily.status == 1 && ((daily.date?.compare(currentDate!))! == ComparisonResult.orderedDescending || (daily.date?.compare(currentDate!))! == ComparisonResult.orderedSame)){
                        daily.isShowStatus = true
                    }else {
                        daily.isShowStatus = false
                    }
                }
//                self.showMonthlyDetail()
                self.tableView.reloadData()
                self.delegate.doneLoadData(construction: self.construction)
            }
            
        }
    }
    
    
//    func showMonthlyDetail(){
//
//
//        for index in 0..<dailies.count {
//            let x = CGFloat(index % 7) * self.cellWidth
//            let y = CGFloat(index / 7) * self.cellHeight
//            let dayView: DayView = self.createDayView(frame: CGRect.init(x: x, y: y, width: self.cellWidth, height: self.cellHeight), dailyModel: dailies[index]) as! DayView
//            dayView.delegate = self
//            self.monthDayView.addSubview(dayView)
//        }
//    }
    
//    func createDayView(frame: CGRect, dailyModel: ATDailyModel) -> UIView{
//
//        let dayView: DayView = DayView.init(frame: frame);
//        dayView.fillData(dayModel: dailyModel)
//        return dayView
//    }
    
    
    func getDateFrom(year: Int, month: Int, day: Int) -> String{
        var monthString = String(month)
        if monthString.count <= 1 {
            monthString = "0" + monthString
        }
        var dayString = String(day)
        if dayString.count <= 1 {
            dayString = "0" + dayString
        }
        return String(year) + "/" + monthString + "/" + dayString
    }
    
    func getFirstWeekDay() -> Int {
        let day = ("\(currentYear)-\(currentMonthIndex)-01".date?.weekday)!
        //return day == 7 ? 1 : day
        return day
    }
    
    func getEndWeekDay() -> Int {
        let day = ("\(currentYear)-\(currentMonthIndex)-\(self.numOfDaysInMonth[currentMonthIndex - 1])".date?.weekday)!
        //return day == 7 ? 1 : day
        return day
    }
    
    //tableview
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dailies.count / 7
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.cellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "MonthlyViewCell") as? MonthlyViewCell
        if (cell == nil) {
            cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "MonthlyViewCell") as? MonthlyViewCell
        }
        
        cell?.fillData(dailies: self.dailies, week: indexPath.row, delegate: self, indexChose: self.indexDayviewChose, cellWidth: self.cellWidth)
        return cell!
    }
    
    //delegate
    func tapDayView(dayView: DayView) {
//        if(self.dayViewChose != nil){
//            self.dayViewChose.removeTapDay()
//        }
//        self.dayViewChose = dayView
        self.dayChose = dayView.dayModel.date
        self.indexDayviewChose = self.dailies.firstIndex(of: dayView.dayModel)
//        self.dayViewChose.TapDay()
        self.delegate.tapDayView(dayModel: dayView.dayModel)
        self.tableView.reloadData()
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
