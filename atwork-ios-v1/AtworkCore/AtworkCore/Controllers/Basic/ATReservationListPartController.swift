//
//  ATReservationListPartController.swift
//  AtworkCore
//
//  Created by Trần Tiến Anh on 11/5/18.
//  Copyright © 2018 Atwork. All rights reserved.
//

import UIKit
import ObjectMapper
import TrenteCoreSwift


class ATReservationListPartController: UIViewController ,UITableViewDelegate , UITableViewDataSource   {
    
    
    @IBOutlet weak var TableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        TableView.register(UINib.init(nibName: "ATReservationListTableViewCell", bundle: Bundle.init(for: LWCellOneLabel.self)), forCellReuseIdentifier: "ATReservationListTableViewCell")
        TableView.dataSource = self
        TableView.delegate = self
        TableView.tableFooterView = UIView()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        updateChangeMonthYear()
    }
    var currentMonth: Int = 0
    var currentYear: Int = 0
    var numOfDaysInMonth = [31,28,31,30,31,30,31,31,30,31,30,31]
    var schedules = [ATScheduleModel]()
   
    var reservationlist = [ATReservationListModel]()
    override func viewWillAppear(_ animated: Bool) {
        
    }
    func updateChangeMonthYear() {
        if currentYear % 4 == 0 {
            numOfDaysInMonth[1] = 29
        } else {
            numOfDaysInMonth[1] = 28
        }
        let dateBegin = makeDateString(year: self.currentYear, month: self.currentMonth, day: 1)
        let dateEnd = makeDateString(year: self.currentYear, month: self.currentMonth, day: numOfDaysInMonth[self.currentMonth - 1])
        self.loadDailies(dateBegin: dateBegin, dateEnd: dateEnd)
    }
    func makeDateString(year: Int, month: Int, day: Int) -> String{
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
    
    func loadDailies(dateBegin: String, dateEnd: String){
        self.view.activityIndicatorView.startAnimating()
        var params = LWParams.initParamsLW()
        params["startTime"] = dateBegin + " 00:00"
        params["endTime"] = dateEnd + " 23:59"
        params["customerId"] = ATUserDefaults.getCustomerId()
        
        AlamofireManager.shared.request(APIRouter.get(url: API.AT_URL_RESERVATIONLIST, params: params, identifier: nil)) { (response) in
            
            if response != nil{
                self.view.activityIndicatorView.stopAnimating()
                guard
                    let schedules: [ATScheduleModel] = Mapper<ATScheduleModel>().mapArray(JSONObject: response!["lstSchedule"] )
                else {
                        return
                }
                
                self.schedules = schedules
                self.reservationlist.removeAll()

                    for schedule in schedules {
                         var temp = ATReservationListModel()
                         temp.schedule = schedule
                        temp.monthDate = schedule.startDate
                        temp.contruction = schedule.constructionSite?.constructionName
//                            temp.contruction = schedules
                       let date =  TRDateUtil.makeDateCustom(date: schedule.startDate!, format:  "yyyy/MM/dd")
                        
                            temp.monthDate = TRFormatUtil.formatDateCustom(date: date, format: "M/d")
                            temp.requestStatus = self.requestStatus(key: schedule.status)
                        
                            self.reservationlist.append(temp)
                       // }
                    }
          
                self.TableView.reloadData()
        }
    }
}
func requestStatus(key:Int) -> String {
    switch key {
    case 1:
        return "調整中"
    case 2:
        return "Confirmed"
    case 3:
        return "Reject"
    case 4:
        return "決定済"
    default:
        return ""
    }
}
}
extension ATReservationListPartController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reservationlist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell1  = tableView.dequeueReusableCell(withIdentifier: "ATReservationListTableViewCell") as! ATReservationListTableViewCell
        cell1.lbRequestStatus.text = reservationlist[indexPath.row].requestStatus
        cell1.lbtime.text = reservationlist[indexPath.row].schedule!.getStarttimeShow() + "~" + reservationlist[indexPath.row].schedule!.getEndtimeShow()
        cell1.lbContruction.text = reservationlist[indexPath.row].contruction
        cell1.lbmonthDate.text = reservationlist[indexPath.row].monthDate
        return cell1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ATRequestEditController.init(nibName: ATRequestEditController.className, bundle: Bundle.init(for: ATRequestEditController.self))
        vc.tableId = self.reservationlist[indexPath.row].schedule?.tableId
        vc.siteId = self.reservationlist[indexPath.row].schedule?.constructionSite?.key
        vc.currentDate = TRDateUtil.makeDateCustom(date: (self.reservationlist[indexPath.row].schedule?.startDate)!, format: "yyyy/MM/dd")
        self.navigationController?.pushViewController(vc, animated: false)
    }
}
