//
//  LWChoseCustomerViewController.swift
//  LiftWork
//
//  Created by CuongNV on 5/24/18.
//  Copyright © 2018 Trente. All rights reserved.
//

import UIKit
import TrenteCoreSwift
import ObjectMapper

protocol LWChoseCustomerViewDelegate {
    func tapChoseCustomerview(customer: LWCustomerModel)
}
class LWChoseCustomerViewController: LWBaseViewController, UITableViewDataSource, UITableViewDelegate, LWViewOneLabelDelegate{
    
    @IBOutlet weak var infomationView: LWViewOneLabel!
    @IBOutlet weak var filterView: LWFilterByCharacterView!
    @IBOutlet weak var titleList: LWViewOneLabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    var delegate: LWChoseCustomerViewDelegate?
    var isShowbuttonClear: Bool? = false
    
    internal var customers = [LWCustomerModel]()
    var siteId:Int?
    var customer: LWCustomerModel?
    
//    var indexs:[String:Int] = [:]
    internal var displayCustomers:[LWCustomerModel] = []
    internal var filterCharacter:String?{
        didSet{
            self.filterCustomers(key: filterCharacter)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.infomationView.labTitle.text = NSLocalizedString("lw_button_back", comment: "")
        self.infomationView.delegate = self
        
        
        titleList.labTitle.text = NSLocalizedString("lw_character_customer_select_list", comment: "")
        if(isShowbuttonClear)!{
            titleList.labTime.text = NSLocalizedString("lw_clear_customer", comment: "")
            titleList.delegate = self
        }
        self.filterView.delegate = self
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.register(UINib.init(nibName: "LWCellOneLabel", bundle: Bundle.init(for: LWCellOneLabel.self)), forCellReuseIdentifier: "LWCellOneLabel")
        
        self.view.activityIndicatorView.startAnimating()
        loadCustomer()
    }
    
    func loadCustomer(){
        var params = LWParamUtil.initParamsLW()
        params["siteId"] = "\(self.siteId ?? 0)"
        AlamofireManager.shared.request(APIRouter.get(url: API.LW_URL_CUSTOMER_LIST, params: params, identifier: nil)) { (response) in
            if response != nil{
                self.view.activityIndicatorView.stopAnimating()
                
                guard let customers = Mapper<LWCustomerModel>().mapArray(JSONObject: response!["customers"] )
                    else{
                        return
                }
                
                var newCustomers:[LWCustomerModel] = []
                for customer in customers{
                    if(customer.status != 0){
                        newCustomers.append(customer)
                    }
                }
                
                self.customers = newCustomers
                self.filterCustomers(key: self.filterCharacter)
                
            }
            
        }
        
    }
    
//    private func checkIndex(key:String,rows:[String],index:String)->Bool{
//        for row in rows{
//            if key.hasPrefix(row){
//                self.indexs[index]  = self.indexs[index]! + 1
//                return true
//            }
//        }
//        return false
//    }
//    private func indexCustomers(){
//        self.indexs = [
//            "aRow":0,
//            "kaRow":0,
//            "saRow":0,
//            "taRow":0,
//            "naRow":0,
//            "haRow":0,
//            "maRow":0,
//            "yaRow":0,
//            "raRow":0,
//            "waRow":0
//        ]
//
//        for customer in self.customers{
//            let key = customer.customerNameKana ?? ""
////            print(key)
//
//             let katakana2 = key.applyingTransform(.toUnicodeName, reverse: false)!
//            print(katakana2)             // -> U+30A1 KATAKANA LETTER SMALL A
//
//
//            if self.checkIndex(key: key, rows: aRows, index: "aRow"){
//                continue
//            }else if self.checkIndex(key: key, rows: kaRows, index: "kaRow"){
//                continue
//            }else if self.checkIndex(key: key, rows: saRows, index: "saRow"){
//                continue
//            }else if self.checkIndex(key: key, rows: taRows, index: "taRow"){
//                continue
//            }else if self.checkIndex(key: key, rows: naRows, index: "naRow"){
//                continue
//            }else if self.checkIndex(key: key, rows: haRows, index: "haRow"){
//                continue
//            }else if self.checkIndex(key: key, rows: maRows, index: "maRow"){
//                continue
//            }else if self.checkIndex(key: key, rows: yaRows, index: "yaRow"){
//                continue
//            }else if self.checkIndex(key: key, rows: raRows, index: "raRow"){
//                continue
//            }else if self.checkIndex(key: key, rows: waRows, index: "waRow"){
//                continue
//            }else{
//                self.indexs["aRow"]  = self.indexs["aRow"]! + 1
//            }
//        }
//        print(self.indexs)
//    }
    private func checkIndex(item:LWCustomerModel,rows:[String])->Bool{
        let key  = item.customerNameKana ?? ""
        for row in rows{
            if key.hasPrefix(row){
                return true
            }
        }
        return false
    }
    private func filterCustomers(key:String?){
        var filterArrays:[LWCustomerModel] = []
        for customer in self.customers{
            //            let rows = ["あ","か","さ","た","な","は","ま","や","ら","わ"]
            switch key{
            case "あ"?:
                if self.checkIndex(item: customer, rows: aRows){
                    filterArrays.append(customer)
                }
                break
            case "か"?:
                if self.checkIndex(item: customer, rows: kaRows){
                    filterArrays.append(customer)
                }
                break
            case "さ"?:
                if self.checkIndex(item: customer, rows: saRows){
                    filterArrays.append(customer)
                }
                break
            case "た"?:
                if self.checkIndex(item: customer, rows: taRows){
                    filterArrays.append(customer)
                }
                break
            case "な"?:
                if self.checkIndex(item: customer, rows: naRows){
                    filterArrays.append(customer)
                }
                break
            case "は"?:
                if self.checkIndex(item: customer, rows: haRows){
                    filterArrays.append(customer)
                }
                break
            case "ま"?:
                if self.checkIndex(item: customer, rows: maRows){
                    filterArrays.append(customer)
                }
                break
            case "や"?:
                if self.checkIndex(item: customer, rows: yaRows){
                    filterArrays.append(customer)
                }
                break
            case "ら"?:
                if self.checkIndex(item: customer, rows: raRows){
                    filterArrays.append(customer)
                }
                break
            case "わ"?:
                if self.checkIndex(item: customer, rows: waRows){
                    filterArrays.append(customer)
                }
                break
            default:
                filterArrays = self.customers
                break
            }
            
        }
        self.displayCustomers = filterArrays
        self.tableView.reloadData()
        self.perform(#selector(scrollToTop), with: nil, afterDelay: 1)
    }
    @objc func scrollToTop(){
        self.tableView.scrollsToTop = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tapViewOneLabelInTitle(view: LWViewOneLabel) {
        if(view == self.infomationView){
            self.navigationController?.popViewController(animated: true)
        }
    }
    func tapViewOneLabelInTime(view: LWViewOneLabel) {
        if(view == self.titleList){
            delegate?.tapChoseCustomerview(customer: LWCustomerModel.init())
            comeback()
        }
    }
    
    
//    func loadCustomer(){
//        var params = LWParamUtil.initParamsLW()
//        self.customers.removeAll()
//        HTTPRequestManager.getInstance().asyncGET(url: LW_URL_CUSTOMER_LIST, params: params as [String : AnyObject], isLoading: true, success: {(response) -> Void in
//            
//            for res in response["customers"] as! NSArray{
//                let customer = LWCustomerModel.init(response: res as! [String: Any])
//                self.customers.append(customer)
//            }
//            self.tableView.reloadData()
//        } )
//    }
    
    
    
    //tableview
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.displayCustomers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell1 = tableView.dequeueReusableCell(withIdentifier: "LWCellOneLabel") as? LWCellOneLabel
        if (cell1 == nil) {
            cell1 = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "LWCellOneLabel") as? LWCellOneLabel
        }
        cell1?.label.text = self.displayCustomers[indexPath.row].customerName!
        if(self.customer != nil && self.customer?.customerId == self.displayCustomers[indexPath.row].customerId){
            cell1?.backgroundColor = LW_COLOR_TITLE_INPUT_PERFORMACE
        }else{
             cell1?.backgroundColor = UIColor.clear
        }
        return cell1!
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.tapChoseCustomerview(customer: self.displayCustomers[indexPath.row])
        comeback()
    }
    
    func comeback(){
        //        self.navigationController?.popViewController(animated: true)
        self.navigationController?.popViewController(animated: false)
    }
    
    // delegate
    
//    func tapLabel(label: UILabel) {
//        labelchose.backgroundColor = LW_COLOR_WHITE
//        labelchose.textColor = LW_COLOR_BLACK
//        labelchose = label
//        labelchose.backgroundColor = LW_COLOR_BLUE
//        labelchose.textColor = LW_COLOR_WHITE
//
//        let aRow = self.indexs["aRow"] ?? 0
//        let kaRow = self.indexs["kaRow"] ?? 0
//        let saRow = self.indexs["saRow"] ?? 0
//        let taRow = self.indexs["taRow"] ?? 0
//        let naRow = self.indexs["naRow"] ?? 0
//        let haRow = self.indexs["haRow"] ?? 0
//        let maRow = self.indexs["maRow"] ?? 0
//        let yaRow = self.indexs["yaRow"] ?? 0
//        let raRow = self.indexs["raRow"] ?? 0
//        let waRow = self.indexs["waRow"] ?? 0
//        switch label.tag {
//        case 1:
//            if self.customers.count > 0{
//                self.tableView.scrollToRow(at: IndexPath.init(row: 0, section: 0), at: UITableViewScrollPosition.top, animated: true)
//            }
//            break
//        case 2:
//            if  kaRow > 0{
//                self.tableView.scrollToRow(at: IndexPath.init(row: aRow, section: 0), at: UITableViewScrollPosition.top, animated: true)
//            }
//            break
//        case 3:
//            if  saRow > 0{
//                self.tableView.scrollToRow(at: IndexPath.init(row: aRow + kaRow, section: 0), at: UITableViewScrollPosition.top, animated: true)
//            }
//            break
//        case 4:
//            if  taRow > 0{
//                self.tableView.scrollToRow(at: IndexPath.init(row: aRow + kaRow + saRow, section: 0), at: UITableViewScrollPosition.top, animated: true)
//            }
//            break
//        case 5:
//            if  naRow > 0{
//                self.tableView.scrollToRow(at: IndexPath.init(row: aRow + kaRow + saRow + taRow, section: 0), at: UITableViewScrollPosition.top, animated: true)
//            }
//            break
//        case 6:
//            if  haRow > 0{
//                self.tableView.scrollToRow(at: IndexPath.init(row: aRow + kaRow + saRow + taRow+naRow, section: 0), at: UITableViewScrollPosition.top, animated: true)
//            }
//            break
//        case 7:
//            if  maRow > 0{
//                self.tableView.scrollToRow(at: IndexPath.init(row: aRow + kaRow + saRow + taRow+naRow + haRow, section: 0), at: UITableViewScrollPosition.top, animated: true)
//            }
//            break
//        case 8:
//            if  yaRow > 0{
//                self.tableView.scrollToRow(at: IndexPath.init(row: aRow + kaRow + saRow + taRow+naRow + haRow + maRow, section: 0), at: UITableViewScrollPosition.top, animated: true)
//            }
//            break
//        case 9:
//            if  raRow > 0{
//                self.tableView.scrollToRow(at: IndexPath.init(row: aRow + kaRow + saRow + taRow+naRow + haRow + maRow + yaRow, section: 0), at: UITableViewScrollPosition.top, animated: true)
//            }
//            break
//        case 10:
//            if  waRow > 0{
//                self.tableView.scrollToRow(at: IndexPath.init(row: aRow + kaRow + saRow + taRow+naRow + haRow + maRow + yaRow + raRow, section: 0), at: UITableViewScrollPosition.top, animated: true)
//            }
//            break
//        default:
//            break
//        }
//    }
    
}
extension LWChoseCustomerViewController:LWFilterByCharacterViewDelegate{
    func didChangeFilter(filterView: LWFilterByCharacterView, selected: String?) {
        self.filterCharacter = selected
    }
}
