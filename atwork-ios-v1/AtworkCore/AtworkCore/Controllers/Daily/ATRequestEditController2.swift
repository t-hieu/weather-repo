//
//  ATRequestEditController.swift
//  AtworkCore
//
//  Created by CuongNV on 10/5/18.
//  Copyright © 2018 Atwork. All rights reserved.
//

import UIKit
import TrenteCoreSwift
import ObjectMapper
import FSCalendar



public class ATRequestEditController2: UIViewController, UITableViewDataSource, UITableViewDelegate, TRDatePickerViewDelegate, InfoTopViewCellDelegate, InfoOneLabelViewCellDelegate, FromToViewCellDelegate, FromTo3ViewCellDelegate, CameraViewCellDelegate, UITextFieldDelegate, ELVSelectionControlerDelegate, LiftMaterialSelectionDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate,  CateGoryCellDelegate,UITextViewDelegate, FloorSelectionControllerDelegate, TransportVehicleControllerDelegate, ButtonViewCellDelegate, ForkliftCellDelegate, PackingCellDelegate, ATTimePickerViewDelegate, ATDatePickerDelegate, ATChoseCustomerControllerDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    var isEventMode: Bool = true
    var isCustomerApp: Bool!
    var timeRequire: String! = ""
    var Title:String?
    var schedule: ATScheduleModel2!
    public var tableId: Int! = 0
    var floors = [String]()
    var floorChose: String! = ""
    var lifts = [ATLiftModel]()
//    var liftChose: ATLiftModel!
    var goods = [ATGoodModel]()
    var vehicles = [VehicleModel]()
//    var vehicleChose: VehicleModel!
    var packings = [Int]()
    var imageData: Data!
    public var currentDate: Date!
    var modeEditStatus: Int! = -1
    public var siteId: Int! = -1
    
    var isConfirm: Bool! = true
    var stateControler: Int! = -1
    var datePickerView: TRDatePickerView!
    var timePickerView: ATTimePickerView!
    var pikerview: TRPickerView!
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        Title = TRFormatUtil.formatDateCustom(date: self.currentDate, format: "yyyy年M月d日 申請フォーム")
        if ATUserDefaults.getCustomerUserFlag().elementsEqual("1") {
            self.isCustomerApp = true
        }else {
            self.isCustomerApp = false
        }
