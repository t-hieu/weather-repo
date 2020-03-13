//
//  BreakTimeSettingViewController.swift
//  AtworkCore
//
//  Created by Trần Tiến Anh on 11/14/18.
//  Copyright © 2018 Atwork. All rights reserved.
//

import UIKit
import TrenteCoreSwift
import ObjectMapper
class BreakTimeSettingViewController: UIViewController ,BreakTimeSettingCellDelegate,ATTimePickerViewDelegate {
    @IBAction func ValueChanged(_ sender: Any) {
      self.isBreakTimeEnable =  self.IsBeakTimeEnable.isOn  
    }
    @IBAction func updateChoice(_ sender: Any) {
        
        UpdateBreakTimeSetting()
        UpdateReservationSetting()
    }
    func tapContentFromTo(isFrom: Bool, tag: Int) {
        
            
            if(timePickerView == nil){
                timePickerView = ATTimePickerView.init()
                timePickerView?.delegate = self
                
            }
            var currentH = 0
            var currentM = 0
        let tagPickerView = tag * 2
            if isFrom {
                self.timePickerView.tag = tagPickerView
              if self.breakTimes[tag].breakStartTime != nil {
                let time = self.breakTimes[tag].breakStartTime.components(separatedBy: ":")
                currentH = Int(time[0])!
                currentM = Int(time[1])!
              }
            } else {
                self.timePickerView.tag = tagPickerView + 1
                if self.breakTimes[tag].breakEndTime != nil {
                let time = self.breakTimes[tag].breakEndTime.components(separatedBy: ":")
                currentH = Int(time[0])!
                currentM = Int(time[1])!
                }
            }
            timePickerView.setData(hourAdd: 6, timeInterval: 15,currentHour: currentH, currentMin: currentM)
            
            timePickerView?.show()
            
        

    }
    
