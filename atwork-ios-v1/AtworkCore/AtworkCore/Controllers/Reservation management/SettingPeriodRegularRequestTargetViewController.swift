//
//  SettingPeriodRegularRequestTargetViewController.swift
//  AtworkCore
//
//  Created by Trần Tiến Anh on 11/13/18.
//  Copyright © 2018 Atwork. All rights reserved.
//

import UIKit
import ObjectMapper
class SettingPeriodRegularRequestTargetViewController: UIViewController {
    @IBOutlet weak var SupplementaryExplantationVIew: UIView!
    
    @IBAction func updateChoice(_ sender: Any) {
    UpdateReservationSetting()
    }
    @IBOutlet weak var btnUpdate: LWRoundedDarkOrangeButton!
    @IBOutlet weak var TableView: UITableView!
    @IBOutlet weak var LBSupplementaryExplantation: UILabel!
    @IBOutlet weak var headerView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadReservationSetting()
        self.navigationController?.navigationBar.barTintColor = UIColor.orange
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.isTranslucent = false 
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        let leftBarButton = UIBarButtonItem(title: "＜戻る", style: .plain, target: self, action: #selector(self.tapLeftBarButton))
        leftBarButton.titleTextAttributes(for: .normal)
        leftBarButton.setTitleTextAttributes([NSAttributedStringKey.font: UIFont.boldFont(size: AT_FONT_SIZE_NORMAL)], for: .normal)
        leftBarButton.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItem = leftBarButton
        self.navigationItem.title = "予約申請対象期間設定"
        self.headerView.backgroundColor =  AT_COLOR_TITLE_INPUT_PERFORMACE
        self.headerView.layer.borderWidth = 0.5
        self.headerView.layer.borderColor = AT_COLOR_BORDER.cgColor
        
        self.SupplementaryExplantationVIew.layer.borderWidth = 0.5
        self.SupplementaryExplantationVIew.layer.borderColor = AT_COLOR_BORDER.cgColor
        TableView.register(UINib.init(nibName: "SettingPeriodRegularRequestTargetCell", bundle: Bundle.init(for: SettingPeriodRegularRequestTargetCell.self)), forCellReuseIdentifier: "SettingPeriodRegularRequestTargetCell")
        TableView.delegate = self
        TableView.dataSource = self
        TableView.isScrollEnabled = false
        TableView.tableFooterView = UIView()
        
    }

    @objc func tapLeftBarButton(){
        self.navigationController?.popViewController(animated: true)
    }
    var bookingPeriod: Int!
    var isDeadlineEnable: Bool!
    var deadlinePeriod: Int!
    var isNoneWorkingEnable: Bool!
    var workingStartTime = "8:00"
    var  workingEndTime = "17:30"
    var isBreakTimeEnable: Bool!
    var data:[String] = ["2週間","3週間","4週間"]
}
extension SettingPeriodRegularRequestTargetViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell1 = TableView.dequeueReusableCell(withIdentifier: "SettingPeriodRegularRequestTargetCell") as? SettingPeriodRegularRequestTargetCell
        if (cell1 == nil) {
            cell1 = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "SettingPeriodRegularRequestTargetCell") as? SettingPeriodRegularRequestTargetCell
        }
       
        if indexPath.row == bookingPeriod {
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
       bookingPeriod = indexPath.row
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
                self.bookingPeriod = construction.reservationSetting.bookingPeriod-2
                self.isDeadlineEnable =
                    construction.reservationSetting.isDeadlineEnable
                self.deadlinePeriod = construction.reservationSetting.deadlinePeriod
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
        params["bookingPeriod"] =  String(bookingPeriod+2)
        params["isDeadlineEnable"] = String(isDeadlineEnable == true ? 1 : 0)
        params["deadlinePeriod"] = String(deadlinePeriod)
        
        params["isNoneWorkingEnable"] = String(isNoneWorkingEnable == true ? 1 : 0)
        params["workingStartTime"] = self.workingStartTime
        params["workingEndTime"] = self.workingEndTime
        params["isBreakTimeEnable"] = String(isBreakTimeEnable == true ? 1 : 0)
        
        AlamofireManager.shared.request(APIRouter.post(url: API.AT_URL_UPDATESITERESERVATIONSETTING, params: params, identifier: nil)) { (response) in
            
            if response != nil{
                self.view.activityIndicatorView.stopAnimating()
                if let result : String = response?["status"] as? String{
                    if result.elementsEqual("OK"){
                        let alertView = UIAlertController(title: "", message: "更新が完了しました。", preferredStyle: UIAlertControllerStyle.alert)
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