//        self.navigationItem.title = "2018年8月15日 Request form"
        self.navigationController?.navigationBar.barTintColor = UIColor.orange
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        self.navigationController?.navigationBar.isTranslucent = false
        let leftBarButton = UIBarButtonItem(title: "＜戻る", style: .plain, target: self, action: #selector(self.tapLeftBarButton))
        leftBarButton.titleTextAttributes(for: .normal)
        leftBarButton.setTitleTextAttributes([NSAttributedStringKey.font: UIFont.boldFont(size: AT_FONT_SIZE_NORMAL)], for: .normal)
        leftBarButton.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItem = leftBarButton
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(UINib.init(nibName: "InfoOneLabelViewCell", bundle: Bundle.init(for: InfoOneLabelViewCell.self)), forCellReuseIdentifier: "InfoOneLabelViewCell")
        self.tableView.register(UINib.init(nibName: "InfoTopViewCell", bundle: Bundle.init(for: InfoTopViewCell.self)), forCellReuseIdentifier: "InfoTopViewCell")
        self.tableView.register(UINib.init(nibName: "PrInfoTopViewCell", bundle: Bundle.init(for: PrInfoTopViewCell.self)), forCellReuseIdentifier: "PrInfoTopViewCell")
        self.tableView.register(UINib.init(nibName: "PrInfoTopViewerCell", bundle: Bundle.init(for: PrInfoTopViewerCell.self)), forCellReuseIdentifier: "PrInfoTopViewerCell")
        self.tableView.register(UINib.init(nibName: "FromToViewCell", bundle: Bundle.init(for: FromToViewCell.self)), forCellReuseIdentifier: "FromToViewCell")
        self.tableView.register(UINib.init(nibName: "FromTo3ViewCell", bundle: Bundle.init(for: FromTo3ViewCell.self)), forCellReuseIdentifier: "FromTo3ViewCell")
        self.tableView.register(UINib.init(nibName: "CategoryViewCell", bundle: Bundle.init(for: CategoryViewCell.self)), forCellReuseIdentifier: "CategoryViewCell")
        self.tableView.register(UINib.init(nibName: "PackingViewCell", bundle: Bundle.init(for: PackingViewCell.self)), forCellReuseIdentifier: "PackingViewCell")

        self.tableView.register(UINib.init(nibName: "ForkliftViewCell", bundle: Bundle.init(for: ForkliftViewCell.self)), forCellReuseIdentifier: "ForkliftViewCell")
        self.tableView.register(UINib.init(nibName: "MessageViewCell", bundle: Bundle.init(for: MessageViewCell.self)), forCellReuseIdentifier: "MessageViewCell")
        self.tableView.register(UINib.init(nibName: "CameraViewCell", bundle: Bundle.init(for: CameraViewCell.self)), forCellReuseIdentifier: "CameraViewCell")
        self.tableView.register(UINib.init(nibName: "ButtonViewCell", bundle: Bundle.init(for: ButtonViewCell.self)), forCellReuseIdentifier: "ButtonViewCell")
        self.tableView.register(UINib.init(nibName: "ButtonEditViewCell", bundle: Bundle.init(for: ButtonEditViewCell.self)), forCellReuseIdentifier: "ButtonEditViewCell")
        self.tableView.register(UINib.init(nibName: "InfoOneTextFieldViewCell", bundle: Bundle.init(for: InfoOneTextFieldViewCell.self)), forCellReuseIdentifier: "InfoOneTextFieldViewCell")
        self.tableView.register(UINib.init(nibName: "OwnerViewCell", bundle: Bundle.init(for: OwnerViewCell.self)), forCellReuseIdentifier: "OwnerViewCell")
        
        self.schedule = ATScheduleModel2.init()
        
        loadScheduleDetail()
    }
    
    @objc func tapLeftBarButton(){
        
        self.navigationController?.popViewController(animated: true)
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        
        self.navigationItem.title = Title
        if self.stateControler == AT_SCHEDULE_DETAIL_EDIT || self.stateControler == AT_SCHEDULE_DETAIL_CONFIRM {
            self.navigationController?.navigationBar.barTintColor = UIColor.red
        }
//        self.setupViewResizerOnKeyboardShown()
    }
    
    override public func viewDidAppear(_ animated: Bool) {
        
        tableView.reloadData()
        self.hideKeyboardWhenTappedAround()
    }
    
    override public func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = UIColor.orange
        self.navigationController?.navigationBar.isTranslucent = false
    }
   
    func loadScheduleDetail(){
        var params = LWParams.initParamsLW()
        params["tableId"] = self.tableId?.description
        if self.siteId > 0 {
            params["siteId"] = String(self.siteId)
        }else {
            params["siteId"] = ATUserDefaults.getConstructionId()
        }
        self.view.activityIndicatorView.startAnimating()
        AlamofireManager.shared.request(APIRouter.get(url: API.LW_URL_SCHEDULE_DETAIL, params: params, identifier: nil)) { (response) in
//            self.view.activityIndicatorView.stopAnimating()
            if response != nil{
                self.view.activityIndicatorView.stopAnimating()
                guard let schedule : ATScheduleModel2 = Mapper<ATScheduleModel2>().map(JSONObject: response!["schedule"] ),
                    let lifts: [ATLiftModel] = Mapper<ATLiftModel>().mapArray(JSONObject: response!["lifts"] )
                    else{
                        return
                }
                let statusMap = response?["scheduleStatusMap"] as! [String : String]
                let map = response?["vehicleMap"] as! [String : String]
                self.vehicles.removeAll()
                self.vehicles = map.map{
                    (arg) -> VehicleModel in
                    return VehicleModel.init(key: arg.key, value: arg.value)!
                }
                self.vehicles = self.vehicles.sorted(by: { $0.key < $1.key })
                
                self.floors.removeAll()
                if let floors = response?["floors"] as? [String]{
                    for floor in floors{
                        self.floors.append(floor)
                    }
                }
                self.schedule = schedule
                for mapS in statusMap {
                    if self.schedule.status == Int(mapS.key) {
                        self.schedule.statusString = mapS.value
                    }
                }
                self.tableId = schedule.tableId
                if self.tableId == 0 {
                    self.schedule.startDate = TRFormatUtil.formatDateCustom(date: self.currentDate, format: "yyyy/MM/dd")
                    self.isConfirm = false
                    self.stateControler = AT_SCHEDULE_NEW_CREATE
                }else {
                    self.isConfirm = true
                    self.stateControler = AT_SCHEDULE_DETAIL_VIEW
                }
                
//                self.vehicles = vehicles
                self.lifts = lifts
                self.updateData()
                self.tableView.reloadData()
            } else {
               self.navigationController?.popViewController(animated: true)
            }
        }
    }
    func updateData(){
        if self.schedule == nil {return}
        if self.currentDate == nil && self.schedule.tableId > 0{
            self.currentDate =  TRDateUtil.makeDateCustom(date: self.schedule.startDate!, format: "yyyy/MM/dd")
        }
        if self.schedule.scheduleType == 2 {
            isEventMode = true
        }else {
            isEventMode = false
        }
        if self.isEventMode == true {
            self.Title = TRFormatUtil.formatDateCustom(date: self.currentDate, format: "yyyy年M月d日 行事申請フォーム")
        } else {
            self.Title = TRFormatUtil.formatDateCustom(date: self.currentDate, format: "yyyy年M月d日 申請フォーム")
        }
        self.navigationItem.title = Title
        if(self.schedule.endTimeHour != nil && self.schedule.endTimeHour!.count > 0 && self.schedule.startTimeHour != nil && self.schedule.startTimeHour!.count > 0){
            self.timeRequire = self.caculateExpectedTime(startH: self.schedule.startTimeHour, startM: self.schedule.startTimeMin, endH: self.schedule.endTimeHour, endM: self.schedule.endTimeMin)
        }
        if (self.schedule.packingMethodIds?.count)! > 0 {
            let packingsString : [String] = (self.schedule.packingMethodIds?.components(separatedBy: ","))!
            self.packings.removeAll()
            for temp in packingsString {
                if(temp.count > 0 ){
                    self.packings.append(Int(temp)!)
                }
            }
            
        }
        if(self.schedule.imagePath != nil && (self.schedule.imagePath?.count)! > 0){
            self.imageData = try? Data(contentsOf: self.makeUrl(filePath: self.schedule.imagePath))
        }
//        if isCustomerApp {
//            self.schedule.customer.customerId = Int(ATUserDefaults.getCustomerId())
//        }
        if self.tableId == 0 {
            self.modeEditStatus = MODE_EDIT_NONE
            
//            if self.schedule.times == 0 {
//                self.schedule.times = -1
//            }
        }else {
            if !isCustomerApp {
                if schedule.createUserModel != nil && schedule.createUserModel.customerId == 1 {
                    self.modeEditStatus = MODE_EDIT_PRO_PRO
                }else {
                    self.modeEditStatus = MODE_EDIT_PRO_CUS
                }
            }else {
                self.modeEditStatus = MODE_EDIT_CUS_CUS
            }
        }
    }
    
    func makeUrl(filePath: String!) -> URL {
        var tmpFilePath = filePath
        tmpFilePath = tmpFilePath?.replacingOccurrences(of: " ", with: "%20")
        let tmpFileURL = URL.init(string: String.init(format: "%@%@", BASE_URL, tmpFilePath!))
        return tmpFileURL!
    }
    
    func checkFillData() -> Bool {
        
        if self.schedule.startTimeHour == nil || self.schedule.startTimeHour.count == 0 {
            return false
        }
        
        if self.schedule.endTimeHour == nil || self.schedule.endTimeHour.count == 0 {
            return false
        }
        if self.schedule.categoryId < 1 {
            return false
        }
        
        
//        if  schedule.gate == nil || schedule.gate == -1
//        {
//            return false
//        }
        if !isCustomerApp {
            if self.schedule.customer.customerId == nil {
                return false
            }
        }
        if !self.isEventMode {
            if self.schedule.goods.count == 0 {
                return false
            }
            if self.schedule.liftIds.count == 0 {
                return false
            }
            if self.schedule.departure == nil || self.schedule.departure?.count == 0 {
                return false
            }
            if self.schedule.arrival == nil || self.schedule.departure!.count == 0 {
                return false
            }
            if self.packings.count == 0 {
                return false
            }
            if schedule.isForkLift < 0
            {
                return false
            }
            if schedule.times == nil || schedule.times < 0 {
                return false
            }
//            var num = 0
//            for vehicle in self.schedule.vehicles {
//                if vehicle.number > 0 {
//                    num += 1
//                }
//            }
//            if num == 0 {
//                return false
//            }
            
        }else {
            if self.schedule.endDate == nil || self.schedule.endDate?.count == 0 {
                return false
            }
        }
        return true
    }
    
    func deleteSchedule(){
        var params = LWParams.initParamsLW()
        params["tableId"] = self.tableId?.description
        self.view.activityIndicatorView.startAnimating()
        AlamofireManager.shared.request(APIRouter.post(url: API.AT_URL_DELETE_SCHEDULE, params: params, identifier: nil)) { (response) in
            
            self.view.activityIndicatorView.stopAnimating()
            if response != nil{
                if let result : String = response?["status"] as? String{
                    if result.elementsEqual("OK"){
                        self.navigationController?.popViewController(animated: true)
                    } else {
                        if let message: String = response?["message"] as? String{
                            print(message)
                        }
                    }
                }
            }
        }
    }
    
    func validateUpdateSchedule(nextStatus: Int){
        let params = self.createParamsUpdateSchedule()
        self.view.activityIndicatorView.startAnimating()
        AlamofireManager.shared.upload({ (formData) in
            if(self.imageData != nil){
                formData.append(self.imageData, withName: "image", fileName: "\(ATUserDefaults.getUserId()).jpg", mimeType: "image/*")
            }
        }, params: params, with: APIRouter.post(url: API.LW_URL_SCHEDULE_VALIDATE,params: params, identifier: nil)) { (response) in
            self.view.activityIndicatorView.stopAnimating()
            if response != nil{
                if let result : String = response?["status"] as? String{
                    if result.elementsEqual("OK"){
        
                        self.isConfirm = true
                        self.stateControler = nextStatus
                        self.tableView.reloadData()
                    } else {
                        if var messages: String = response?["messages"] as? String{
                            messages = messages.replacingOccurrences(of: "<br>", with: "\n")
                            self.showMessage(messages: messages)
                        }
                    }
                }
            }
        }

    }
    
    func updateScheduleWarning(){
        var params = LWParams.initParamsLW()
        params["siteId"] = self.schedule.constructionSite?.key!.description
        params["scheduleId"] = tableId.description
        
        if self.isEventMode {
            if(self.schedule.startDate != nil){
                params["startDate"] = self.schedule.startDate! + " 00:00"
            }
            if(self.schedule.endDate != nil){
                params["endDate"] = self.schedule.endDate! + " 00:00"
            }
        }else {
            if(self.schedule.startDate != nil){
                params["startDate"] = self.schedule.startDate! + " 00:00"
                params["endDate"] = self.schedule.startDate! + " 00:00"
            }
        }
//        self.view.activityIndicatorView.startAnimating()
        AlamofireManager.shared.request(APIRouter.get(url: API.AT_URL_SCHEDULE_WARNING, params: params, identifier: nil)) { (response) in
//            self.view.activityIndicatorView.stopAnimating()
            if response != nil{
                if let result : String = response?["status"] as? String{
                    if result.elementsEqual("OK"){
                        if let resultCode : Bool = response?["hasReturnCode"] as? Bool{
                            if resultCode {
                                if var messages: String = response?["messages"] as? String{
                                    messages = messages.replacingOccurrences(of: "<br>", with: "\n")
                                    self.confirmMessages(messages: messages, funcOK: self.updateSchedule)
                                }
                            }else {
                                self.updateSchedule()
                            }
                        }
                    } else {
                        if var messages: String = response?["messages"] as? String{
                            messages = messages.replacingOccurrences(of: "<br>", with: "\n")
                            self.showMessage(messages: messages)
                        }
                    }
                }
            }
        }
        
    }
    
    
    func createParamsUpdateSchedule() -> [String:String]{
        var params = LWParams.initParamsLW()
        params["tableId"] = self.tableId?.description
        params["siteId"] = self.schedule.constructionSite?.key!.description
        
        params["liftIds"] = self.convertArrayIntToString(list: self.schedule.liftIds, split: ",")
        //                self.liftChose.liftId?.description
        var statusSchedule = AT_SCHEDULE_STATUS_DECIDED
        if isCustomerApp {
            statusSchedule = AT_SCHEDULE_STATUS_ADJUSTING
            params["customerId"] = ATUserDefaults.getCustomerId()
        }else if self.schedule != nil && self.schedule.customer != nil && self.schedule.customer.customerId != nil{
            params["customerId"] = "\(self.schedule.customer.customerId ?? 0)"
        }
        params["status"] = String(statusSchedule)
        var goodString = ""
        for good in self.schedule.goods {
            goodString += good.goodId!.description + ", "
        }
        if goodString.count > 2 {
            goodString.removeLast()
            goodString.removeLast()
        }
        params["goodIds"] = goodString
        
        if self.isEventMode {
            params["scheduleType"] = "2"
            if(self.schedule.startDate != nil){
                params["startDate"] = self.schedule.startDate! + " 00:00"
            }
            if(self.schedule.endDate != nil){
                params["endDate"] = self.schedule.endDate! + " 00:00"
            }
        }else {
            params["scheduleType"] = "1"
            if(self.schedule.startDate != nil){
                params["startDate"] = self.schedule.startDate! + " 00:00"
                params["endDate"] = self.schedule.startDate! + " 00:00"
            }
        }
        params["startTime"] = self.schedule.getStarttimeSend()
        params["endTime"] = self.schedule.getEndtimeSend()
        if(self.schedule.gate != nil) {
            params["gate"] = String(self.schedule.gate)
        }else {
            params["gate"] = "-1"
        }
        
        if(self.schedule.times != nil) {
            params["times"] = String(self.schedule.times)
        }else {
            params["times"] = "-1"
        }
        params["departure"] = self.schedule.departure
        params["arrival"] = self.schedule.arrival
        params["arrival2"] = self.schedule.arrival2
        params["arrival3"] = self.schedule.arrival3
        params["loginUserId"] = ATUserDefaults.getUserId()
        params["categoryId"] = String(self.schedule.categoryId)
        params["packingMethodIds"] = self.convertArrayIntToString(list: self.packings, split: ",")
        params["reservationOperationStart"] = self.schedule.reservationOperationStart
        params["reservationOperationEnd"] = self.schedule.reservationOperationEnd
        params["applicableStr"] = self.schedule.applicableStr
        params["decicedDateStr"] = self.schedule.decicedDateStr
        params["breakTimeStr"] = self.schedule.breakTimeStr
        params["breakTimeEnable"] = String(self.schedule.breakTimeEnable)
        var vehicleString = ""
        for vehicle in self.schedule.vehicles {
            if vehicle.number > 0{
                vehicleString += String(vehicle.key) + "x" + String(vehicle.number) + ","
            }
        }
        if vehicleString.count > 0 {
            vehicleString.removeLast()
        }
        params["vehicleNames"] = vehicleString
        params["isForkLift"] = String(self.schedule.isForkLift)
        params["note"] = self.schedule.note
        return params
    }
    
    func updateSchedule(){
        let params = self.createParamsUpdateSchedule()
        self.view.activityIndicatorView.startAnimating()
        AlamofireManager.shared.upload({ (formData) in
            if(self.imageData != nil){
                formData.append(self.imageData, withName: "image", fileName: "\(ATUserDefaults.getUserId()).jpg", mimeType: "image/*")
            }
        }, params: params, with: APIRouter.post(url: API.LW_URL_SCHEDULE_UPDATE,params: params, identifier: nil)) { (response) in
            self.view.activityIndicatorView.stopAnimating()
            if response != nil{
                if let result : String = response?["status"] as? String{
                    if result.elementsEqual("OK"){
//                        self.navigationController?.popViewController(animated: true)
                        if var messages: String = response?["messages"] as? String{
                            messages = messages.replacingOccurrences(of: "<br>", with: "\n")
                            let alertView = UIAlertController(title: "", message: messages, preferredStyle: UIAlertControllerStyle.alert)
                            let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                                self.navigationController?.popViewController(animated: true)
                            }
                            alertView.addAction(okAction)
                            
                            if let window = UIApplication.shared.delegate?.window, let rootVc = window?.rootViewController{
                                rootVc.present(alertView, animated: true, completion: nil)
                            }
                        }
                    } else {
                        if let message: String = response?["message"] as? String{
                            print(message)
                        }
                    }
                }
            }
        }
        
    }
    
    public func isEditRow(tagRow: Int) -> Bool{
        if self.isConfirm {
            return false
        }
        switch tagRow {
        case TAG_ROW_INFO:
            if self.modeEditStatus == MODE_EDIT_PRO_PRO || self.modeEditStatus == MODE_EDIT_NONE{
                return true
            }
            return false
        case TAG_ROW_STARTDATE:
            if self.modeEditStatus == MODE_EDIT_PRO_PRO || self.modeEditStatus == MODE_EDIT_PRO_CUS {
                return true
            }
            return false
        case TAG_ROW_ENDDATE:
            return true
        case TAG_ROW_REQUIRED_TIME:
            return true
        case TAG_ROW_START_TIME:
            return true
        case TAG_ROW_END_TIME:
            return true
        case TAG_ROW_ELV:
            return true
        case TAG_ROW_CATEGORY, TAG_ROW_GOOD, TAG_ROW_GATE, TAG_ROW_FROM, TAG_ROW_TO, TAG_ROW_TO3, TAG_ROW_TIME, TAG_ROW_VERHICLE, TAG_ROW_PACKING, TAG_ROW_IS_FORK_LIFT, TAG_ROW_NOTE:
            if self.modeEditStatus != MODE_EDIT_PRO_CUS {
                return true
            }
            return false
        case TAG_ROW_CAMERA:
            if self.modeEditStatus == MODE_EDIT_NONE {
                return true
            }
            return false
            
        default:
            return false
        }
        
    }
    
    //table view
    public func numberOfSections(in tableView: UITableView) -> Int {
        
        if self.tableId == 0 || !isCustomerApp || (self.schedule != nil && schedule.status <= 1 && self.schedule.customer != nil && ATUserDefaults.getCustomerId().elementsEqual(String(self.schedule.customer.customerId ?? 0))) {
            return 4
        }else {
            return 3
        }
        
//        return 3
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 3 {
            return 1
        }else if(section == 2){
            if self.tableId == 0 {
                return 13
            }else {
                if self.schedule.updateUserName != nil && self.schedule.updateDateStr != nil{
                    return 16
                }else {
                    return 15
                }
            }
        }else if section == 0{
            if isCustomerApp || self.tableId != 0 {
                return 1
            }
            return 2
        }else {
            if(isEventMode){
                return 2
            }
        }
        return 1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.section == 0){
            if(indexPath.row == 0){
                if (self.isCustomerApp){
                    var cell = tableView.dequeueReusableCell(withIdentifier: "InfoTopViewCell") as? InfoTopViewCell
                    if (cell == nil) {
                        cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "InfoTopViewCell") as? InfoTopViewCell
                    }
                    cell?.setActive(isActive: self.isEditRow(tagRow: TAG_ROW_INFO))
                    if self.schedule != nil && self.schedule.constructionSite != nil{
                        cell?.constructionName.text = self.schedule.constructionSite?.constructionName
                    }
                    if self.tableId == 0 {
                        cell?.companyName.text = ATUserDefaults.getCompanyName()
                        cell?.persionName.text = ATUserDefaults.getUserName()
//                        cell?.constructionName.text = ATUserDefaults.getConstructionName()
                    }else {
                        var companyName = " "
                        if self.schedule.createUserModel != nil && schedule.createUserModel.customerId != 1 && self.schedule.customer != nil && self.schedule.customer.customerName != nil {
                            companyName = self.schedule.customer.customerName!
                        }else if self.schedule.createUserModel != nil{
                            companyName = "管理者による申請"
                        }
                        
                        cell?.companyName.text = companyName
                        
                        var userName = " "
                        if self.schedule.createUserModel != nil && self.schedule.createUserModel.userName != nil {
                            userName = self.schedule.createUserModel.userName!
                        }
                        cell?.persionName.text = userName
                    }
                    cell?.delegate = self
                    cell?.setSwichOn(isOn: self.isEventMode)
                    return cell!
                }else {
                    if self.tableId == 0 {
                        var cell = tableView.dequeueReusableCell(withIdentifier: "InfoTopViewCell") as? InfoTopViewCell
                        if (cell == nil) {
                            cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "InfoTopViewCell") as? InfoTopViewCell
                        }
                        cell?.setActive(isActive: self.isEditRow(tagRow: TAG_ROW_INFO))
                        if self.schedule != nil && self.schedule.constructionSite != nil {
                            cell?.constructionName.text = self.schedule.constructionSite?.constructionName
                        }
                        cell?.companyName.text = "管理者による申請"
                        cell?.persionName.text = ATUserDefaults.getUserName()
                        cell?.delegate = self
                        cell?.setSwichOn(isOn: self.isEventMode)
                        return cell!
                    }else {
                        var cell = tableView.dequeueReusableCell(withIdentifier: "PrInfoTopViewerCell") as? PrInfoTopViewerCell
                        if (cell == nil) {
                            cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "PrInfoTopViewerCell") as? PrInfoTopViewerCell
                        }
                        cell?.setActive(isActive: self.isEditRow(tagRow: TAG_ROW_INFO))
                        if self.schedule != nil && self.schedule.constructionSite != nil {
                            cell?.constructionName.text = self.schedule.constructionSite?.constructionName
                        }
                        var companyName = " "
                        if self.schedule.customer != nil && self.schedule.customer.customerName != nil {
                            companyName = self.schedule.customer.customerName!
                        }
                        cell?.companyName.text = companyName
                        
                        var userName = " "
                        if self.schedule.createUserModel != nil && self.schedule.createUserModel.userName != nil {
                            userName = self.schedule.createUserModel.userName!
                        }
                        cell?.persionName.text = userName
                        cell?.delegate = self
                        cell?.setSwichOn(isOn: self.isEventMode)
                        if (self.modeEditStatus == MODE_EDIT_PRO_PRO) {
                            cell?.companyName.text = "管理者による申請"
                            cell?.persionName.isHidden = true
                            cell?.persionNameText.isHidden = true
                            cell?.underLine.isHidden = true
                            cell?.btShowDetailCreater.isUserInteractionEnabled          = false
                        }
                        return cell!
                    }
                }
            }else{
                var cell = tableView.dequeueReusableCell(withIdentifier: "InfoOneLabelViewCell")
                    as? InfoOneLabelViewCell
                if (cell == nil) {
                    cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "InfoOneLabelViewCell") as? InfoOneLabelViewCell
                }
                var textContent = ""
                if self.schedule.customer != nil && self.schedule.customer.customerName != nil {
                    textContent = self.schedule.customer.customerName!
                }
                cell?.updateData(titleText: "業者", contentText: textContent, tagView: TAG_ROW_CUSTOMER, isActive: !self.isConfirm, delegate: self, isShowAddLabel: true, isForce: true)
                return cell!
            }
        }else if indexPath.section == 1 {
            if(indexPath.row == 0){
                var cell = tableView.dequeueReusableCell(withIdentifier: "InfoOneLabelViewCell") as? InfoOneLabelViewCell
                if (cell == nil) {
                    cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "InfoOneLabelViewCell") as? InfoOneLabelViewCell
                }
                let isActive = self.isEditRow(tagRow: TAG_ROW_STARTDATE)
                var titleText = "希望日"
                if isEventMode{
                    titleText = "希望日開始"
                }
                var textContent = ""
                if self.schedule.startDate != nil && self.schedule.startDate!.count > 0{
                    textContent = self.getStringDateJP(dateString: self.schedule.startDate!)
                }
                cell?.updateData(titleText: titleText, contentText: textContent, tagView: TAG_ROW_STARTDATE, isActive: isActive, delegate: self, isShowAddLabel: false, isForce: true)
                return cell!
            }else {
                var cell = tableView.dequeueReusableCell(withIdentifier: "InfoOneLabelViewCell") as? InfoOneLabelViewCell
                if (cell == nil) {
                    cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "InfoOneLabelViewCell") as? InfoOneLabelViewCell
                }
                let isActive =  self.isEditRow(tagRow: TAG_ROW_ENDDATE)
                var textContent = ""
                if self.schedule.endDate != nil && self.schedule.endDate != "" {
                    textContent = self.getStringDateJP(dateString: self.schedule.endDate!)
                }
                cell?.updateData(titleText: "希望日終了", contentText: textContent, tagView: TAG_ROW_ENDDATE, isActive: isActive, delegate: self, isShowAddLabel: false, isForce: true)
                return cell!
            }
        
        }else if indexPath.section == 2{
            if(indexPath.row == 0){
                var cell = tableView.dequeueReusableCell(withIdentifier: "FromToViewCell") as? FromToViewCell
                if (cell == nil) {
                    cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "FromToViewCell") as? FromToViewCell
                }
                cell?.updateData(titleText: "希望時間", contentTextFrom: self.schedule.getStarttimeShow(), contentTextTo: self.schedule.getEndtimeShow(), textAlignment: .left,tagView: TAG_ROW_START_TIME, isActive: self.isEditRow(tagRow: TAG_ROW_START_TIME), delegate: self, isForce: true)
                
                return cell!
            }else if(indexPath.row == 1){
                var cell = tableView.dequeueReusableCell(withIdentifier: "InfoOneLabelViewCell") as? InfoOneLabelViewCell
                if (cell == nil) {
                    cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "InfoOneLabelViewCell") as? InfoOneLabelViewCell
                }
                let isActive = self.isEditRow(tagRow: TAG_ROW_REQUIRED_TIME)
                cell?.updateData(titleText: "所要時間", contentText: self.timeRequire, tagView: TAG_ROW_REQUIRED_TIME, isActive: isActive, delegate: self, isShowAddLabel: false, isForce: true)
                return cell!
            }else if(indexPath.row == 2){
                var cell = tableView.dequeueReusableCell(withIdentifier: "InfoOneLabelViewCell") as? InfoOneLabelViewCell
                if (cell == nil) {
                    cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "InfoOneLabelViewCell") as? InfoOneLabelViewCell
                }
