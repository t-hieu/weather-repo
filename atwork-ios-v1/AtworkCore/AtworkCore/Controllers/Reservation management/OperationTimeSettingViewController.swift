//
//  OperationTimeSettingViewController.swift
//  AtworkCore
//
//  Created by Trần Tiến Anh on 11/14/18.
//  Copyright © 2018 Atwork. All rights reserved.
//

import UIKit
import TrenteCoreSwift
import ObjectMapper
class OperationTimeSettingViewController: UIViewController , OperationTimeSettingViewCellDelegate ,ATTimePickerViewDelegate {
    
    
    @IBAction func btnUpdateChoice(_ sender: Any) {
        UpdateReservationSetting()
    }
    @IBAction func valueChanged(_ sender: Any) {
       isNoneWorkingEnable =  swich.isOn
    }
    
        @IBOutlet weak var swich: UISwitch!
    @IBOutlet weak var HeaderVIew: UIView!
    
    @IBOutlet weak var VIewForLB: UIView!
    @IBOutlet weak var TitleView: UIView!
    @IBOutlet weak var TableView: UITableView!
   
    
    var bookingPeriod: Int?
    var isDeadlineEnable: Bool?
    var deadlinePeriod: Int?
    var isNoneWorkingEnable: Bool?
    var workingStartTime = "8:00"
    var  workingEndTime = "17:30"
    var isBreakTimeEnable: Bool?
    var breakTimes = [SiteBreakTime]()
    override func viewDidLoad() {
        super.viewDidLoad()
        loadReservationSetting()
        loadBreakTimeSetting()
        self.navigationController?.navigationBar.barTintColor = UIColor.orange
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.isTranslucent = false 
        self.navigationItem.title = "稼働時間設定"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        let leftBarButton = UIBarButtonItem(title: "＜戻る", style: .plain, target: self, action: #selector(self.tapLeftBarButton))
        leftBarButton.titleTextAttributes(for: .normal)
        leftBarButton.setTitleTextAttributes([NSAttributedStringKey.font: UIFont.boldFont(size: AT_FONT_SIZE_NORMAL)], for: .normal)
        leftBarButton.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItem = leftBarButton
        self.navigationItem.leftBarButtonItem = leftBarButton
        self.HeaderVIew.backgroundColor =  AT_COLOR_TITLE_INPUT_PERFORMACE
        self.HeaderVIew.layer.borderWidth = 0.5
        self.HeaderVIew.layer.borderColor = AT_COLOR_BORDER.cgColor
        self.VIewForLB.layer.borderWidth = 0.5
        self.VIewForLB.layer.borderColor = AT_COLOR_BORDER.cgColor
        self.TitleView.backgroundColor =  AT_COLOR_TITLE_INPUT_PERFORMACE
        self.TitleView.layer.borderWidth = 0.5
        self.TitleView.layer.borderColor = AT_COLOR_BORDER.cgColor
        TableView.register(UINib.init(nibName: "OperationTimeSettingViewCell", bundle: Bundle.init(for: OperationTimeSettingViewCell.self)), forCellReuseIdentifier: "OperationTimeSettingViewCell")
        TableView.dataSource = self
        TableView.delegate = self
        TableView.isScrollEnabled = false
        TableView.tableFooterView = UIView()
    }
    var timePickerView: ATTimePickerView!
    
    var pikerview: TRPickerView!
    @objc func tapLeftBarButton(){
        self.navigationController?.popViewController(animated: true)
    }
    func donePickerView(pickerView: ATTimePickerView, hourSelected: String, minSelected: String) {
        if pickerView.tag == 3 {
            if  timeToInt(time: self.workingEndTime) <= timeToInt(time: hourSelected + ":" + minSelected) {
                let alertController = UIAlertController(title: "", message: "開始時刻は終了時刻より大きく出来ません。", preferredStyle: .alert)
                let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .destructive, handler:nil)
                alertController.addAction(okAction)
                present(alertController, animated: true, completion: nil)
                return
            }
            for breaktime in breakTimes {
                print(timeToInt(time: hourSelected + ":" + minSelected) < timeToInt(time: breaktime.breakStartTime))
                if !(timeToInt(time: hourSelected + ":" + minSelected) <= timeToInt(time: breaktime.breakStartTime) ){
                    showMess(mess: "勤務時間外に休憩時間を設定することはできません。以下の点を確認してください。\n-稼働時間が休憩時間を含むように稼働開始時間 もしくは 稼働終了時間を変更する \n-休憩時間が勤務時間内に収まるように休憩開始時間、終了時間を変更する")
                    return
                }
            }
            self.workingStartTime = hourSelected + ":" + minSelected
            
        }
        else if pickerView.tag == 4 {
            if  timeToInt(time: self.workingStartTime) >= timeToInt(time: hourSelected + ":" + minSelected) {
            let alertController = UIAlertController(title: "", message: "開始時刻は終了時刻より大きく出来ません。", preferredStyle: .alert)
            let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .destructive, handler:nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
            return
            }
            for breaktime in breakTimes {
                if timeToInt(time: hourSelected + ":" + minSelected) < timeToInt(time: breaktime.breakEndTime) {
                    showMess(mess: "勤務時間外に休憩時間を設定することはできません。以下の点を確認してください。\n-稼働時間が休憩時間を含むように稼働開始時間 もしくは 稼働終了時間を変更する \n-休憩時間が勤務時間内に収まるように休憩開始時間、終了時間を変更する")
                    return
                }
            }
            self.workingEndTime = hourSelected + ":" + minSelected
        }
    
    self.TableView.reloadData()
    
}
    func timeToInt(time:String)->Int{
        let result = time.components(separatedBy: ":")
        var k1 = Int( result[0])!*60 + Int( result[1])!
        return k1
    }
    func showMess(mess:String) {
        let alertController = UIAlertController(title: "", message: mess, preferredStyle: .alert)
        let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .destructive, handler:nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    func tapContentFromTo(isFrom: Bool, tag: Int) {
        if(tag == 1){
           
            if(timePickerView == nil){
                timePickerView = ATTimePickerView.init()
                timePickerView?.delegate = self
            }
            
            var currentH = 0
            var currentM = 0
            if isFrom {
                self.timePickerView.tag = 3
                let time = workingStartTime.components(separatedBy: ":")
                currentH = Int(time[0])!
                currentM = Int(time[1])!
                
            } else {
                self.timePickerView.tag = 4
                let time = workingEndTime.components(separatedBy: ":")
                currentH = Int(time[0])!
                currentM = Int(time[1])!
            }
            timePickerView.setData(hourAdd: 6, timeInterval: 15,currentHour: currentH, currentMin: currentM)
           
            timePickerView?.show()
            
        }

    }
    
    

}
extension OperationTimeSettingViewController : UITableViewDataSource ,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell1 = TableView.dequeueReusableCell(withIdentifier: "OperationTimeSettingViewCell") as? OperationTimeSettingViewCell
        if (cell1 == nil) {
            cell1 = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "OperationTimeSettingViewCell") as? OperationTimeSettingViewCell
        }
        
        //        if indexPath.row == cellchosen {
        //            cell1?.imgchoice.image = UIImage.init(named: "ic_radio_on")
        //            print(UIImage.init(named: "ic_radio_on"))
        //        }
        //        else {
        //            cell1?.imgchoice.image = UIImage.init(named: "ic_radio_off")
        //        }
        cell1?.tagView = 1
        cell1?.delegate = self
        cell1?.setContentText(isFrom: true, contentText: workingStartTime)
        cell1?.setContentText(isFrom: false, contentText: workingEndTime)
        return cell1!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
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
                self.swich.isOn = self.isNoneWorkingEnable!
                self.workingStartTime = construction.reservationSetting.workingStartTime
                self.workingEndTime = construction.reservationSetting.workingEndTime
                self.isBreakTimeEnable = construction.reservationSetting.isBreakTimeEnable
                
                self.TableView.reloadData()
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
}
