//
//  LWPerformanceDetailViewController.swift
//  LiftWork
//
//  Created by CuongNV on 6/1/18.
//  Copyright © 2018 Trente. All rights reserved.
//

import UIKit
import TrenteCoreSwift
import ObjectMapper

class LWPerformanceDetailViewController2: LWBaseViewController , LWViewBase35Delegate, TRPickerViewDelegate,  LWLiftMaterialRowviewDelegate, LWChoseCustomerViewDelegate, LWBasicInformationViewDelegate, LWLiftMaterialSelectViewControllerDelegate3, LWViewBaseDelegate, LWPeopleRubbishRowDelegate, LWViewOneLabelDelegate, TRDatePickerViewDelegate,MainStoryboard, LWChoseConstructionViewDelegate, KeyboardDelegate, UITextFieldDelegate, LWChoseFloorDelegate, LWChoseManyFloorDelegate{
    
    
   
    let TEXT_FIELD_TAG_UNIT = 0;
    let TEXT_FIELD_TAG_TIMES = 1;
    
    @IBOutlet weak var titleRow: LWBasicInformationView!
    @IBOutlet weak var elvRowView: LWViewBase11!
    @IBOutlet weak var operatorRowView: LWViewBase11!
    @IBOutlet weak var titleTableRow: LWViewOneLabel!
    @IBOutlet weak var customerRowView: LWViewBase!
    @IBOutlet weak var liftMaterialRowView: LWLiftMaterialRowView!
    @IBOutlet weak var peopleRubbishRowView: LWPeopleRubbishRowView!
    @IBOutlet weak var timeRowView: LWTimeRowView!
    @IBOutlet weak var btConfirm: LWRoundedBlueDarkButton!
    @IBOutlet weak var viewbottom: UIView!
    @IBOutlet weak var btBackToInput: LWRoundedBlueDarkButton!
    
    @IBOutlet weak var btnPrevView: UIView!
    @IBOutlet weak var btnNextView: UIView!
    @IBOutlet weak var nextLabel: LWnormalBoldLabel!
    
    @IBOutlet weak var prevLabel: LWnormalBoldLabel!
    
    var stateTabbar: String?  = LW_TABBAR_PERFORMANCE_INPUT
    var stateController: String? = LW_PERFORMANCE_INPUT_STATUS_CREATE_NEW
    var contructionID:Int?
    //    internal var construction: LWConstructionModel?
    var elvList = [LWLiftModel]()
    var operatorList = [LWOperatorModel]()
    var roomList = [String]()
    var requestPicker: TRPickerView?
    var datePickerView: TRDatePickerView?
    var inputNumberPad: NumberPadView?
    var txfEditing: UITextField?
    var requestPickerState: String?
    var customers = [LWCustomerModel]()
    var goods = [LWGoodModel]()
    var dateString: String? = ""
    var timeString: String? = ""
    var timer = Timer()
    var previousLiftUsageId: Int?
    var nextLiftUsageId: Int?
    var currentId: Int?
    var contruction : LWConstructionModel?
//    var TypeisSelected = [true,false,false,false]
//    var NameOfTypeisSelected:String?
   
    
    
   
    let Equipment = 1
    let Architect = 2
    var liftUsage: LWLiftUsageModel2?
    var liftUsageTemp: LWLiftUsageModel2?
    var liftUsageShow: LWLiftUsageModel2?
    var isFirstLoad: Bool = true
    var searchWorkerId: String?
    var searchLiftId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextLabel.transform = CGAffineTransform.init(rotationAngle:CGFloat(Double.pi/2))
        nextLabel.text = NSLocalizedString("lw_character_next", comment: "")
        prevLabel.transform = CGAffineTransform.init(rotationAngle:CGFloat(-Double.pi/2))
        prevLabel.text = NSLocalizedString("lw_character_back", comment: "")
        