    func donePickerView(pickerView: ATTimePickerView, hourSelected: String, minSelected: String) {
        let choiceTime = timeToInt(time: hourSelected + ":" + minSelected)
        let index = pickerView.tag / 2
        if pickerView.tag % 2  == 0 {
            if timeToInt(time: workingEndTime) < choiceTime {
                
                showMess(mess: NSLocalizedString("BreakTime_Outside_OperationTime", comment: ""))
                return
            }
            if breakTimes[index].breakEndTime != nil {
                if timeToInt(time: self.breakTimes[index].breakEndTime) <= choiceTime {
                    showMess(mess: "開始時刻は終了時刻より大きく出来ません")
                    return
                }
            }
            if breakTimes.count == 1 {
                // chosetime > end time
                if self.breakTimes[index].breakStartTime != nil && self.breakTimes[index].breakEndTime != nil{
                    if choiceTime >= timeToInt(time: self.breakTimes[index].breakEndTime) {
                        showMess(mess: "開始時刻は終了時刻より大きく出来ません")
                        return
                    }
                }
//                // chose time < work time
                if (timeToInt(time: workingStartTime) > choiceTime) {
                    showMess(mess: NSLocalizedString("BreakTime_Outside_OperationTime", comment: ""))
                    return
                }
                 self.breakTimes[index].breakStartTime = hourSelected + ":" + minSelected
                TableView.reloadData()
                return
            }
            // add new break start time
            if breakTimes[index].breakEndTime == nil || breakTimes[index].breakStartTime == nil {
                if (timeToInt(time: workingStartTime) > choiceTime) {
                    showMess(mess: NSLocalizedString("BreakTime_Outside_OperationTime", comment: ""))
                    return
                }
                for i in 0..<index
                {
                    if (TimeInTime(time: hourSelected + ":" + minSelected, intime: breakTimes[i])) != true {
                        return
                    }
                }
                if self.breakTimes[index].breakEndTime != nil {
                    if choiceTime >= timeToInt(time: self.breakTimes[index].breakEndTime) {
                        showMess(mess: "開始時刻は終了時刻より大きく出来ません")
                        return
                    }
                }
                self.breakTimes[index].breakStartTime = hourSelected + ":" + minSelected
                TableView.reloadData()
                return
            }
            // select start > end
              if choiceTime >= timeToInt(time: self.breakTimes[index].breakEndTime) {
                showMess(mess: "開始時刻は終了時刻より大きく出来ません")
                return
            }
           
            if (timeToInt(time: workingStartTime) > choiceTime) {
               
                showMess(mess:  NSLocalizedString("BreakTime_Outside_OperationTime", comment: ""))
                return
            }
            
            //change time in list break time
            for i in 0..<index {
                if (TimeInTime(time: hourSelected + ":" + minSelected, intime: breakTimes[i])) != true {
                    return
                }
            }
            for i in index+1..<breakTimes.count {
                if (TimeInTime(time: hourSelected + ":" + minSelected, intime: breakTimes[i])) != true {
                    return
                }
            }
             self.breakTimes[index].breakStartTime = hourSelected + ":" + minSelected
            }
        
        else if pickerView.tag % 2 == 1 {
            if breakTimes[index].breakStartTime != nil {
                if timeToInt(time: self.breakTimes[index].breakStartTime) >= choiceTime {
                    showMess(mess: "開始時刻は終了時刻より大きく出来ません")
                    return
                }
            }
            if breakTimes.count == 1 {
                //chose time > working end time
                if timeToInt(time: workingEndTime) < choiceTime {
                    
                    showMess(mess: NSLocalizedString("BreakTime_Outside_OperationTime", comment: ""))
                    return
                }
            if breakTimes[index].breakEndTime == nil || breakTimes[index].breakStartTime == nil {
                if !(timeToInt(time: workingStartTime) < choiceTime) {
                    
                    showMess(mess: NSLocalizedString("BreakTime_Outside_OperationTime", comment: ""))
                    return
                }
                self.breakTimes[index].breakEndTime = hourSelected + ":" + minSelected
                TableView.reloadData()
                return
                }
            }
            // add new
            if breakTimes[index].breakEndTime == nil || breakTimes[index].breakStartTime == nil {
                if timeToInt(time: workingEndTime) < choiceTime {
                    
                    showMess(mess: NSLocalizedString("BreakTime_Outside_OperationTime", comment: ""))
                    return
                }
                for i in 0..<index {
                    if (TimeInTime(time: hourSelected + ":" + minSelected, intime: breakTimes[i])) != true {
                        return
                    }
                         if choiceTime == timeToInt(time: breakTimes[i].breakEndTime) {
                            showMess(mess: NSLocalizedString("Duplicate_Time", comment: ""))
                            return
                        }
                    if i == index-1 {
                        self.breakTimes[index].breakEndTime = hourSelected + ":" + minSelected
                        TableView.reloadData()
                        return
                    }
                }
                if timeToInt(time: breakTimes[index].breakStartTime) >= choiceTime {
                    showMess(mess: "開始時刻は終了時刻より大きく出来ません")
                    return
                }
                for i in 0..<breakTimes.count-1 {
                    if (TimeInTime(time: breakTimes[i].breakStartTime, intime: breakTimes[index])&&(TimeInTime(time: breakTimes[i].breakEndTime, intime: breakTimes[index]))) != true {
                        self.breakTimes[index].breakEndTime = nil
                        TableView.reloadData()
                        return
                    }
                }
            }
            if choiceTime <= timeToInt(time: self.breakTimes[index].breakStartTime) {
                showMess(mess: "開始時刻は終了時刻より大きく出来ません")
                return
            }
            if timeToInt(time: workingEndTime) < choiceTime {
                
                showMess(mess: NSLocalizedString("BreakTime_Outside_OperationTime", comment: ""))
                return
            }
            
            //
//            for i in 0..<index {
//                if (TimeInTime(time: breakTimes[i].breakStartTime, intime: breakTimes[index])&&(TimeInTime(time: breakTimes[i].breakEndTime, intime: breakTimes[index]))) != true {
//                    return
//                }
//            }
            
            
            //
            for i in 0..<index {
                if (TimeInTime(time: breakTimes[i].breakStartTime, intime: breakTimes[index])&&(TimeInTime(time: breakTimes[i].breakEndTime, intime: breakTimes[index]))) != true {
                    return
                }
            }
            for i in index+1..<breakTimes.count {
                if (TimeInTime(time: breakTimes[i].breakStartTime, intime: breakTimes[index])&&(TimeInTime(time: breakTimes[i].breakEndTime, intime: breakTimes[index]))) != true {
                    return
                }
            }
           self.breakTimes[index].breakEndTime = hourSelected + ":" + minSelected
        }
        self.TableView.reloadData()
    }
    func TimeInTime(time:String,intime:SiteBreakTime) -> Bool {
        
        if (timeToInt(time: intime.breakStartTime)<=timeToInt(time: time))&&(timeToInt(time: time)<timeToInt(time: intime.breakEndTime)) {
            showMess(mess: NSLocalizedString("Duplicate_Time", comment: ""))
            return false
        }
//        if (timeToInt(time: time)==timeToInt(time: intime.breakEndTime)) {
//            return false
    //    }
        return true
    }
    func showMess(mess:String) {
        let alertController = UIAlertController(title: "", message: mess, preferredStyle: .alert)
        let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .destructive, handler:nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    func timeToInt(time:String)->Int{
       let result = time.components(separatedBy: ":")
        return Int( result[0])!*60 + Int( result[1])!
    }
    var workingStartTime = "8:00"
    var  workingEndTime = "17:30"
    var timePickerView: ATTimePickerView!
    var breakTimes = [SiteBreakTime]()
    var pikerview: TRPickerView!
    @IBOutlet weak var TableView: UITableView!
    @IBOutlet weak var IsBeakTimeEnable: UISwitch!
    @IBOutlet weak var HeaderTitle: UIView!
    @IBOutlet weak var HeaderVIew: UIView!
    @IBOutlet weak var ViewForLB: UIView!
    var bookingPeriod: Int?
    var isDeadlineEnable: Bool?
    var deadlinePeriod: Int?
    var isNoneWorkingEnable: Bool?
    var breakStartTimeStr = String()
    var breakEndTimeStr = String()
    var isBreakTimeEnable:Bool!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadReservationSetting()
        self.navigationController?.navigationBar.barTintColor = UIColor.orange
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.isTranslucent = false 
        self.navigationItem.title = "休憩時間設定"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        let leftBarButton = UIBarButtonItem(title: "＜戻る", style: .plain, target: self, action: #selector(self.tapLeftBarButton))
        leftBarButton.titleTextAttributes(for: .normal)
        leftBarButton.setTitleTextAttributes([NSAttributedStringKey.font: UIFont.boldFont(size: AT_FONT_SIZE_NORMAL)], for: .normal)
        leftBarButton.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItem = leftBarButton
        
        loadBreakTimeSetting()
        self.HeaderVIew.backgroundColor =  AT_COLOR_TITLE_INPUT_PERFORMACE
        self.HeaderVIew.layer.borderWidth = 0.5
        self.HeaderVIew.layer.borderColor = AT_COLOR_BORDER.cgColor
      
        self.HeaderTitle.backgroundColor =  AT_COLOR_TITLE_INPUT_PERFORMACE
        self.HeaderTitle.layer.borderWidth = 0.5
        self.HeaderTitle.layer.borderColor = AT_COLOR_BORDER.cgColor
       
        self.ViewForLB.layer.borderWidth = 0.5
        self.ViewForLB.layer.borderColor = AT_COLOR_BORDER.cgColor
        
        TableView.register(UINib.init(nibName: "BreakTimeSettingCell", bundle: Bundle.init(for: OperationTimeSettingViewCell.self)), forCellReuseIdentifier: "BreakTimeSettingCell")
        TableView.register(UINib.init(nibName: "BreakTimeSettingFooterCell", bundle: Bundle.init(for: BreakTimeSettingFooterCell.self)), forCellReuseIdentifier: "BreakTimeSettingFooterCell")
        
        
        TableView.dataSource = self
        TableView.delegate = self
        TableView.tableFooterView = UIView()
        TableView.separatorStyle = .none
    }

    @objc func tapLeftBarButton(){
        self.navigationController?.popViewController(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
}
extension BreakTimeSettingViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return breakTimes.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell1 = TableView.dequeueReusableCell(withIdentifier: "BreakTimeSettingCell") as? BreakTimeSettingCell
        if (cell1 == nil) {
            cell1 = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "BreakTimeSettingCell") as? BreakTimeSettingCell
        }
        if indexPath.row == breakTimes.count   {
            var cell1 = TableView.dequeueReusableCell(withIdentifier: "BreakTimeSettingFooterCell") as? BreakTimeSettingFooterCell
            if (cell1 == nil) {
                cell1 = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "BreakTimeSettingFooterCell") as? BreakTimeSettingFooterCell
            }
            cell1?.btnadd.addTarget(self, action: #selector(addcell), for: .touchUpInside)
            return cell1!
        }
        cell1?.tagView = indexPath.row
        cell1?.delegate = self
        cell1?.setContentText(isFrom: true, contentText: self.breakTimes[indexPath.row].breakStartTime)
        cell1?.setContentText(isFrom: false, contentText: self.breakTimes[indexPath.row].breakEndTime)
        cell1?.btTapFrom.tag = indexPath.row
        cell1?.btTapTo.tag = indexPath.row
        cell1?.btnDelete.tag = indexPath.row
        cell1?.btnDelete.addTarget(self, action:  #selector(removeCell), for: .touchUpInside)
        
        return cell1!
    }
    @objc func addcell(sender: AnyObject) {
       
        if (breakTimes.count == 0) {
            let newBreakTime = SiteBreakTime()
            breakTimes.append(newBreakTime)
            TableView.reloadData()
        }
        if (breakTimes[breakTimes.count-1].breakEndTime==nil && breakTimes[breakTimes.count-1].breakStartTime==nil){
            return
        }
        let newBreakTime = SiteBreakTime()
        breakTimes.append(newBreakTime)
        TableView.reloadData()
        
    }
    @objc func removeCell(sender: AnyObject) {
        self.breakTimes.remove(at: sender.tag)
        TableView.reloadData()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
}
extension BreakTimeSettingViewController {
    func updatedata(){
        if breakTimes.isEmpty {
            return
        }
        breakStartTimeStr = "["
        breakEndTimeStr = "["
        for i in 0..<breakTimes.count {
            
            if i==breakTimes.count-1{
                breakStartTimeStr += "\(breakTimes[i].breakStartTime!)"
                breakEndTimeStr += "\(breakTimes[i].breakEndTime!)"
                break
            }
            breakStartTimeStr += "\(breakTimes[i].breakStartTime!)" + ","
            breakEndTimeStr += "\(breakTimes[i].breakEndTime!)" + ","
        }
        breakStartTimeStr += "]"
        breakEndTimeStr += "]"
        
    }
    
    func UpdateBreakTimeSetting(){
        if (!breakTimes.isEmpty) && (breakTimes[breakTimes.count-1].breakStartTime==nil || breakTimes[breakTimes.count-1].breakEndTime==nil){
            
            showMess(mess: "休憩時間を入力してください。")
            return
        }
        updatedata()
        var params = LWParams.initParamsLW()
        params["siteId"] = ATUserDefaults.getConstructionId()
        params["breakStartTimeStr"] = breakStartTimeStr
        params["breakEndTimeStr"] = breakEndTimeStr
        
        AlamofireManager.shared.request(APIRouter.post(url: API.AT_URL_UPDATESITEBREAKTIMES, params: params, identifier: nil)) { (response) in
            
            if response != nil{
                self.view.activityIndicatorView.stopAnimating()
                if let result : String = response?["status"] as? String{
                    if result.elementsEqual("OK"){
                        let alertView = UIAlertController(title: "", message: NSLocalizedString("Update_Success", comment: ""), preferredStyle: UIAlertControllerStyle.alert)
                        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                            self.navigationController?.popViewController(animated: true)
                        }
                        alertView.addAction(okAction)
                        
                        if let window = UIApplication.shared.delegate?.window, let rootVc = window?.rootViewController{
                            rootVc.present(alertView, animated: true, completion: nil)
                        }
                    }
                    
                }
            }
            else {
                
            }
            
        }
    }

    func loadBreakTimeSetting()
    {
        var params = LWParams.initParamsLW()
        params["key"] = ATUserDefaults.getConstructionId()
        AlamofireManager.shared.request(APIRouter.get(url: API.AT_URL_LISTCONTRUCTIONBREAKTIMES, params: params, identifier: nil)) { (response) in
            
            if response != nil{
                self.view.activityIndicatorView.stopAnimating()
                guard
                    let breakTimes: [SiteBreakTime] = Mapper<SiteBreakTime>().mapArray(JSONObject: response!["breakTimeModels"] )
                    else {
                        return
                    }
            self.breakTimes = breakTimes
            }
            
            self.TableView.reloadData()
        }
    }
    
    func loadReservationSetting()
    {
        var params = LWParams.initParamsLW()
        params["siteId"] = ATUserDefaults.getConstructionId()
        AlamofireManager.shared.request(APIRouter.get(url: API.AT_URL_CONSTRUCTION_DETAIL, params: params, identifier: nil)) { (response) in
            
            if response != nil{
                self.view.activityIndicatorView.stopAnimating()
                guard let construction : ATConstructionModel = Mapper<ATConstructionModel>().map(JSONObject: response!["constructionSite"] )
                    else{
                        return
                }
                
                self.bookingPeriod = construction.reservationSetting.bookingPeriod
                self.isDeadlineEnable =
                    construction.reservationSetting.isDeadlineEnable
                
                self.deadlinePeriod = construction.reservationSetting.deadlinePeriod
                self.isNoneWorkingEnable =  construction.reservationSetting.isNoneWorkingEnable
                self.workingStartTime = construction.reservationSetting.workingStartTime
                self.workingEndTime = construction.reservationSetting.workingEndTime
                self.isBreakTimeEnable = construction.reservationSetting.isBreakTimeEnable
                self.IsBeakTimeEnable.isOn = self.isBreakTimeEnable
            }
            
        }
    }
    func UpdateReservationSetting()
    {
        var params = LWParams.initParamsLW()
        params["siteId"] = ATUserDefaults.getConstructionId()
        params["bookingPeriod"] =  String(bookingPeriod!)
        params["isDeadlineEnable"] = String(isDeadlineEnable == true ? 1 : 0)
        params["deadlinePeriod"] = String(deadlinePeriod!)
        
        params["isNoneWorkingEnable"] = String(isNoneWorkingEnable == true ? 1 : 0)
        params["workingStartTime"] = self.workingStartTime
        params["workingEndTime"] = self.workingEndTime
        params["isBreakTimeEnable"] = String(isBreakTimeEnable == true ? 1 : 0)
        
        AlamofireManager.shared.request(APIRouter.post(url: API.AT_URL_UPDATESITERESERVATIONSETTING, params: params, identifier: nil)) { (response) in
            
            if response != nil{
                self.view.activityIndicatorView.stopAnimating()
                
            }
            else {
                
            }
            
        }
    }
}
