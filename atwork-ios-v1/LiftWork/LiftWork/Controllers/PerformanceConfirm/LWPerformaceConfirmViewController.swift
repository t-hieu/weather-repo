//
//  LWPerformaceConfirmViewController.swift
//  LiftWork
//
//  Created by CuongNV on 5/17/18.
//  Copyright © 2018 Trente. All rights reserved.
//

import UIKit
import TrenteCoreSwift
import ObjectMapper

class LWPerformaceConfirmViewController: LWBaseViewController, LWViewBaseDelegate,LWViewBase35Delegate, TRPickerViewDelegate, TRDatePickerViewDelegate, LWChoseConstructionViewDelegate, UITableViewDelegate, UITableViewDataSource,MainStoryboard {
    
    @IBOutlet weak var basicInformationRow: LWBasicInformationView!
    @IBOutlet weak var constructionRow: LWViewBase!
    @IBOutlet weak var dateRow: LWViewBase35!
    @IBOutlet weak var elvRow: LWViewBase35!
    @IBOutlet weak var operationRow: LWViewBase35!
    @IBOutlet weak var performanceTitleRow: LWViewOneLabel!
    @IBOutlet weak var titleTableView: LWPerformanceCell!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btSort: UIButton!
    
    
    
    internal var datePickerView: TRDatePickerView?
    internal var elvList:[LWLiftModel]? = []
    internal var elvChosed: LWLiftModel?
    internal var operatorList:[LWOperatorModel]? = []
    internal var operatorChosed: LWOperatorModel?
    internal var requestPicker: TRPickerView?
    internal var requestPickerState: String?
    internal var construction: LWConstructionModel?
    internal var liftUsages = [LWLiftUsageModel]()
//    internal var constructions = [LWConstructionModel]()
    internal var sortState: String?
    internal var searchDateString: String? = nil
    