        initView()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(showCurrentDateTime), userInfo: nil, repeats: true)
        
        NotificationCenter.default.addObserver(self, selector: #selector(didDoubleTap), name: NSNotification.Name.init(LW_NOTIFICATION_DOUBLE_TAP_ON_TABBAR), object: nil)
        
//        self.btnNextView.isHidden = true
//        self.btnPrevView.isHidden = true
//
        let pickerViewHeight = self.view.frame.size.height/4
        self.inputNumberPad = NumberPadView.init(frame: CGRect(x: self.view.frame.origin.x, y: self.view.frame.origin.y + self.view.frame.size.height - pickerViewHeight, width: self.view.frame.size.width, height: pickerViewHeight))
        self.inputNumberPad?.delegate = self
        
    }
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.init(LW_NOTIFICATION_DOUBLE_TAP_ON_TABBAR), object: nil)
    }
    
    @objc func didDoubleTap(notification:Notification){
        print("didDoubleTap")
        guard  stateController != LW_PERFORMANCE_INPUT_STATUS_CREATE_NEW && stateController != LW_PERFORMANCE_INPUT_STATUS_CONFIRM_NEW else{
            return
        }
        guard stateController != LW_PERFORMANCE_INPUT_STATUS_MODIFY && stateController != LW_PERFORMANCE_INPUT_STATUS_CONFIRM else{
            return
        }
        loadPerformance(siteId: self.liftUsage?.constructionSite?.key, tableId: 0)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if LWUserDefaults.getConstructionId().isEmpty, let vc = ConstructionSelectViewController.createInstanceFromStoryboard() as? ConstructionSelectViewController{
            vc.index = 0
            self.navigationController?.pushViewController(vc, animated: false)
        }else{
            setStateController(state: self.stateController!)
            if(isFirstLoad){
                isFirstLoad = false
                if(self.stateTabbar != LW_TABBAR_PERFORMANCE_CONFIRM){
                    self.liftUsage = LWLiftUsageModel2.init()
                    self.liftUsage?.constructionSite = LWConstructionModel.init()
                    self.liftUsage?.constructionSite?.key = Int(LWUserDefaults.getConstructionId())
                    self.liftUsage?.constructionSite?.constructionName = LWUserDefaults.getConstructionName()
                    loadPerformance(siteId:self.liftUsage?.constructionSite?.key, tableId: 0)
                }else {
                    loadPerformance(siteId: self.liftUsage?.constructionSite?.key, tableId: self.liftUsage?.key)
                }
                
            }
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if(self.stateController == LW_PERFORMANCE_INPUT_STATUS_SHOW || self.stateController == LW_PERFORMANCE_INPUT_STATUS_CREATE_NEW){
            updateBackNextButtonState()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @IBAction func tapBackButton(_ sender: Any) {
        self.btnPrevView.isHidden = true
        if(stateController == LW_PERFORMANCE_INPUT_STATUS_CREATE_NEW){
            self.liftUsageTemp = self.liftUsage
            self.setStateController(state: LW_PERFORMANCE_INPUT_STATUS_SHOW)
        }
        self.currentId = 0 - (self.liftUsage?.key)!
        loadPerformance(siteId: self.liftUsage?.constructionSite?.key, tableId: self.previousLiftUsageId)
    }
    
    @IBAction func tapButtonBackToInput(_ sender: Any) {
        switch self.stateController {
        case LW_PERFORMANCE_INPUT_STATUS_SHOW?:
            self.navigationController?.popViewController(animated: false)
            break
        case LW_PERFORMANCE_INPUT_STATUS_MODIFY?:
            if(self.isEditedLiftUsage()){
                let alertController = UIAlertController.init(title: NSLocalizedString("lw_title_dialog_confirm_back", comment: ""), message: "", preferredStyle: .alert)
                let save = UIAlertAction.init(title: NSLocalizedString("lw_title_dialog_confirm_back_yes", comment: ""), style: .default, handler: { action in
                    self.updatePerformance()
                })
                let nor = UIAlertAction.init(title: NSLocalizedString("lw_title_dialog_confirm_back_no", comment: ""), style: .default, handler: { action in
                    self.setStateController(state: LW_PERFORMANCE_INPUT_STATUS_SHOW)
                    self.loadPerformance(siteId: self.liftUsage?.constructionSite?.key, tableId: self.liftUsage?.key)
                })
                
                alertController.addAction(save)
                alertController.addAction(nor)
                
                self.present(alertController, animated: true, completion: nil)
            }else {
                setStateController(state: LW_PERFORMANCE_INPUT_STATUS_SHOW)
                loadPerformance(siteId: self.liftUsage?.constructionSite?.key, tableId: self.liftUsage?.key)
            }
            break
        case LW_PERFORMANCE_INPUT_STATUS_CONFIRM?:
            setStateController(state: LW_PERFORMANCE_INPUT_STATUS_MODIFY)
            break
        case LW_PERFORMANCE_INPUT_STATUS_CONFIRM_NEW?:
            setStateController(state: LW_PERFORMANCE_INPUT_STATUS_CREATE_NEW)
            if self.previousLiftUsageId != 0{
                self.btnPrevView.isHidden = false
            }
            break
        default:
            break
        }
    }
    @IBAction func tapConfirmButton(_ sender: Any) {
        print("item  ")
        switch self.stateController {
        case LW_PERFORMANCE_INPUT_STATUS_SHOW?:
            self.liftUsageShow = LWLiftUsageModel2.init()
            self.liftUsageShow?.copyLiftUsage(liftUsage: self.liftUsage)
            setStateController(state: LW_PERFORMANCE_INPUT_STATUS_MODIFY)
            break
        case LW_PERFORMANCE_INPUT_STATUS_MODIFY?:
            //            setStateController(state: LW_PERFORMANCE_INPUT_STATUS_CONFIRM)
            CheckPerformance()
            break
        case LW_PERFORMANCE_INPUT_STATUS_CONFIRM?:
            updatePerformance()
            break
        case LW_PERFORMANCE_INPUT_STATUS_CREATE_NEW?:
            //            setStateController(state: LW_PERFORMANCE_INPUT_STATUS_CONFIRM_NEW)
            CheckPerformance()
            break
        case LW_PERFORMANCE_INPUT_STATUS_CONFIRM_NEW?:
            updatePerformance()
            break
        default:
            break
        }
    }
    
    @IBAction func tapNextButton(_ sender: Any) {
        self.btnNextView.isHidden = true
        self.currentId = self.liftUsage?.key
        
        if(self.nextLiftUsageId == 0 && self.liftUsageTemp != nil){
            loadPerformance(siteId: self.liftUsageTemp?.constructionSite?.key, tableId: 0)
        }else {
            loadPerformance(siteId: self.liftUsage?.constructionSite?.key, tableId: self.nextLiftUsageId)
        }
    }
    
    @objc func showCurrentDateTime(){
        let date = Date()
        let dateString = TRFormatUtil.formatDateCustom(date: date, format: "yyyy/MM/dd")
        let timeString = TRFormatUtil.formatDateCustom(date: date, format: "HH:mm:ss")
        self.titleRow.labDate.text = dateString
        self.titleRow.labTime.text = timeString
    }
    
    
    func initView(){
        
        self.elvRowView.labTitle.text = NSLocalizedString("lw_character_elv", comment: "")
        self.operatorRowView.labTitle.text = NSLocalizedString("lw_character_operator", comment: "")
        self.titleTableRow.labTitle.font = UIFont.boldSystemFont(ofSize: LW_FONT_SIZE_BIG)
        self.titleTableRow.labTitle.textColor = LW_COLOR_WHITE
        self.customerRowView.labTitle.text = NSLocalizedString("lw_character_customer", comment: "")
        
    }
    func updateData() {
        
        //header
        self.titleRow.labConstruction.text = self.liftUsage?.constructionSite?.constructionName
        if(self.stateController == LW_PERFORMANCE_INPUT_STATUS_CREATE_NEW || (self.liftUsage?.constructionSite != nil && self.liftUsage?.constructionSite?.status != 0)){
            self.titleRow.delegate = self
            self.titleRow.labConstruction.alpha = 1
            self.titleRow.isAbleTap = true
        }else {
            self.titleRow.labConstruction.alpha = 0.5
            self.titleRow.isAbleTap = true
        }
        
        //elv-operator
        if(self.stateController == LW_PERFORMANCE_INPUT_STATUS_CREATE_NEW || (self.liftUsage?.lift != nil && self.liftUsage?.lift?.status != 0)){
            self.elvRowView.delegate = self
            self.elvRowView.typeControl = LW_BASE_VIEW_35_TYPE_ELV
            self.elvRowView.alpha = 1
            self.elvRowView.isAbleTap = true
        }else {
            self.elvRowView.alpha = 0.5
            self.elvRowView.isAbleTap = false
        }
        if(self.stateController == LW_PERFORMANCE_INPUT_STATUS_CREATE_NEW || (self.liftUsage?.Operator != nil && self.liftUsage?.Operator?.status != 0)){
            self.operatorRowView.delegate = self
            self.operatorRowView.typeControl = LW_BASE_VIEW_35_TYPE_OPERATOR
            self.operatorRowView.alpha = 1
            self.operatorRowView.isAbleTap = true
        }else {
            self.operatorRowView.alpha = 0.5
            self.operatorRowView.isAbleTap = false
        }
        if(self.liftUsage != nil){
            self.elvRowView.labContent.text = self.liftUsage?.getElvName()
            self.operatorRowView.labContent.text = self.liftUsage?.getOperatorName()
        }
        //title
        self.titleTableRow.delegate = self
        self.titleTableRow.labTime.text = self.liftUsage?.getTime()
        //customer
        if(self.isDisableCustomerRow()){
            self.customerRowView.alpha = 0.5
            self.customerRowView.isAbleTap = false
        }else {
            self.customerRowView.delegate = self
            self.customerRowView.alpha = 1
            self.customerRowView.isAbleTap = true
        }
        
        if(self.liftUsage != nil){
            self.customerRowView.labContent.text = self.liftUsage?.getCustomerName()
        }
        //lift material
        if(self.liftUsage?.goodQuantity != 0){
            self.liftMaterialRowView.unitNumber.text = self.liftUsage?.goodQuantity?.description
        } else {
            self.liftMaterialRowView.unitNumber.text = ""
        }
        
        if(self.stateController == LW_PERFORMANCE_INPUT_STATUS_CREATE_NEW || (self.liftUsage?.good != nil && self.liftUsage?.good?.status != 0)){
            self.liftMaterialRowView.delegate = self
            self.liftMaterialRowView.contentLabel.alpha = 1
            self.liftMaterialRowView.isAbleTap = true
        }else {
            self.liftMaterialRowView.contentLabel.alpha = 0.5
            self.liftMaterialRowView.isAbleTap = false
        }
        
        self.liftMaterialRowView.contentLabel.text = self.liftUsage?.good?.goodName
         
        
        self.liftMaterialRowView.unitNumber.tag = TEXT_FIELD_TAG_UNIT
        self.liftMaterialRowView.unitNumber.delegate = self
        self.liftMaterialRowView.unitNumber.inputView = self.inputNumberPad
        self.liftMaterialRowView.unitNumber.inputAssistantItem.leadingBarButtonGroups = []
        self.liftMaterialRowView.unitNumber.inputAssistantItem.trailingBarButtonGroups = []
        
        self.liftMaterialRowView.updateFreeState(status: (self.liftUsage?.costStatus)!)
        //people rubish
        if(self.stateController == LW_PERFORMANCE_INPUT_STATUS_CREATE_NEW){
            self.peopleRubbishRowView.delegate = self
        }
        switch(self.liftUsage?.goodType){
        case LW_PEOPLE_RUBBISH_STATE_GOOD?:
            self.peopleRubbishRowView.switchAble.isOn = false
            self.customerRowView.setAlpha(alphaView: 1)
            self.liftMaterialRowView.setAlpha(alphaView: 1)
            self.peopleRubbishRowView.whenOffSwitch()
            break
        case LW_PEOPLE_RUBBISH_STATE_HUMAN?:
            self.peopleRubbishRowView.switchAble.isOn = true
            self.peopleRubbishRowView.whenTapPeople()
            self.peopleRubbishRowView.setContentAlpha(alpha: 1)
            chosePeople()
            break
        case LW_PEOPLE_RUBBISH_STATE_RUBBISH?:
            self.peopleRubbishRowView.switchAble.isOn = true
            self.peopleRubbishRowView.whenTapRubbish()
            self.peopleRubbishRowView.setContentAlpha(alpha: 1)
            choseRubbish()
            break
        default:
            break
        }
        //time - from - to
        self.timeRowView.delegate = self
        if(self.liftUsage?.times != 0){
            self.timeRowView.txFTime.text = self.liftUsage?.times?.description
        } else {
            self.timeRowView.txFTime.text = ""
        }
        self.timeRowView.labContentFrom.text = self.liftUsage?.departure
        self.timeRowView.labContentTo.text = self.liftUsage?.arrial
        self.timeRowView.txFTime.delegate = self
        self.timeRowView.txFTime.inputView = self.inputNumberPad
        self.timeRowView.txFTime.inputAssistantItem.leadingBarButtonGroups = []
        self.timeRowView.txFTime.inputAssistantItem.trailingBarButtonGroups = []
        self.timeRowView.txFTime.tag = TEXT_FIELD_TAG_TIMES
        if(self.stateController == LW_PERFORMANCE_INPUT_STATUS_SHOW || self.stateController == LW_PERFORMANCE_INPUT_STATUS_CREATE_NEW){
            updateBackNextButtonState()
        }
    }
    
    func isDisableCustomerRow() -> Bool{
        if(self.stateController != LW_PERFORMANCE_INPUT_STATUS_CREATE_NEW){
            if(self.liftUsage?.customer != nil && self.liftUsage?.customer?.customerId != 0 && self.liftUsage?.customer?.status == 0){
                return true
            }
            
            let goodId = self.liftUsage?.good?.goodId
            if(self.liftUsage?.good != nil && (goodId!) > 2 && self.liftUsage?.good?.status == 0){
                return true
            }
            
        }
            return false
    }
    
    func updateBackNextButtonState(){
        if(self.previousLiftUsageId != nil && self.previousLiftUsageId != 0){
            self.btnPrevView.isHidden = false
        }else {
            self.btnPrevView.isHidden = true
        }
        if((self.stateTabbar != LW_TABBAR_PERFORMANCE_CONFIRM && self.liftUsage?.key != 0 && self.liftUsage?.key != nil) || (self.stateTabbar == LW_TABBAR_PERFORMANCE_CONFIRM && self.nextLiftUsageId != 0 && self.nextLiftUsageId != nil)){
            self.btnNextView.isHidden = false
        }else {
            self.btnNextView.isHidden = true
        }
    }
    
    func isContainELV(lifts: [LWLiftModel], lift: LWLiftModel) -> Bool{
        for temp in lifts {
            if(temp.liftId == lift.liftId){
                return true
            }
        }
        return false
    }
    
    func isContainLiftMaterial(goods: [LWGoodModel], good: LWGoodModel) -> Bool{
        for temp in goods {
            if(temp.goodId == good.goodId){
                return true
            }
        }
        return false
    }
    
    func isContainOperator(operators: [LWOperatorModel], oper: LWOperatorModel) -> Bool{
        for temp in operators {
            if(temp.userId == oper.userId){
                return true
            }
        }
        return false
    }
    
    //call api
    func loadPerformance(siteId: Int?, tableId: Int?){
        self.btConfirm.isEnabled = false
        var params = LWParamUtil.initParamsLW()
        params["tableId"] = "\(tableId ?? 0)"
        params["siteId"] = "\(siteId ?? 0)"
        params["currentId"] = "\(currentId ?? 0)"
        if(tableId != 0 && self.liftUsage?.startTime != nil && !(self.liftUsage?.startTime?.isEmpty)!){
            let day = TRFormatUtil.formatDateCustom(date: self.liftUsage?.getDateCreate(), format: "yyyy/MM/dd")
            params["startTime"] = day + " 00:00"
            params["endTime"] = day + " 23:59"
        }else {
            let day = TRFormatUtil.formatDateCustom(date: Date(), format: "yyyy/MM/dd")
            params["startTime"] = day + " 00:00"
            params["endTime"] = day + " 23:59"
        }
        
        if(self.searchWorkerId != nil && !(self.searchWorkerId?.isEmpty)!){
            params["workerId"] = self.searchWorkerId
        }
        if(self.searchLiftId != nil && !(self.searchLiftId?.isEmpty)!){
            params["liftId"] = self.searchLiftId
        }
        
        if(self.stateTabbar == LW_TABBAR_PERFORMANCE_CONFIRM){
            params["isFilterBySite"] = "TRUE"
            params["isFilterByUser"] = "FALSE"
            params["isConfirmViewMode"] = "TRUE"
            
        }else {
            params["isFilterBySite"] = "FALSE"
            params["isFilterByUser"] = "TRUE"
            params["isConfirmViewMode"] = "FALSE"
        }
        AlamofireManager.shared.request(APIRouter.get(url: API.LW_URL_LIFT_USAGE_DETAIL, params: params, identifier: nil)) { (response) in
             self.btConfirm.isEnabled = true
            if response != nil{
                guard let liftUsageData = response!["liftUsage"] as? [String:Any],
                    let liftUsage:LWLiftUsageModel2 = Mapper<LWLiftUsageModel2>().map(JSON: liftUsageData),
                    let operatorList = Mapper<LWOperatorModel>().mapArray(JSONObject: response!["operators"]),
                    let elvList = Mapper<LWLiftModel>().mapArray(JSONObject: response!["lifts"]),
                    let customers = Mapper<LWCustomerModel>().mapArray(JSONObject: response!["customers"])
                    else{
                        return
                }
                self.liftUsage = liftUsage
                self.operatorList = operatorList
                self.elvList = []
                for lift in elvList{
                    if(lift.status != 0){
                        self.elvList.append(lift)
                    }
                }
                self.operatorList = []
                for oper in operatorList{
                    if(oper.status != 0){
                        self.operatorList.append(oper)
                    }
                }
                self.customers = []
                for customer in customers{
                    if(customer.customerId == self.liftUsage?.customer?.customerId){
                        self.liftUsage?.customer = customer
                    }
                    if(customer.status != 0){
                        self.customers.append(customer)
                    }
                }
                
                self.roomList.removeAll()
                if let floors = response?["floors"] as? [String]{
                    for floor in floors{
                        self.roomList.append(floor)
//                        let floorValue = floor.replacingOccurrences(of: "B", with: "-")
//                        if let floorInt = Int(floorValue){
//                            self.roomListValues.append(floorInt)
//                        }
                    }
                }
//                self.roomList.reverse()
//                self.roomListValues.reverse()
                
                self.previousLiftUsageId = response!["previousLiftUsageId"] as? Int
                self.nextLiftUsageId = response!["nextLiftUsageId"] as? Int
                
                if(self.stateTabbar != LW_TABBAR_PERFORMANCE_CONFIRM && self.liftUsage?.key == 0){
                    if(self.stateController == LW_PERFORMANCE_INPUT_STATUS_CREATE_NEW){
                        if(self.liftUsageTemp != nil){
                            self.liftUsage?.lift = self.liftUsageTemp?.lift
                            self.liftUsage?.Operator = self.liftUsageTemp?.Operator
                            self.liftUsage?.constructionSite = self.liftUsageTemp?.constructionSite
                        }
                        
                    }else {
                        self.liftUsage = self.liftUsageTemp
                        self.setStateController(state: LW_PERFORMANCE_INPUT_STATUS_CREATE_NEW)
                    }
                }
                if(self.liftUsage?.lift != nil && self.liftUsage?.lift?.liftId != 0 && self.liftUsage?.lift?.status == 1){
                    if(!(self.isContainELV(lifts: self.elvList, lift: (self.liftUsage?.lift)!))) {
                        self.liftUsage?.lift?.status = 0
                    }
                }
                
                if(self.liftUsage?.Operator != nil && self.liftUsage?.Operator?.userId != 0 && self.liftUsage?.Operator?.status == 1){
                    if(!(self.isContainOperator(operators: self.operatorList, oper: (self.liftUsage?.Operator)!))) {
                        self.liftUsage?.Operator?.status = 0
                    }
                }
                
                if(self.liftUsage?.customer != nil && self.liftUsage?.customer?.customerId != 0 && self.liftUsage?.good != nil && self.liftUsage?.good?.goodId != 0 && self.liftUsage?.good?.status == 1){
                    if(!((self.isContainLiftMaterial(goods: (self.liftUsage?.customer?.goods)!, good: (self.liftUsage?.good)!)))) {
                        self.liftUsage?.good?.status = 0
                    }
                }
                
                self.updateData()
            }
        }
    }
    
    func updatePerformance(){
        self.btConfirm.isEnabled = false
        var params = LWParamUtil.initParamsLW()
        params["tableId"] = self.liftUsage?.key?.description
        params["siteId"] = self.liftUsage?.constructionSite?.key?.description
        if(liftUsage?.lift != nil){
            params["liftId"] = self.liftUsage?.lift?.liftId?.description
        }
        if(liftUsage?.customer != nil){
            params["customerId"] = self.liftUsage?.customer?.customerId?.description
        }
        if(liftUsage?.Operator != nil){
            params["workerId"] = self.liftUsage?.Operator?.userId?.description
        }
        
        if(liftUsage?.good != nil){
            params["goodId"] = self.liftUsage?.good?.goodId?.description
        }

        
        params["goodType"] = self.liftUsage?.goodType?.description
        params["goodQuantity"] = self.liftUsage?.goodQuantity?.description
        params["times"] = self.liftUsage?.times?.description
        params["departure"] = self.liftUsage?.departure
        params["arrival"] = self.liftUsage?.arrial
        params["costStatus"] = self.liftUsage?.costStatus
        params["carryTypeName"] = self.liftUsage?.carryTypeName
        if(self.liftUsage?.startTime == nil || self.liftUsage?.key == 0){
            params["startTime"] = TRFormatUtil.formatDateCustom(date: Date(), format: "yyyy/MM/dd HH:mm")
        }else {
            params["startTime"] = self.liftUsage?.startTime
        }
        AlamofireManager.shared.request(APIRouter.post(url: API.LW_URL_LIFT_USAGE_UPDATE, params: params, identifier: nil)) { (response) in
            self.btConfirm.isEnabled = true
            if response != nil{
                if(self.stateTabbar == LW_TABBAR_PERFORMANCE_CONFIRM){
                    if(self.stateController == LW_PERFORMANCE_INPUT_STATUS_CONFIRM){
                        self.navigationController?.popViewController(animated: true)
                    }else {
                        self.setStateController(state: LW_PERFORMANCE_INPUT_STATUS_SHOW)
                        self.loadPerformance(siteId: self.liftUsage?.constructionSite?.key, tableId: self.liftUsage?.key)
                    }
                }else {
                    if(self.stateController == LW_PERFORMANCE_INPUT_STATUS_CONFIRM_NEW){
                        self.setStateController(state: LW_PERFORMANCE_INPUT_STATUS_CREATE_NEW)
                        self.liftUsageTemp = self.liftUsage
                        self.loadPerformance(siteId: self.liftUsage?.constructionSite?.key, tableId: 0)
                    }else {
                        self.setStateController(state: LW_PERFORMANCE_INPUT_STATUS_SHOW)
                        self.loadPerformance(siteId: self.liftUsage?.constructionSite?.key, tableId: self.liftUsage?.key)
                    }
                }
                    
            }
        }
    }
    
    func CheckPerformance(){
        
        guard self.validateStair(from: self.liftUsage?.departure, to: self.liftUsage?.arrial) else {
            return
        }
        self.btConfirm.isEnabled = false
        var params = LWParamUtil.initParamsLW()
        params["tableId"] = self.liftUsage?.key?.description
        params["siteId"] = self.liftUsage?.constructionSite?.key?.description
        if(liftUsage?.lift != nil){
            params["liftId"] = self.liftUsage?.lift?.liftId?.description
        }
        if(liftUsage?.customer != nil || liftUsage?.customer?.customerId != 0){
            params["customerId"] = self.liftUsage?.customer?.customerId?.description
        }
        if(liftUsage?.Operator != nil){
            params["workerId"] = self.liftUsage?.Operator?.userId?.description
        }
        
        if(liftUsage?.good != nil){
            params["goodId"] = self.liftUsage?.good?.goodId?.description
        }
 
        
        params["costStatus"] = self.liftUsage?.costStatus
        params["goodType"] = self.liftUsage?.goodType?.description
        params["goodQuantity"] = self.liftUsage?.goodQuantity?.description
        params["times"] = self.liftUsage?.times?.description
        params["departure"] = self.liftUsage?.departure
        params["arrival"] = self.liftUsage?.arrial
        params["carryTypeName"] = self.liftUsage?.carryTypeName
        if(self.liftUsage?.startTime == nil || self.stateController == LW_PERFORMANCE_INPUT_STATUS_CONFIRM_NEW){
            params["startTime"] = TRFormatUtil.formatDateCustom(date: Date(), format: "yyyy/MM/dd HH:mm")
        }else {
            params["startTime"] = self.liftUsage?.startTime
        }
        AlamofireManager.shared.request(APIRouter.post(url: API.LW_URL_LIFT_USAGE_CHECK, params: params, identifier: nil)) { (response) in
            self.btConfirm.isEnabled = true
            if response != nil{
                if(self.stateController == LW_PERFORMANCE_INPUT_STATUS_MODIFY){
                    self.setStateController(state: LW_PERFORMANCE_INPUT_STATUS_CONFIRM)
                }else {
                    self.setStateController(state: LW_PERFORMANCE_INPUT_STATUS_CONFIRM_NEW)
                }
            }
        }
    }
    
    //Delegate
    func tapConstructionLWBasicInformation() {
        if(self.stateController == LW_PERFORMANCE_INPUT_STATUS_CREATE_NEW){
            let choseConstruction = self.storyboard?.instantiateViewController(withIdentifier: "LWChoseConstructionViewController") as! LWChoseConstructionViewController
            choseConstruction.construction = self.liftUsage?.constructionSite
            choseConstruction.delegate = self
            self.navigationController?.pushViewController(choseConstruction, animated: true)
        }
    }
    
    func tapChoseConstructionView(construction: LWConstructionModel) {
        if(construction.key != self.liftUsage?.constructionSite?.key){
            self.liftUsageTemp = nil
        }
        loadPerformance(siteId: construction.key, tableId: 0)
//        }else {
//            self.liftUsage?.constructionSite = construction
//
//            self.titleRow.labConstruction.text = self.liftUsage?.constructionSite?.constructionName
//        }
        
    }
    
    func actionClickLabContent(){
        if(!(self.customerRowView.isAbleTap)!){
            return
        }
        if((self.stateController == LW_PERFORMANCE_INPUT_STATUS_MODIFY || stateController == LW_PERFORMANCE_INPUT_STATUS_CREATE_NEW) && self.liftUsage?.goodType != LW_PEOPLE_RUBBISH_STATE_HUMAN){
            let choseCustomerViewController = self.storyboard?.instantiateViewController(withIdentifier: "LWChoseCustomerViewController") as! LWChoseCustomerViewController
            
            choseCustomerViewController.delegate = self
            choseCustomerViewController.customer = self.liftUsage?.customer
            choseCustomerViewController.siteId  = self.liftUsage?.constructionSite?.key
//            choseCustomerViewController.customers = self.customers
            if(self.liftUsage?.goodType == LW_PEOPLE_RUBBISH_STATE_RUBBISH){
                choseCustomerViewController.isShowbuttonClear = true
            }else {
                choseCustomerViewController.isShowbuttonClear = false
            }
            self.navigationController?.pushViewController(choseCustomerViewController, animated: true)
        }
    }
    
    func tapLiftMaterialCellDelegate() {
        
        if(!(self.liftMaterialRowView.isAbleTap)!){
            return
        }
        
        if((self.stateController == LW_PERFORMANCE_INPUT_STATUS_MODIFY || stateController == LW_PERFORMANCE_INPUT_STATUS_CREATE_NEW) && self.liftUsage?.goodType == LW_PEOPLE_RUBBISH_STATE_GOOD){
            
            if(self.liftUsage?.customer == nil || (self.liftUsage?.customer?.customerId == nil) || self.liftUsage?.customer?.customerId == 0){
                let alertController = UIAlertController(title: "", message: NSLocalizedString("lw_must_chose_customer", comment: ""), preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .cancel, handler: nil)
                alertController.addAction(cancelAction)
                present(alertController, animated: true, completion: nil)
            }else {
                let choseGoodViewController = self.storyboard?.instantiateViewController(withIdentifier: "LWLiftMaterialSelectViewController2") as! LWLiftMaterialSelectViewController2
                choseGoodViewController.delegate = self
                
//                for liftMaterial in (self.liftUsage?.customer?.goods)! {
//                    if liftMaterial.status != 0{
//                        choseGoodViewController.liftMaterials.append(liftMaterial)
//                    }
//                }
                

//                if self.liftUsage?.customer?.categoryId == 0 || self.liftUsage?.customer?.categoryId == 3
//                {
//
//                    let carryModel1 = LWContructionCarryModel()
//                    carryModel1.status = false
//                    carryModel1.carryTypeName = "盛替"
//                    carryModel1.categoryId = 0
//                    let carryModel2 = LWContructionCarryModel()
//                    carryModel2.status = false
//                    carryModel2.carryTypeName = "搬入A"
//                    carryModel2.categoryId = 0
//                    let carryModel3 = LWContructionCarryModel()
//                    carryModel3.status = false
//                    carryModel3.carryTypeName = "搬入B"
//                    carryModel3.categoryId = 0
//                     choseGoodViewController.carries = [carryModel1,carryModel2,carryModel3]
//                }
//                if self.liftUsage?.customer?.categoryId == Equipment
//                {
//                    if self.liftUsage?.constructionSite?.carryEquipment != nil {
//                        choseGoodViewController.carries =  (self.liftUsage?.constructionSite?.carryEquipment)!
//                    }
//                }
//                if self.liftUsage?.customer?.categoryId == Architect
//                {
//                    if self.liftUsage?.constructionSite?.carryArchitect != nil {
//                    choseGoodViewController.carries =  (self.liftUsage?.constructionSite?.carryArchitect)!
//                    }
//                }
               
//                saveState(NameOfTypeisSelected: self.liftUsage?.carryTypeName)
//                choseGoodViewController.TypeIsSelected = self.TypeisSelected
                choseGoodViewController.carryTypeName = self.liftUsage?.carryTypeName
                choseGoodViewController.categoryId = self.liftUsage?.customer?.categoryId
                choseGoodViewController.customerId = self.liftUsage?.customer?.customerId
                choseGoodViewController.constructionId = self.liftUsage?.constructionSite?.key
                choseGoodViewController.liftMaterial = self.liftUsage?.good
                
                choseGoodViewController.setUnitQuantity(unitQuantity: (self.liftMaterialRowView.unitNumber.text)!)
                self.navigationController?.pushViewController(choseGoodViewController, animated: true)
            }
        }
    }
//    func convertStateToArray(NameOfTypeisSelected:String?) -> [Bool]  {
//        if NameOfTypeisSelected == "盛替" {
//            return [false,true,false,false]
//        }
//        if NameOfTypeisSelected == "搬入A" {
//            return [false,false,true,false]
//        }
//        if NameOfTypeisSelected == "搬入B" {
//            return [false,false,false,true]
//        }
//        return [true,false, false,false]
//    }
    func updateStateFree(state: String) {
        self.liftUsage?.costStatus = state
    }
    
    func tapViewOneLabelInTime(view: LWViewOneLabel) {
        if(self.stateController == LW_PERFORMANCE_INPUT_STATUS_MODIFY){
            if (self.datePickerView == nil) {
                self.datePickerView = TRDatePickerView.init()
                self.datePickerView?.delegate = self
            }
            self.datePickerView?.datePicker?.datePickerMode = .time
            self.datePickerView?.datePicker?.minuteInterval = 5
            self.datePickerView?.date = self.liftUsage?.getDateCreate()
            self.datePickerView?.show()
        }
    }
    
    func tapViewOneLabelInTitle(view: LWViewOneLabel) {
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.txfEditing = textField
        self.inputNumberPad?.numberString = textField.text
    }
    func doneEditing() {
        self.txfEditing?.endEditing(true)
    }
    
    func changeTextKeyBoard(text: String) {
        txfEditing?.text = text
        if(txfEditing?.tag == TEXT_FIELD_TAG_UNIT){
            self.liftUsage?.goodQuantity = Int((txfEditing?.text)!)
        }else {
            self.liftUsage?.times = Int((txfEditing?.text)!)
        }
    }
    
    func doneMonthPickerView(pickerView: TRDatePickerView){
        let timeString = TRFormatUtil.formatDateCustom(date: pickerView.date!, format: "HH:mm")
        self.liftUsage?.startTime = TRFormatUtil.formatDateCustom(date: pickerView.date!, format: "yyyy/MM/dd HH:mm")
        self.titleTableRow.labTime.text = timeString
    }
    
    func TapContentLab(typeControl: String) {
        if(self.stateController != LW_PERFORMANCE_INPUT_STATUS_MODIFY && stateController != LW_PERFORMANCE_INPUT_STATUS_CREATE_NEW){
            return
        }
        requestPickerState = typeControl
        var index: Int? = 0
        
        switch typeControl {
        case LW_BASE_VIEW_35_TYPE_ELV:
            if(!(self.elvRowView.isAbleTap)!){
                return
            }
            if(requestPicker == nil){
                requestPicker = TRPickerView.init()
                requestPicker?.delegate = self
            }
            var requestArray = [String]()
            for item in self.elvList {
                if(item.status != 0){
                    if(self.liftUsage?.lift != nil && item.liftId == self.liftUsage?.lift?.liftId){
                        index = requestArray.count
                    }
                    requestArray.append(item.liftName!)
                }
            }
            requestPicker?.pickerData = requestArray
            requestPicker?.selectedIndex = index
            requestPicker?.show()
            break
        case LW_BASE_VIEW_35_TYPE_OPERATOR:
            if(!(self.operatorRowView.isAbleTap)!){
                return
            }
            if(requestPicker == nil){
                requestPicker = TRPickerView.init()
                requestPicker?.delegate = self
            }
            var requestArray = [String]()
            for item in self.operatorList {
                if(item.status != 0){
                    if(self.liftUsage?.Operator != nil && item.userId == self.liftUsage?.Operator?.userId){
                        index = requestArray.count
                    }
                    requestArray.append(item.userName!)
                }
            }
            requestPicker?.pickerData = requestArray
            requestPicker?.selectedIndex = index
            requestPicker?.show()
            break
        case LW_BASE_VIEW_35_TYPE_TIME_FROM:
            index = -1
            if let from = self.liftUsage?.departure{
               //detail
                for item in self.roomList {
                    if(item == from){
                        index = self.roomList.index(of: item)
                        break
                    }
                }
            }
            
            let choseFloor = self.storyboard?.instantiateViewController(withIdentifier: "LWChoseFloorViewController") as! LWChoseFloorViewController
            choseFloor.delegate = self
            choseFloor.selectIndex = index
            choseFloor.floors = self.roomList
            choseFloor.tag = LW_BASE_VIEW_35_TYPE_TIME_FROM
            self.navigationController?.pushViewController(choseFloor, animated: true)
            break
        case LW_BASE_VIEW_35_TYPE_TIME_TO:
            index = -1
            if let from = self.liftUsage?.arrial{
                //detail
                for item in self.roomList {
                    if(item == from){
                        index = self.roomList.index(of: item)
                        break
                    }
                }
            }
                        
            let choseFloor = self.storyboard?.instantiateViewController(withIdentifier: "LWChoseManyFloorViewController") as! LWChoseManyFloorViewController
            
            choseFloor.delegate = self
            choseFloor.selectIndex = index
            choseFloor.floors = self.roomList
            choseFloor.tag = LW_BASE_VIEW_35_TYPE_TIME_TO
            self.navigationController?.pushViewController(choseFloor, animated: true)
            
            break
        default:
            break
        }
    }
    
    func donePickerView(pickerView: TRPickerView, selectedIndex: Int) {
        
        if(pickerView == requestPicker){
            switch requestPickerState {
            case LW_BASE_VIEW_35_TYPE_DATE?:
                break
            case LW_BASE_VIEW_35_TYPE_ELV?:
                self.elvRowView.labContent.text = self.elvList[selectedIndex].liftName
                self.liftUsage?.lift = self.elvList[selectedIndex]
                break
            case LW_BASE_VIEW_35_TYPE_OPERATOR?:
                self.operatorRowView.labContent.text = self.operatorList[selectedIndex].userName
                self.liftUsage?.Operator = self.operatorList[selectedIndex]
                break
            default:
                break
            }
        }
    }
    
    func doneChoseFloor(floor: String, tag: String) {
            if tag == LW_BASE_VIEW_35_TYPE_TIME_FROM {
                if self.validateStair(from: floor, to: liftUsage?.arrial){
                    self.timeRowView.labContentFrom.text = floor
                    self.liftUsage?.departure = floor
                }
            }else {
                if self.validateStair(from: liftUsage?.departure, to: floor){
                    self.timeRowView.labContentTo.text = floor
                    self.liftUsage?.arrial = floor
                }
            }
    }
    
    
    func doneChoseManyFloor(floor: String, tag: String) {
            if tag == LW_BASE_VIEW_35_TYPE_TIME_FROM {
                if self.validateStair(from: floor, to: liftUsage?.arrial){
                    self.timeRowView.labContentFrom.text = floor
                    self.liftUsage?.departure = floor
                }
            }else {
                if self.validateStair(from: liftUsage?.departure, to: floor){
                    self.timeRowView.labContentTo.text = floor
                    self.liftUsage?.arrial = floor
                }
            }
    }
    
    func tapChoseCustomerview(customer: LWCustomerModel) {
        if(customer.customerName != nil){
            self.customerRowView.labContent.text = customer.customerName
            
        }else {
            self.customerRowView.labContent.text = ""
        }
        if(liftUsage?.customer == nil || (customer.customerId != self.liftUsage?.customer?.customerId)){
            
            self.liftUsage?.good = LWGoodModel.init()
            
                        
            self.liftMaterialRowView.contentLabel.text = ""
            self.liftUsage?.carryTypeName = ""
           
        }
        self.liftUsage?.customer = customer
    }
    
    func liftMaterialSelectTap(liftMaterial: LWGoodModel?, unitQuantity: String, NameOfTypeisSelected: String) {
        if liftMaterial != nil {
             self.liftMaterialRowView.contentLabel.text = liftMaterial!.goodName
            self.liftUsage?.good = liftMaterial
        }
       
        self.liftMaterialRowView.unitNumber.text = unitQuantity
        
        self.liftUsage?.goodQuantity = Int(unitQuantity)
        self.liftUsage?.carryTypeName = NameOfTypeisSelected
//        self.NameOfTypeisSelected = NameOfTypeisSelected
//        self.TypeisSelected = TypeisSelected
       
    }
   
    
    func updateStatePeopleRubbish(state: String) {
        self.liftUsage?.goodType = state
        switch state {
        case LW_PEOPLE_RUBBISH_STATE_GOOD:
            self.customerRowView.setAlpha(alphaView: 1)
            self.liftMaterialRowView.setAbleTap(isAble: true)
            self.liftMaterialRowView.setAlpha(alphaView: 1)
            break
        case LW_PEOPLE_RUBBISH_STATE_HUMAN:
            chosePeople()
            break
        case LW_PEOPLE_RUBBISH_STATE_RUBBISH:
            choseRubbish()
            break
        default:
            break
        }
    }
    
    func chosePeople(){
        self.customerRowView.setAlpha(alphaView: 0.5)
        self.customerRowView.labContent.text = ""
        self.liftMaterialRowView.setAlpha(alphaView: 0.5)
        self.liftMaterialRowView.contentLabel.text = ""
        self.liftMaterialRowView.unitNumber.text = ""
        self.liftMaterialRowView.setDefaultFree()
         self.liftUsage?.costStatus = "-1"
        self.liftMaterialRowView.setAbleTap(isAble: false)
        
        self.liftUsage?.good = LWGoodModel.init()
        
        self.liftUsage?.customer = LWCustomerModel.init()
        self.liftUsage?.goodQuantity = 0
    }
    
    func choseRubbish(){
        self.customerRowView.setAlpha(alphaView: 1)
        self.liftMaterialRowView.setAlpha(alphaView: 0.5)
        self.liftMaterialRowView.contentLabel.text = ""
        self.liftMaterialRowView.unitNumber.text = ""
        self.liftMaterialRowView.setDefaultFree()
        self.liftUsage?.costStatus = "-1"
        self.liftMaterialRowView.setAbleTap(isAble: false)
        
        self.liftUsage?.good = LWGoodModel.init()
        
    }
    
    
    //////////////////////////
    internal func setStateController(state: String){
        self.stateController = state
        switch state {
        case LW_PERFORMANCE_INPUT_STATUS_SHOW:
            self.setTitleBackgroundColor(colorRow: LW_COLOR_BLUE, colorTitle: LW_COLOR_TITLE_INPUT_PERFORMACE)
            self.btBackToInput.setTitle(NSLocalizedString("lw_back_to_list", comment: ""), for: .normal)
            if(self.stateTabbar != LW_TABBAR_PERFORMANCE_CONFIRM){
                self.btBackToInput.isHidden = true
            }
            self.btConfirm.setAttributedTitleColor(title: NSLocalizedString("lw_modify", comment: ""), titleColor: LW_COLOR_WHITE, backgroundColor: LW_COLOR_BLUE_DARK)
            self.titleTableRow.labTime.isHidden = false
            self.liftMaterialRowView.setAbleTap(isAble: false)
            self.peopleRubbishRowView.setActive(isActive: false)
            self.timeRowView.txFTime.isUserInteractionEnabled = false
            self.titleTableRow.labTitle.text = NSLocalizedString("lw_performance_detail", comment: "")
            self.titleTableRow.labTime.text = self.liftUsage?.getTime()
            
            self.ishidenArrowImage(isHide: true)
            self.titleRow.isHidenDateTime(isHide: false)
            break
        case LW_PERFORMANCE_INPUT_STATUS_MODIFY:
            self.setTitleBackgroundColor(colorRow: LW_COLOR_RED, colorTitle: LW_COLOR_TITLE_INPUT_PERFORMACE_RED)
            self.btBackToInput.setTitle(NSLocalizedString("lw_back_to_detail", comment: ""), for: .normal)
            self.btBackToInput.isHidden = false
            self.btConfirm.setAttributedTitleColor(title: NSLocalizedString("lw_confirm", comment: ""), titleColor: LW_COLOR_WHITE, backgroundColor: LW_COLOR_BLUE_DARK)
            self.btnNextView.isHidden = true
            self.btnPrevView.isHidden = true
            self.titleTableRow.labTime.isHidden = false
            if(self.liftUsage?.goodType == LW_PEOPLE_RUBBISH_STATE_GOOD){
                self.liftMaterialRowView.setAbleTap(isAble: true)
            }
            self.peopleRubbishRowView.setActive(isActive: false)
            self.timeRowView.txFTime.isUserInteractionEnabled = true
            self.titleTableRow.labTitle.text = NSLocalizedString("lw_performance_modify", comment: "")
            self.titleTableRow.labTime.text = self.liftUsage?.getTime()
            self.ishidenArrowImage(isHide: false)
            self.checkHideArrowImage()
            self.titleRow.isHidenDateTime(isHide: true)
            self.titleRow.arrowImage.isHidden = true
            break
        case LW_PERFORMANCE_INPUT_STATUS_CONFIRM:
            self.setTitleBackgroundColor(colorRow: LW_COLOR_RED, colorTitle: LW_COLOR_TITLE_INPUT_PERFORMACE_RED)
            
            self.btBackToInput.setTitle(NSLocalizedString("lw_back_to_modify", comment: ""), for: .normal)
            self.btConfirm.setAttributedTitleColor(title: NSLocalizedString("lw_send", comment: ""), titleColor: LW_COLOR_BLUE_DARK, backgroundColor: LW_COLOR_GREEN)
            self.btnNextView.isHidden = true
            self.btnPrevView.isHidden = true
            self.titleTableRow.labTime.isHidden = false
            self.liftMaterialRowView.setAbleTap(isAble: false)
            self.peopleRubbishRowView.setActive(isActive: false)
            self.timeRowView.txFTime.isUserInteractionEnabled = false
            self.titleTableRow.labTitle.text = NSLocalizedString("lw_send_modification", comment: "")
            self.titleTableRow.labTime.text = self.liftUsage?.getTime()
            self.ishidenArrowImage(isHide: true)
            self.titleRow.isHidenDateTime(isHide: false)
            break
        case LW_PERFORMANCE_INPUT_STATUS_CREATE_NEW:
            self.setTitleBackgroundColor(colorRow: LW_COLOR_BLUE, colorTitle: LW_COLOR_TITLE_INPUT_PERFORMACE)
            self.btConfirm.setAttributedTitleColor(title: NSLocalizedString("lw_confirm", comment: ""), titleColor: LW_COLOR_WHITE, backgroundColor: LW_COLOR_BLUE_DARK)
            self.btBackToInput.isHidden = true
            self.btnNextView.isHidden = true
            self.btnPrevView.isHidden = true
            self.titleTableRow.labTime.isHidden = true
            if(self.liftUsage?.goodType == LW_PEOPLE_RUBBISH_STATE_GOOD){
                self.liftMaterialRowView.setAbleTap(isAble: true)
            }
            self.peopleRubbishRowView.setActive(isActive: true)
            self.timeRowView.txFTime.isUserInteractionEnabled = true
            self.titleTableRow.labTitle.text = NSLocalizedString("lw_performance_input", comment: "")
            self.titleTableRow.labTime.text = ""
            self.ishidenArrowImage(isHide: false)
            self.titleTableRow.arrowImage.isHidden = true
            self.titleRow.isHidenDateTime(isHide: false)
            break
        case LW_PERFORMANCE_INPUT_STATUS_CONFIRM_NEW:
            self.setTitleBackgroundColor(colorRow: LW_COLOR_BLUE, colorTitle: LW_COLOR_TITLE_INPUT_PERFORMACE)
            
            self.btConfirm.setAttributedTitleColor(title: NSLocalizedString("lw_send", comment: ""), titleColor: LW_COLOR_BLUE_DARK, backgroundColor: LW_COLOR_GREEN)
            self.btBackToInput.setTitle(NSLocalizedString("lw_back_to_input", comment: ""), for: .normal)
            self.btnNextView.isHidden = true
            self.btnPrevView.isHidden = true
            self.btBackToInput.isHidden = false
            self.titleTableRow.labTime.isHidden = true
            self.liftMaterialRowView.setAbleTap(isAble: false)
            self.peopleRubbishRowView.setActive(isActive: false)
            self.timeRowView.txFTime.isUserInteractionEnabled = false
            self.titleTableRow.labTitle.text = NSLocalizedString("lw_performance_input", comment: "")
            self.titleTableRow.labTime.text = ""
            self.ishidenArrowImage(isHide: true)
            self.titleRow.isHidenDateTime(isHide: false)
            break
        default:
            break
        }
    }
    
    func setTitleBackgroundColor(colorRow: UIColor, colorTitle: UIColor){
        self.titleRow.setBackgoundColor(color: colorRow)
        self.titleTableRow.setBackgoundColor(color: colorRow)
        self.elvRowView.labTitle.backgroundColor = colorTitle
        self.operatorRowView.labTitle.backgroundColor = colorTitle
        self.customerRowView.labTitle.backgroundColor = colorTitle
        self.liftMaterialRowView.setTitleBackgoundColor(color: colorTitle)
        self.peopleRubbishRowView.setTitleBackgoundColor(color: colorTitle)
        self.timeRowView.setTitleBackgoundColor(color: colorTitle)
    }
    
    func ishidenArrowImage(isHide: Bool){
        self.titleRow.arrowImage.isHidden = isHide
        self.elvRowView.arrowImage.isHidden = isHide
        self.operatorRowView.arrowImage.isHidden = isHide
        self.customerRowView.iconArrow.isHidden = isHide
        self.liftMaterialRowView.arrowImage.isHidden = isHide
        self.titleTableRow.arrowImage.isHidden = isHide
    }
    
    func checkHideArrowImage(){
        if(!(self.customerRowView.isAbleTap)!){
            self.customerRowView.iconArrow.isHidden = true
        }
        
//        if(!(self.titleRow.isAbleTap)!){
//            self.titleRow.arrowImage.isHidden = true
//        }
        
        if(!(self.elvRowView.isAbleTap)!){
            self.elvRowView.arrowImage.isHidden = true
        }
        
        if(!(self.operatorRowView.isAbleTap)!){
            self.operatorRowView.arrowImage.isHidden = true
        }
        
        if(!(self.liftMaterialRowView.isAbleTap)!){
            self.liftMaterialRowView.arrowImage.isHidden = true
        }
        
    }
    
    func isEditedLiftUsage() -> Bool {
        if(self.liftUsage?.lift?.liftId != self.liftUsageShow?.lift?.liftId){
            return true
        }
        if(self.liftUsage?.Operator?.userId != self.liftUsageShow?.Operator?.userId){
            return true
        }
        
        if(self.liftUsage?.costStatus != self.liftUsageShow?.costStatus){
            return true
        }
        
        switch self.liftUsage?.goodType {
        case LW_PEOPLE_RUBBISH_STATE_GOOD?:
            if(self.liftUsage?.customer?.customerId != self.liftUsageShow?.customer?.customerId){
                return true
            }
            
            if(self.liftUsage?.good?.goodId != self.liftUsageShow?.good?.goodId){
                return true
            }
            
            if(self.liftUsage?.goodQuantity != self.liftUsageShow?.goodQuantity){
                return true
            }
            break
        case LW_PEOPLE_RUBBISH_STATE_HUMAN?:
            break
        case LW_PEOPLE_RUBBISH_STATE_RUBBISH?:
            if((self.liftUsage?.customer == nil && self.liftUsageShow?.customer != nil) || (self.liftUsage?.customer != nil && self.liftUsageShow?.customer == nil) || (self.liftUsage?.customer?.customerId != self.liftUsageShow?.customer?.customerId)){
                return true
            }
            
            break
        default:
            break
        }
        if(self.liftUsage?.times != self.liftUsageShow?.times){
            return true
        }
        if(self.liftUsage?.arrial != self.liftUsageShow?.arrial){
            return true
        }
        
        if(self.liftUsage?.departure != self.liftUsageShow?.departure){
            return true
        }
        
        if(self.liftUsage?.startTime != self.liftUsageShow?.startTime){
            return true
        }

        return false
    }
    
    func validateStair(from: String?, to: String?)-> Bool{
        
        if let from1  = from, let to1 = to{
            if from1 == to1 && from1 != "1"{
                self.showAlert(title: "", message: NSLocalizedString("STAIR_FROM_HAVE_TO_DIFFER_FROM_TO", comment: ""))
                return false
            }
        }
        return true
    }
    
}



