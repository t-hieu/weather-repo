//
//  OperationTimeSettingViewController.swift
//  AtworkCore
//
//  Created by Trần Tiến Anh on 11/14/18.
//  Copyright © 2018 Atwork. All rights reserved.
//

import UIKit
import ObjectMapper

class ReservationRequestDeadlineSettingViewController : UIViewController {

    @IBAction func updateChoice(_ sender: Any) {
        UpdateReservationSetting()
    }
    @IBAction func SwitchValueChanged(_ sender: Any) {
       self.isDeadlineEnable! = self.IsDealineEnable.isOn
    }
    @IBOutlet weak var IsDealineEnable: UISwitch!
    @IBOutlet weak var PeriodView: UIView!
    @IBOutlet weak var HeaderView: UIView!
    @IBOutlet weak var TableView: UITableView!
    
    @IBOutlet weak var VIewForLB: UIView!
    var bookingPeriod: Int?
    var isDeadlineEnable: Bool?
    var deadlinePeriod: Int?
    var isNoneWorkingEnable: Bool?
    var workingStartTime = "8:00"
    var  workingEndTime = "17:30"
    var isBreakTimeEnable: Bool?
    override func viewDidLoad() {
        super.viewDidLoad()
        loadReservationSetting()
        self.navigationController?.navigationBar.barTintColor = UIColor.orange
        self.navigationController?.navigationBar.isTranslucent = false 
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.title = "予約申請締め切り設定"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        let leftBarButton = UIBarButtonItem(title: "＜戻る", style: .plain, target: self, action: #selector(self.tapLeftBarButton))
        leftBarButton.titleTextAttributes(for: .normal)
        leftBarButton.setTitleTextAttributes([NSAttributedStringKey.font: UIFont.boldFont(size: AT_FONT_SIZE_NORMAL)], for: .normal)
        leftBarButton.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItem = leftBarButton
        self.HeaderView.backgroundColor =  AT_COLOR_TITLE_INPUT_PERFORMACE
        self.HeaderView.layer.borderWidth = 0.5
        self.HeaderView.layer.borderColor = AT_COLOR_BORDER.cgColor
        self.PeriodView.backgroundColor =  AT_COLOR_TITLE_INPUT_PERFORMACE
        self.PeriodView.layer.borderWidth = 0.5
        self.PeriodView.layer.borderColor = AT_COLOR_BORDER.cgColor
        self.VIewForLB.layer.borderWidth = 0.5
        self.VIewForLB.layer.borderColor = AT_COLOR_BORDER.cgColor
       
        
        TableView.register(UINib.init(nibName: "SettingPeriodRegularRequestTargetCell", bundle: Bundle.init(for: SettingPeriodRegularRequestTargetCell.self)), forCellReuseIdentifier: "SettingPeriodRegularRequestTargetCell")
        TableView.delegate = self
        TableView.dataSource = self
        TableView.tableFooterView = UIView()
   
    }
    
    var data = ["2日","3日","4日","5日","6日","7日","8日","9日","10日"]
    @objc func tapLeftBarButton(){
        self.navigationController?.popViewController(animated: true)
    }
    
}
extension ReservationRequestDeadlineSettingViewController : UITableViewDataSource , UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell1 = TableView.dequeueReusableCell(withIdentifier: "SettingPeriodRegularRequestTargetCell") as? SettingPeriodRegularRequestTargetCell
        if (cell1 == nil) {
            cell1 = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "SettingPeriodRegularRequestTargetCell") as? SettingPeriodRegularRequestTargetCell
        }
        
        if indexPath.row == deadlinePeriod {
            cell1?.imgchoice.image = getMyImage(imageName: "ic_radio_on")
            //            print(UIImage.init(named: "ic_radio_on"))
        }else {
            cell1?.imgchoice.image = getMyImage(imageName: "ic_radio_off")
        }
        cell1?.TitleLable.text = self.data[indexPath.row]
        return cell1!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        deadlinePeriod = indexPath.row
//        print(cellchosen)
        tableView.reloadData()
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
                self.IsDealineEnable.isOn = self.isDeadlineEnable!
                self.deadlinePeriod = construction.reservationSetting.deadlinePeriod-2
                self.isNoneWorkingEnable =  construction.reservationSetting.isNoneWorkingEnable
                
                self.workingStartTime = construction.reservationSetting.workingStartTime
                self.workingEndTime = construction.reservationSetting.workingEndTime
                self.isBreakTimeEnable = construction.reservationSetting.isBreakTimeEnable
                self.TableView.reloadData()
            }
            
        }
    }
    func UpdateReservationSetting()
    {
        var params = LWParams.initParamsLW()
        params["siteId"] = ATUserDefaults.getConstructionId()
        params["bookingPeriod"] =  String(bookingPeriod!)
        params["isDeadlineEnable"] = String(isDeadlineEnable == true ? 1 : 0)
        params["deadlinePeriod"] = String(deadlinePeriod!+2)
        
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
        }
    }
    
}