////                var elvString = ""
//                for lift in self.lifts {
//                    if self.schedule.liftIds.contains(lift.liftId!) {
//                        elvString += lift.liftName! + ", "
//                    }
//                }
//                if elvString.count > 2 {
//                    elvString.removeLast()
//                    elvString.removeLast()
//                }
                cell?.updateData(titleText: "ELV\n(予約対象)", contentText: self.schedule.liftNames, tagView: TAG_ROW_ELV, isActive: self.isEditRow(tagRow: TAG_ROW_ELV), delegate: self, isShowAddLabel: true, isForce: !isEventMode)
                return cell!
                
            }else if(indexPath.row == 3){
                var cell = tableView.dequeueReusableCell(withIdentifier: "CategoryViewCell") as? CategoryViewCell
                if (cell == nil) {
                    cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "CategoryViewCell") as? CategoryViewCell
                }
                cell?.updateData(checkItem: self.schedule.categoryId, isActive: self.isEditRow(tagRow: TAG_ROW_CATEGORY), delegate: self)
                
                return cell!
            } else if(indexPath.row == 4){
                var cell = tableView.dequeueReusableCell(withIdentifier: "InfoOneLabelViewCell") as? InfoOneLabelViewCell
                if (cell == nil) {
                    cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "InfoOneLabelViewCell") as? InfoOneLabelViewCell
                }
                var goodString = ""
                for good in self.schedule.goods {
                    goodString += good.goodName! + ", "
                }
                cell?.updateData(titleText: "資材名", contentText: goodString, tagView: TAG_ROW_GOOD, isActive: self.isEditRow(tagRow: TAG_ROW_GOOD), delegate: self, isShowAddLabel: true, isForce: !isEventMode)
                return cell!
            }else if(indexPath.row == 5){
                var cell = tableView.dequeueReusableCell(withIdentifier: "InfoOneTextFieldViewCell") as? InfoOneTextFieldViewCell
                if (cell == nil) {
                    cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "InfoOneTextFieldViewCell") as? InfoOneTextFieldViewCell
                }
                var gateString = ""
                if(self.schedule.gate != nil && self.schedule.gate != -1){
                    gateString = self.schedule.gate.description
                }
                cell?.updateData(titleText: "入出ゲート", contentText: gateString, tagView: TAG_ROW_GATE, isActive: self.isEditRow(tagRow: TAG_ROW_GATE), delegate: self, isForce: false)
                return cell!
            }else if(indexPath.row == 6){
                var cell = tableView.dequeueReusableCell(withIdentifier: "FromTo3ViewCell") as? FromTo3ViewCell
                if (cell == nil) {
                    cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "FromTo3ViewCell") as? FromTo3ViewCell
                }
                
                cell?.updateDataForFloor(titleText: "揚重元(1)-先(3)", contentTextFrom: self.schedule.departure ?? "", contentTextTo: self.schedule.arrival ?? "",
                                         contentTextTo2: self.schedule.arrival2 ?? "",
                                         contentTextTo3: self.schedule.arrival3 ?? "",
                                         textAlignment: .center, tagView: TAG_ROW_TO3, isActive: self.isEditRow(tagRow: TAG_ROW_TO), delegate: self, isForce: !isEventMode)
                
                /*
                cell?.updateDataForFloor(titleText: "揚重元(1)-先(3)", contentTextFrom: self.schedule.departure ?? "", contentTextTo: self.schedule.arrival ?? "",
                contentTextTo2: self.schedule.arrival2 ?? "",
                contentTextTo3: self.schedule.arrival3 ?? "",
                textAlignment: .center, tagView: TAG_ROW_TO3, isActive: true, delegate: self, isForce: !isEventMode)
                */
                
                return cell!
                
            }else if(indexPath.row == 7){
                var cell = tableView.dequeueReusableCell(withIdentifier: "InfoOneTextFieldViewCell") as? InfoOneTextFieldViewCell
                if (cell == nil) {
                    cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "InfoOneTextFieldViewCell") as? InfoOneTextFieldViewCell
                }
                var timesString = ""
                if self.schedule.times != nil && self.schedule.times >= 0{
                    timesString = String(self.schedule.times)
                }
                cell?.updateData(titleText: "予測揚重回数", contentText: timesString, tagView: TAG_ROW_TIME, isActive: self.isEditRow(tagRow: TAG_ROW_TIME), delegate: self, isForce: !isEventMode)
                return cell!
            }else if(indexPath.row == 8){
                var cell = tableView.dequeueReusableCell(withIdentifier: "InfoOneLabelViewCell") as? InfoOneLabelViewCell
                if (cell == nil) {
                    cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "InfoOneLabelViewCell") as? InfoOneLabelViewCell
                }
                var vehicleString = ""
                for vehicle in self.schedule.vehicles {
                    if vehicle.number > 0{
                        vehicleString += vehicle.value + "x" + String(vehicle.number) + ","
                    }
                }
                if vehicleString.count > 0 {
                    vehicleString.removeLast()
                }
                cell?.updateData(titleText: "輸送車両", contentText: vehicleString, tagView: TAG_ROW_VERHICLE, isActive: self.isEditRow(tagRow: TAG_ROW_VERHICLE), delegate: self, isShowAddLabel: true, isForce: false)
                return cell!
               
            }else if indexPath.row == 9{
                var cell = tableView.dequeueReusableCell(withIdentifier: "PackingViewCell") as? PackingViewCell
                if (cell == nil) {
                    cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "PackingViewCell") as? PackingViewCell
                }
                cell?.updateData(packings: self.packings, isActive: self.isEditRow(tagRow: TAG_ROW_PACKING), delegate: self, isForce: !isEventMode)
                return cell!
            } else if indexPath.row == 10{
                var cell = tableView.dequeueReusableCell(withIdentifier: "ForkliftViewCell") as? ForkliftViewCell
                if (cell == nil) {
                    cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "ForkliftViewCell") as? ForkliftViewCell
                }
                cell?.updateData(state: self.schedule.isForkLift, isActive: self.isEditRow(tagRow: TAG_ROW_IS_FORK_LIFT), delegate: self, isForce: !isEventMode)
                return cell!
            } else if indexPath.row == 11{
                var cell = tableView.dequeueReusableCell(withIdentifier: "MessageViewCell") as? MessageViewCell
                if (cell == nil) {
                    cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "MessageViewCell") as? MessageViewCell
                }
                if self.isEventMode {
                    cell?.titleLabel.text = "行事内容\n申し送り\nその他"
                }else {
                    cell?.titleLabel.text = "申し送り"
                }
                cell?.textContent.delegate = self
                cell?.setActive(isActive: self.isEditRow(tagRow: TAG_ROW_NOTE))
                cell?.textContent.text = self.schedule.note
                return cell!
            } else if indexPath.row == 12{
                var cell = tableView.dequeueReusableCell(withIdentifier: "CameraViewCell") as? CameraViewCell
                if (cell == nil) {
                    cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "CameraViewCell") as? CameraViewCell
                }
                cell?.setActive(isActive: self.isEditRow(tagRow: TAG_ROW_CAMERA))
                cell?.delegate = self
                
                if self.imageData != nil {
                    cell?.imgContent.isHidden = false
                    cell?.imgContent.image = UIImage(data: self.imageData)
                    if tableId == 0 {
                        cell?.btDelete.isHidden = self.isConfirm
                    }else {
                        cell?.btDelete.isHidden = true
                    }
                    
                }else {
                    cell?.imgContent.isHidden = true
                    cell?.btDelete.isHidden = true
                }
                return cell!
            }else if indexPath.row == 13 {
                
                var cell = tableView.dequeueReusableCell(withIdentifier: "InfoOneLabelViewCell") as? InfoOneLabelViewCell
                if (cell == nil) {
                    cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "InfoOneLabelViewCell") as? InfoOneLabelViewCell
                }
                var statusString = ""
                if self.schedule.statusString != nil {
                    statusString = self.schedule.statusString
                }
                cell?.updateData(titleText: "申請状況", contentText: statusString, tagView: TAG_ROW_STATUS, isActive: false, delegate: self, isShowAddLabel: false, isForce: false)
                return cell!
            }else if indexPath.row == 14{
                var cell = tableView.dequeueReusableCell(withIdentifier: "OwnerViewCell") as? OwnerViewCell
                if (cell == nil) {
                    cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "OwnerViewCell") as? OwnerViewCell
                }
    //            cell?.contentView.backgroundColor = AT_COLOR_TITLE_INPUT_PERFORMACE
                cell?.titleLabel.text = "作成者"
                if self.schedule.createUserName != nil && self.schedule.createDateStr != nil{
                    cell?.contentLabel.text = self.schedule.createUserName + " (" + self.schedule.createDateStr + ")"
                }else {
                    cell?.contentLabel.text = ""
                }
                return cell!
            }else {
                var cell = tableView.dequeueReusableCell(withIdentifier: "OwnerViewCell") as? OwnerViewCell
                if (cell == nil) {
                    cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "OwnerViewCell") as? OwnerViewCell
                }
                if self.schedule.updateUserName != nil && self.schedule.updateDateStr != nil{
                    cell?.contentLabel.text = self.schedule.updateUserName + " (" + self.schedule.updateDateStr + ")"
                }else {
                    cell?.contentLabel.text = ""
                }
                cell?.titleLabel.text = "最終更新者"
                return cell!
            }
        }else if self.tableId == 0{
            var cell = tableView.dequeueReusableCell(withIdentifier: "ButtonViewCell") as? ButtonViewCell
            if (cell == nil) {
                cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "ButtonViewCell") as? ButtonViewCell
            }
            let isActive = self.checkFillData()
            cell?.updateStateButton(state: self.stateControler, isActiveConfirmBT: isActive)
            cell?.delegate = self
            return cell!
        }else {
            var cell = tableView.dequeueReusableCell(withIdentifier: "ButtonEditViewCell") as? ButtonEditViewCell
            if (cell == nil) {
                cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "ButtonEditViewCell") as? ButtonEditViewCell
            }
            cell?.delegate = self
            let isActive = self.checkFillData()
            cell?.updateButtonView(stateView: self.stateControler, isActiveConfirmBT: isActive)
            return cell!
        }
        
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       tableView.deselectRow(at: indexPath, animated: false)
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.section == 0 && indexPath.row == 0) || (indexPath.section == 2 && indexPath.row == 9) || (indexPath.section == 2 && indexPath.row == 12){
            return UITableViewAutomaticDimension
        }else if(indexPath.row == 11){
            return 120
        }else if(indexPath.row == 14 || indexPath.row == 15){
            return 30
        }else {
            return 50
        }
    }
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.tag == TAG_ROW_GATE {
            if range.location >= 2 {
                return false
            }
        }else if textField.tag == TAG_ROW_TIME {
            if range.location >= 2 {
                 return false
            }
        }
        return true
    }
    
    public func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        tableView.reloadData()
        return true
    }
    func takeImage(){
        self.view.endEditing(true)
        let pickerView = UIImagePickerController.init()
        let alertControl = UIAlertController.init(title: NSLocalizedString("画像を選択", comment: ""), message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        let cancelAction = UIAlertAction.init(title: NSLocalizedString("キャンセル", comment: ""), style: UIAlertActionStyle.cancel, handler: nil)
        alertControl.removeFromParentViewController()
        alertControl.addAction(cancelAction)
        
        let cameraAction = UIAlertAction.init(title: NSLocalizedString("カメラ", comment: ""), style: UIAlertActionStyle.default){
            (alert: UIAlertAction!) in
            if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)){
                pickerView.allowsEditing = false
                pickerView.delegate = self
                pickerView.sourceType = UIImagePickerControllerSourceType.camera
                self.present(pickerView, animated: false, completion: nil)
            }else{
                self.showMessage(messages: NSLocalizedString("tr_error_camera_is_unavailable", comment: ""))
            }
        }
        
        alertControl.addAction(cameraAction)
        let galleryAction = UIAlertAction.init(title: NSLocalizedString("ギャラリー", comment: ""), style: UIAlertActionStyle.default){
            
            UIAlertAction in
            pickerView.sourceType = UIImagePickerControllerSourceType.photoLibrary
            pickerView.delegate = self
            self.present(pickerView, animated: false, completion: nil)
        }
        
        alertControl.addAction(galleryAction)
        self.present(alertControl, animated: true, completion: nil)
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: {() -> Void in
            
            if let image = info[UIImagePickerControllerOriginalImage] as? UIImage
                ,let imageData = UIImageJPEGRepresentation(image, 1){
                self.imageData = imageData
                self.tableView.reloadData()
            }
        })
    }

    //delegate
    
    //infoTopViewCellDelegate
    func tapSwitch(state: Bool) {
        
        var message = NSLocalizedString("confirm_change_schedule_mode_form_normal_to_event", comment: "")
        if self.isEventMode {
            message = NSLocalizedString("confirm_change_schedule_mode_form_event_to_normal", comment: "")
        }
        self.confirmMessages(messages: message, funcOK: changeModeSchedule)
    }
    
    func changeModeSchedule(){
        self.isEventMode = !self.isEventMode
        self.timeRequire = ""
        self.schedule.liftIds = [Int]()
        if !self.isCustomerApp && self.tableId == 0 {
            self.schedule.customer = ATCustomerModel.init()
        }
        if isEventMode == true {
            Title = TRFormatUtil.formatDateCustom(date: self.currentDate, format: "yyyy年M月d日 行事申請フォーム")
        } else {
            Title = TRFormatUtil.formatDateCustom(date: self.currentDate, format: "yyyy年M月d日 申請フォーム")
        }
        self.navigationItem.title = Title
        self.schedule.goods = [ATGoodModel]()
        self.schedule.endDate = self.schedule.startDate
        self.schedule.startTimeHour = ""
        self.schedule.startTimeMin = ""
        self.schedule.endTimeHour = ""
        self.schedule.endTimeMin = ""
        self.schedule.gate = -1
        self.schedule.times = -1
        self.schedule.departure = ""
        self.schedule.arrival = ""
        self.schedule.categoryId = 0
        self.packings = [Int]()
        self.schedule.vehicles = [VehicleModel]()
        self.schedule.isForkLift = -1
        self.schedule.note = ""
        self.imageData = nil
        self.tableView.reloadData()
    }
    
    func tapTopViewCreaterInfo() {
        let vc = ATCreaterViewerController.init(nibName: ATCreaterViewerController.className, bundle: Bundle.init(for: ATCreaterViewerController.self))
        vc.createrSchedule = self.schedule.createUserModel
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    //infoOneLabelViewCellDelegate
    func tapContentForInfoOneLabel(tagView: Int) {
        switch tagView {
        case TAG_ROW_STARTDATE, TAG_ROW_ENDDATE:
            let vc = ATDatePickerController.init(nibName: ATDatePickerController.className, bundle: Bundle.init(for: ATDatePickerController.self))
            vc.delegate = self
            if tagView == TAG_ROW_ENDDATE {
                if self.schedule.endDate != nil && (self.schedule.endDate?.count)! > 0 {
                    vc.date = TRDateUtil.makeDateCustom(date: self.schedule.endDate!, format: "yyyy/MM/dd")
                }
            } else {
                if self.schedule.startDate != nil && (self.schedule.startDate?.count)! > 0 {
                    vc.date = TRDateUtil.makeDateCustom(date: self.schedule.startDate!, format: "yyyy/MM/dd")
                }
            }
            
            vc.tagView = tagView
            vc.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
            vc.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.present(vc, animated: true, completion: nil)
            
            break
        case TAG_ROW_ELV:
            let vc = ELVSelectionController.init(nibName: ELVSelectionController.className, bundle: Bundle.init(for: ELVSelectionController.self))
            vc.delegate = self
            vc.elvList = self.lifts
            vc.elvIdChose = self.schedule.liftIds
            vc.isEventMode = self.isEventMode
            vc.currentDate = self.currentDate
            vc.Title = self.Title
            self.navigationController?.pushViewController(vc, animated: false)
            break
            
        case TAG_ROW_GOOD:
            var customerId = "0"
            if isCustomerApp {
                customerId = ATUserDefaults.getCustomerId()
            }else {
                if self.schedule.customer == nil || self.schedule.customer.customerId == nil || self.schedule.customer.customerId! < 1 {
                    self.showMessage(messages: "業者を選択して下さい。")
                    break
                }else {
                    customerId = String(self.schedule.customer.customerId!)
                }
            }
            let vc = LiftMaterialSelectionController.init(nibName: LiftMaterialSelectionController.className, bundle: Bundle.init(for: LiftMaterialSelectionController.self))
            vc.delegate = self
            vc.liftMaterialChosed = self.schedule.goods
            vc.currentDate = self.currentDate
            vc.customerId = customerId
            vc.isCustomerApp = self.isCustomerApp
            vc.Tile = Title
            self.navigationController?.pushViewController(vc, animated: false)
            break
        case TAG_ROW_VERHICLE:
            let vc = TransportVehicleController.init(nibName: TransportVehicleController.className, bundle: Bundle.init(for: TransportVehicleController.self))
            vc.delegate = self
            vc.setData(vehicles: self.vehicles, vehicleChose: self.schedule.vehicles)
            vc.currentDate = self.currentDate
            vc.texttitle = Title
            self.navigationController?.pushViewController(vc, animated: false)
            break
        case TAG_ROW_CUSTOMER:
            let vc = ATChoseCustomerController.init(nibName: ATChoseCustomerController.className, bundle: Bundle.init(for: ATChoseCustomerController.self))
            vc.delegate = self
            vc.customer = self.schedule.customer
            vc.currentDate = self.currentDate
            vc.Title = Title
            self.navigationController?.pushViewController(vc, animated: false)
            break
        default:
            break
        }
        tableView.reloadData()
    }
    
    public func donePickerView(pickerView: ATTimePickerView, hourSelected: String, minSelected: String) {
        if pickerView.tag == TAG_ROW_START_TIME {
            self.schedule.startTimeHour = hourSelected
            self.schedule.startTimeMin = minSelected
            if(self.schedule.endTimeMin != nil && self.schedule.endTimeMin!.count > 0){
                self.timeRequire = self.caculateExpectedTime(startH: self.schedule.startTimeHour, startM: self.schedule.startTimeMin, endH: self.schedule.endTimeHour, endM: self.schedule.endTimeMin)
            }
        }else if pickerView.tag == TAG_ROW_END_TIME {
            self.schedule.endTimeHour = hourSelected
            self.schedule.endTimeMin = minSelected
            if(self.schedule.startTimeHour != nil && self.schedule.startTimeHour.count > 0){
                self.timeRequire = self.caculateExpectedTime(startH: self.schedule.startTimeHour, startM: self.schedule.startTimeMin, endH: self.schedule.endTimeHour, endM: self.schedule.endTimeMin)
            }
        }
        self.tableView.reloadData()
    }
    
    public func doneMonthPickerView(pickerView: TRDatePickerView) {
        
        switch pickerView.tag {
        case TAG_ROW_ENDDATE:
            self.schedule.endDate = TRFormatUtil.formatDateCustom(date: pickerView.date!, format: "yyyy/MM/dd")
            break
            
        default:
            break
        }
        
        self.tableView.reloadData()
    }
    
    func tapContentFromTo(isFrom: Bool, tag: Int) {
        if(tag == TAG_ROW_START_TIME){
            
            if(timePickerView == nil){
                timePickerView = ATTimePickerView.init()
                timePickerView?.delegate = self
            }
            var currentH = 0
            var currentM = 0
            if isFrom {
                self.timePickerView.tag = TAG_ROW_START_TIME
                if self.schedule.startTimeHour != nil && self.schedule.startTimeHour.count > 0 {
                    currentH = Int(self.schedule.startTimeHour)!
                    currentM = Int(self.schedule.startTimeMin)!
                }
            } else {
                self.timePickerView.tag = TAG_ROW_END_TIME
                if self.schedule.endTimeHour != nil && self.schedule.endTimeHour.count > 0 {
                    currentH = Int(self.schedule.endTimeHour)!
                    currentM = Int(self.schedule.endTimeMin)!
                }
            }
            timePickerView.setData(hourAdd: 6, timeInterval: 15,currentHour: currentH, currentMin: currentM)
            timePickerView?.show()
            
        }else if tag == TAG_ROW_FROM{
            let vc = FloorSelectionController.init(nibName: FloorSelectionController.className, bundle: Bundle.init(for: FloorSelectionController.self))
            vc.delegate = self
            vc.floors = self.floors
            if isFrom {
                vc.tag = TAG_ROW_FROM
                vc.floorChosed = self.schedule.departure
                //vc.floorChosed[0] = self.schedule.departure as! String
            }else {
                vc.tag = TAG_ROW_TO
                vc.floorChosed = self.schedule.departure
                //vc.floorChosed[0] = self.schedule.departure as! String
            }
            vc.currentDate = self.currentDate
            vc.Title = Title
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }
    
    
    func tapContentFromTo3(floor: Floor, tag: Int) {
        let vc = FloorSelectionController.init(nibName: FloorSelectionController.className, bundle: Bundle.init(for: FloorSelectionController.self))
        vc.delegate = self
        vc.floors = self.floors
        
        switch floor {
        case .From:
            vc.tag = TAG_ROW_FROM
            vc.floorChosed = self.schedule.departure
        case .To:
            vc.tag = TAG_ROW_TO
            vc.floorChosed = self.schedule.arrival
        case .To2:
            vc.tag = TAG_ROW_TO2
            vc.floorChosed = self.schedule.arrival2
        case .To3:
            vc.tag = TAG_ROW_TO3
            vc.floorChosed = self.schedule.arrival3
        }
        
        vc.currentDate = self.currentDate
        vc.Title = Title
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    func tapCameraViewCell(isTitleTap: Bool) {
        if isTitleTap {
            self.takeImage()
        }else {
            if self.imageData != nil {
                let vc = ATImageDetailViewController.init(nibName: ATImageDetailViewController.className, bundle: Bundle.init(for: ATImageDetailViewController.self))
                
                vc.imageData = self.imageData
                vc.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
                vc.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                self.present(vc, animated: true, completion: nil)
                
            }
        }
    }
    
    func tapCameraViewCellDeleteImage() {
        self.imageData = nil
        self.tableView.reloadData()
    }
    
    func doneChoseDate(datePickerConstroller: ATDatePickerController, date: Date) {
        if datePickerConstroller.tagView == TAG_ROW_ENDDATE {
            self.schedule.endDate = TRFormatUtil.formatDateCustom(date: date, format: "yyyy/MM/dd")
        }else if datePickerConstroller.tagView == TAG_ROW_STARTDATE {
            self.schedule.startDate = TRFormatUtil.formatDateCustom(date: date, format: "yyyy/MM/dd")
        }
        self.tableView.reloadData()
    }
    func doneChoseCategoryCel(indexChose: Int) {
        self.schedule.categoryId = indexChose
        tableView.reloadData()
    }
    
    func doneELVSelection(liftIds: [Int]) {
        self.schedule.liftIds = liftIds
        var elvString = ""
        for lift in self.lifts {
            if self.schedule.liftIds.contains(lift.liftId!) {
                elvString += lift.liftName! + ", "
            }
        }
        if elvString.count > 2 {
            elvString.removeLast()
            elvString.removeLast()
        }
        self.schedule.liftNames = elvString;
        self.tableView.reloadData()
    }
    
    func doneLiftMaterialSelection(liftMaterials: [ATGoodModel]) {
        self.schedule.goods = liftMaterials
    }
    /*
    func doneFloorSelectionControllerDelegate(floor: String, tag: Int) {
        if tag == TAG_ROW_FROM {
            self.schedule.departure = floor
        }else {
            self.schedule.arrival = floor
        }
    }
    */
    func doneFloorSelectionControllerDelegate(floor: String, tag: Int) {
        switch tag {
        case TAG_ROW_FROM:
            self.schedule.departure = floor
        case TAG_ROW_TO:
            self.schedule.arrival = floor
        case TAG_ROW_TO2:
            self.schedule.arrival2 = floor
        case TAG_ROW_TO3:
            self.schedule.arrival3 = floor
        default:
            break
        }
    }
    
    func doneChoseTransport(Vehicles: [VehicleModel]) {
        self.schedule.vehicles = Vehicles
    }
    
    func doneChoseCustomer(customer: ATCustomerModel) {
        self.schedule.customer = customer
        self.schedule.goods = [ATGoodModel]()
    }
    
    func tapButton(state: Int) {
        self.view.endEditing(true)
        switch state {
        case AT_SCHEDULE_NEW_CONFIRM:
            self.validateUpdateSchedule(nextStatus: AT_SCHEDULE_NEW_CONFIRM)
            break
        case AT_SCHEDULE_NEW_CONFIRM_OK:
            if isCustomerApp {
                updateSchedule()
            }else {
                updateScheduleWarning()
            }
            break
        case AT_SCHEDULE_NEW_CREATE:
            self.isConfirm = false
            self.stateControler = state
            
            self.tableView.reloadData()
            break
            
        case AT_SCHEDULE_DETAIL_VIEW:
            self.navigationController?.navigationBar.barTintColor = UIColor.orange
            self.timeRequire = ""
            self.schedule.liftIds = [Int]()
            if !self.isCustomerApp && self.tableId == 0 {
                self.schedule.customer = ATCustomerModel.init()
            }
            self.schedule.goods = [ATGoodModel]()
            self.schedule.endDate = self.schedule.startDate
            self.schedule.startTimeHour = ""
            self.schedule.startTimeMin = ""
            self.schedule.endTimeHour = ""
            self.schedule.endTimeMin = ""
            self.schedule.gate = -1
            self.schedule.times = -1
            self.schedule.departure = ""
            self.schedule.arrival = ""
            self.schedule.categoryId = 0
            self.packings = [Int]()
            self.schedule.vehicles = [VehicleModel]()
            self.schedule.isForkLift = -1
            self.schedule.note = ""
            self.imageData = nil
            loadScheduleDetail()
            self.isConfirm = true
            self.stateControler = state
            self.tableView.reloadData()
            break
        case AT_SCHEDULE_DETAIL_EDIT:
            self.navigationController?.navigationBar.barTintColor = UIColor.red
            self.isConfirm = false
            self.stateControler = state
            self.tableView.reloadData()
            break
        case AT_SCHEDULE_DETAIL_CONFIRM:
            self.validateUpdateSchedule(nextStatus: AT_SCHEDULE_DETAIL_CONFIRM)
            break
            
        case AT_SCHEDULE_DETAIL_CONFIRM_OK:
            if isCustomerApp {
                updateSchedule()
            }else {
                updateScheduleWarning()
            }
            break
        case AT_SCHEDULE_DETAIL_DELETE:
            self.confirmMessages(messages: NSLocalizedString("confirm_delete_schedule", comment: ""), funcOK: self.deleteSchedule)
            break
            
        default:
            break
        }
    }
    
    public func textViewDidEndEditing(_ textView: UITextView) {
        self.schedule.note = textView.text
        self.animateView(isUp: false)
    }
    
    public func textViewDidBeginEditing(_ textView: UITextView) {
        self.animateView(isUp: true)
        self.tableView.scrollToRow(at: IndexPath.init(row: 11, section: 2), at: .top, animated: false)
    }
    public func textFieldDidEndEditing(_ textField: UITextField) {
        if(textField.text?.isEmpty)!{
            textField.backgroundColor = AT_COLOR_WHITE
        }
        if textField.tag == TAG_ROW_GATE {
            self.schedule.gate = Int(textField.text!)
        } else {
            self.schedule.times = Int(textField.text!)
        }
        tableView.reloadData()
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.tag == TAG_ROW_GATE {
            self.tableView.scrollToRow(at: IndexPath.init(row: 5, section: 2), at: .middle, animated: false)
        } else {
            self.tableView.scrollToRow(at: IndexPath.init(row: 7, section: 2), at: .middle, animated: false)
        }
    }
    
    func changeStageForklift(state: Int) {
        self.schedule.isForkLift = state
        tableView.reloadData()
    }
    
    func changeStatePacking(state: [Int]) {
        self.packings = state
        tableView.reloadData()
    }
    
    func caculateExpectedTime(startH: String,startM: String, endH: String, endM: String) -> String{
        let result = Int(endH)!*60 + Int(endM)! - Int(startH)!*60 - Int(startM)!
            
        if result > 0 {
            var hour = String(result / 60)
            var min =   String(result % 60)
            if hour.count == 1 { hour = "0" + hour}
            if min.count == 1 {min = "0" + min}
            return hour + ":" + min
        }
        return "00:00"
    }
    
    func convertArrayIntToString(list : [Int], split:String) -> String {
        var result = ""
        for item in list {
            result += String(item) + split
        }
        return result
    }
}