    var timer: Timer?
    var firstLoad: Bool? = true
    override func viewDidLoad() {
        super.viewDidLoad()
        basicInformationRow.labBasicInfomation.text = NSLocalizedString("lw_performance_confirm", comment: "")
        constructionRow.labTitle.text = NSLocalizedString("lw_construction", comment: "")
        constructionRow.delegate = self
        
        dateRow.labTitle.text = NSLocalizedString("lw_date", comment: "")
        dateRow.typeControl = LW_BASE_VIEW_35_TYPE_DATE
        dateRow.delegate = self
        self.searchDateString = TRFormatUtil.formatDateCustom(date: Date(), format: "yyyy/MM/dd")
        dateRow.labContent.text = self.searchDateString
        
        elvRow.labTitle.text = NSLocalizedString("lw_elv", comment: "")
        elvRow.typeControl = LW_BASE_VIEW_35_TYPE_ELV
        elvRow.delegate = self
        elvRow.labContent.text = NSLocalizedString("lw_all", comment: "")
        operationRow.labTitle.text = NSLocalizedString("lw_operator", comment: "")
        operationRow.typeControl = LW_BASE_VIEW_35_TYPE_OPERATOR
        operationRow.delegate = self
        operationRow.labContent.text = NSLocalizedString("lw_all", comment: "")
        performanceTitleRow.labTitle.text = NSLocalizedString("lw_performance_list", comment: "")
        
        titleTableView.setBackgroundColor(color: LW_BUTTON_COLOR2)
        titleTableView.setTextColor(color: LW_COLOR_WHITE)
        titleTableView.timeLabel.text = NSLocalizedString("lw_time", comment: "")
        titleTableView.customerLabel.text = NSLocalizedString("lw_customer", comment: "")
        titleTableView.liftMaterialLabel.text = NSLocalizedString("lw_lifting_material", comment: "")
        titleTableView.fromToLabel.text = NSLocalizedString("lw_from_to", comment: "")
        
        //        self.addDatePickerView()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib.init(nibName: "LWPerformanceTableViewCell", bundle: Bundle.init(for: LWPerformanceTableViewCell.self)), forCellReuseIdentifier: "LWPerformanceTableViewCell")
        
        sortState = LW_ORDER_DESC
        btSort.setImage(UIImage(named: "down"), for: .normal)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(showCurrentDateTime), userInfo: nil, repeats: true)
    }
    
    internal func reloadConstruction(){
        if(self.firstLoad)!{
            self.firstLoad = false
            let constructionId = LWUserDefaults.getConstructionId()
            if(!constructionId.isEmpty){
                if  self.construction == nil{
                    self.construction = LWConstructionModel()
                }
                self.construction?.key = Int(constructionId)
                self.construction?.constructionName = LWUserDefaults.getConstructionName()
                constructionRow.labContent.text = self.construction?.constructionName
            }
        }
        self.loadLiftUsages()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if LWUserDefaults.getConstructionId().isEmpty{
            if let vc = ConstructionSelectViewController.createInstanceFromStoryboard() as?ConstructionSelectViewController {
                vc.index = 1
                self.navigationController?.pushViewController(vc, animated: false)
            }
        }else{
            self.reloadConstruction()
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tapSort(_ sender: Any) {
        if(sortState == LW_ORDER_DESC){
            sortState = LW_ORDER_ASC
            btSort.setImage(UIImage(named: "up"), for: .normal)
        }else {
            sortState = LW_ORDER_DESC
            btSort.setImage(UIImage(named: "down"), for: .normal)
        }
        loadLiftUsages()
    }
    
    
    @objc func showCurrentDateTime(){
        let date = Date()
        let dateString = TRFormatUtil.formatDateCustom(date: date, format: "yyyy/MM/dd")
        let timeString = TRFormatUtil.formatDateCustom(date: date, format: "HH:mm:ss")
        self.basicInformationRow.labDate.text = dateString
        self.basicInformationRow.labTime.text = timeString
    }
    
    func addDatePickerView() {
        if (self.datePickerView == nil) {
            self.datePickerView = TRDatePickerView.init()
            self.datePickerView?.delegate = self
        }
        self.datePickerView?.datePicker?.datePickerMode = .date
//        self.searchDateString = TRFormatUtil.formatDateCustom(date: pickerView.date!, format: "yyyy/MM/dd")
        if let dateString = self.searchDateString{
            self.datePickerView?.date = TRDateUtil.makeDateCustom(date: dateString, format: "yyyy/MM/dd")
        }
        
    }
    //call api
    func loadLiftUsages(){
        var params = LWParamUtil.initParamsLW()
        params["orderType"] = self.sortState
        if(self.construction != nil){
            params["siteId"] = self.construction?.key?.description
        }
        if(self.operatorChosed != nil){
            params["workerId"] = self.operatorChosed?.userId?.description
        }
        
        if(self.elvChosed != nil){
            params["liftId"] = self.elvChosed?.liftId?.description
        }
        
        if(self.searchDateString != nil){
            params["startTime"] = self.searchDateString! + " 00:00"
            params["endTime"] = self.searchDateString! + " 23:59"        }
        
        AlamofireManager.shared.request(APIRouter.get(url: API.LW_URL_LIFT_USAGE_LIST, params: params, identifier: nil)) { (response) in
            if response != nil{
                //data
                guard let liftUsages:[LWLiftUsageModel] = Mapper<LWLiftUsageModel>().mapArray(JSONObject:response!["liftUsages"]),
                    let cons = response!["constructionSite"] as? [String:Any],
                    let construction = Mapper<LWConstructionModel>().map(JSON: cons)
                    else{
                        return
                }
                self.liftUsages = liftUsages
                self.construction = construction
                self.elvList = self.construction?.lifts
                self.operatorList = self.construction?.operators
                self.tableView.reloadData()

            }
        }
        
    }
    
    func deleteLiftUsages(liftUsage: LWLiftUsageModel){
        var params = LWParamUtil.initParamsLW()
        params["tableId"] = liftUsage.key?.description
        AlamofireManager.shared.request(APIRouter.post(url: API.LW_URL_LIFT_USAGE_DELETE, params: params, identifier: nil)) { (response) in
            if response != nil{
                self.loadLiftUsages()
            }
        }
    }
    
    func actionClickLabContent() {
        let choseConstruction = self.storyboard?.instantiateViewController(withIdentifier: "LWChoseConstructionViewController") as! LWChoseConstructionViewController
        choseConstruction.construction = self.construction
//        choseConstruction.constructions = self.constructions
        choseConstruction.delegate = self
        self.navigationController?.pushViewController(choseConstruction, animated: true)
    }
    
    func TapContentLab(typeControl: String) {
        requestPickerState = typeControl
        var index: Int? = 0
        switch typeControl {
        case LW_BASE_VIEW_35_TYPE_DATE:
            self.addDatePickerView()
            self.datePickerView?.show()
            break
        case LW_BASE_VIEW_35_TYPE_ELV:
            if(requestPicker == nil){
                requestPicker = TRPickerView.init()
                requestPicker?.delegate = self
            }
            var requestArray = [String]()
            requestArray.append(NSLocalizedString("lw_all", comment: ""))
            if let elvs = self.elvList{
                for item in elvs {
                    if(item.liftId == self.elvChosed?.liftId){
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
            if(requestPicker == nil){
                requestPicker = TRPickerView.init()
                requestPicker?.delegate = self
            }
            var requestArray = [String]()
            requestArray.append(NSLocalizedString("lw_all", comment: ""))
            if let operatorList = self.operatorList{
                for item in operatorList {
                    if(item.userId == operatorChosed?.userId){
                        index = requestArray.count
                    }
                    requestArray.append(item.userName!)
                }
            }
            requestPicker?.pickerData = requestArray
            requestPicker?.selectedIndex = index
            requestPicker?.show()
            break
        default:
            break
        }
    }
    
    func donePickerView(pickerView: TRPickerView, selectedIndex: Int) {
        
        if(pickerView == requestPicker){
            switch requestPickerState {
            case LW_BASE_VIEW_35_TYPE_ELV?:
                if(selectedIndex != 0){
                    self.elvRow.labContent.text = self.elvList?[selectedIndex-1].liftName
                    self.elvChosed = self.elvList?[selectedIndex-1]
                } else {
                    self.elvRow.labContent.text = NSLocalizedString("lw_all", comment: "")
                    self.elvChosed = nil
                }
                loadLiftUsages()
                break
            case LW_BASE_VIEW_35_TYPE_OPERATOR?:
                if(selectedIndex != 0){
                    self.operationRow.labContent.text = self.operatorList?[selectedIndex-1].userName
                    self.operatorChosed = self.operatorList?[selectedIndex-1]
                }else {
                    self.operationRow.labContent.text = NSLocalizedString("lw_all", comment: "")
                    self.operatorChosed = nil
                }
                loadLiftUsages()
                break
            default:
                break
            }
        }
    }
    
    func doneMonthPickerView(pickerView: TRDatePickerView){
        self.searchDateString = TRFormatUtil.formatDateCustom(date: pickerView.date!, format: "yyyy/MM/dd")
        self.dateRow.labContent.text = self.searchDateString
        self.loadLiftUsages()
    }
    
    func tapChoseConstructionView(construction: LWConstructionModel) {
        self.construction = construction
//        LWUserDefaults.setConstructionId(val: (self.construction?.key?.description)!)
//        LWUserDefaults.setConstructionName(val: (self.construction?.constructionName)!)
        self.constructionRow.labContent.text = construction.constructionName
        self.elvRow.labContent.text = NSLocalizedString("lw_all", comment: "")
        self.elvChosed = nil
        self.operationRow.labContent.text = NSLocalizedString("lw_all", comment: "")
        self.operatorChosed = nil
        
    }
    
    //tableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.liftUsages.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "LWPerformanceTableViewCell") as? LWPerformanceTableViewCell
        if (cell == nil) {
            cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "LWPerformanceTableViewCell") as? LWPerformanceTableViewCell
        }
        let liftUsage = self.liftUsages[indexPath.row]
        //Hieu
        /*
        cell?.showData(time: liftUsage.getTime(), customer: (liftUsage.customer?.customerName)!, liftmaterial: (liftUsage.good?.goodName)!, fromto: liftUsage.getFromToString())
        */
        
        var goodNames: String! = liftUsage.good!.goodName
        if let count = liftUsage.expandGoods?.count{
            for i in 0..<count{
                goodNames += MATERIAL_MARK + (liftUsage.expandGoods![i].goodName)!
            }
        }
        
        cell?.showData(time: liftUsage.getTime(), customer: (liftUsage.customer?.customerName)!, liftmaterial: goodNames, fromto: liftUsage.getFromToString())
        //End
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let performance = self.storyboard?.instantiateViewController(withIdentifier: "LWPerformanceDetailViewController") as! LWPerformanceDetailViewController
        performance.liftUsage = self.liftUsages[indexPath.row]
        if(self.operatorChosed != nil){
            performance.searchWorkerId = self.operatorChosed?.userId?.description
        }
        if(self.elvChosed != nil){
            performance.searchLiftId = self.elvChosed?.liftId?.description
        }
        performance.stateController = LW_PERFORMANCE_INPUT_STATUS_SHOW
        performance.stateTabbar = LW_TABBAR_PERFORMANCE_CONFIRM
        self.navigationController?.pushViewController(performance, animated: true)
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let action = UITableViewRowAction.init(style: UITableViewRowActionStyle.default, title: NSLocalizedString("ACTION_DELETE", comment: "")) { (action, indexPath) in
            self.deleteLiftUsages(liftUsage: self.liftUsages[indexPath.row])
        }
        return [action]
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        self.deleteLiftUsages(liftUsage: liftUsages[indexPath.row])
        
    }
    
    func getLiftUsagesSortASC() -> [LWLiftUsageModel]{
        if(sortState == LW_ORDER_ASC){
            return self.liftUsages
        }
        
        var liftUsagesResult = [LWLiftUsageModel]()
        for item in self.liftUsages {
            liftUsagesResult.insert(item, at: 0)
        }
        return liftUsagesResult
    }
}



