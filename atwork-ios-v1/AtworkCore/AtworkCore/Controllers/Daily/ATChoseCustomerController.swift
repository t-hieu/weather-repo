//
//  ATChoseCustomerController.swift
//  AtworkCore
//
//  Created by CuongNV on 11/16/18.
//  Copyright © 2018 Atwork. All rights reserved.
//

import UIKit
import ObjectMapper
import TrenteCoreSwift

protocol ATChoseCustomerControllerDelegate {
    func doneChoseCustomer(customer: ATCustomerModel)
}

class ATChoseCustomerController: UIViewController, UITableViewDelegate, UITableViewDataSource, LWFilterByCharacterViewDelegate {
    var Title: String?
    @IBOutlet weak var viewTitleTable: UIView!
    @IBOutlet weak var viewTitle: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var filterView: LWFilterByCharacterView!
    
    var delegate: ATChoseCustomerControllerDelegate!
    var labelchose: UILabel!
    var currentDate: Date!
    var customers = [ATCustomerModel]()
    var customersKey = [String]()
    var customer: ATCustomerModel!
    var indexKeyChose: Int! = -1
    var nameKanaChose: String! = ""
    
    var indexs:[String:Int] = [:]
    //    internal var displayConstructions:[ATConstructionModel] = []
    internal var filterCharacter:String?{
        didSet{
            self.filterConstruction(key: filterCharacter)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barTintColor = UIColor.orange
        self.navigationController?.navigationBar.isTranslucent = false 
        let leftBarButton = UIBarButtonItem(title: "＜戻る", style: .plain, target: self, action: #selector(self.tapLeftBarButton))
        leftBarButton.titleTextAttributes(for: .normal)
        leftBarButton.setTitleTextAttributes([NSAttributedStringKey.font: UIFont.boldFont(size: AT_FONT_SIZE_NORMAL)], for: .normal)
        leftBarButton.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItem = leftBarButton
        
        self.navigationItem.title = "現場選択"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        
        self.viewTitle.backgroundColor = AT_COLOR_TITLE_INPUT_PERFORMACE
        
        self.viewTitleTable.backgroundColor = AT_COLOR_TITLE_INPUT_PERFORMACE
        self.viewTitleTable.layer.borderWidth = 1
        self.viewTitleTable.layer.borderColor = AT_COLOR_BORDER.cgColor
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
        
        self.tableView.register(UINib.init(nibName: "LWCellOneLabel", bundle: Bundle.init(for: LWCellOneLabel.self)), forCellReuseIdentifier: "LWCellOneLabel")
        self.tableView.register(UINib.init(nibName: "ChoseItemViewCell", bundle: Bundle.init(for: ChoseItemViewCell.self)), forCellReuseIdentifier: "ChoseItemViewCell")
        
        self.view.activityIndicatorView.startAnimating()
        self.filterView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.title = Title
        self.loadConStructions()
    }
    
    @objc func tapLeftBarButton(){
        self.navigationController?.popViewController(animated: true)
        
    }
    private func checkIndex(item:ATConstructionModel,rows:[String])->Bool{
        let key  = item.constructionKana ?? ""
        for row in rows{
            if key.hasPrefix(row){
                return true
            }
        }
        return false
    }
    
    @objc func scrollToTop(){
        self.tableView.scrollsToTop = true
    }
    
    func loadConStructions(){
        var params = LWParams.initParamsLW()
        params["siteId"] = ATUserDefaults.getConstructionId()
        AlamofireManager.shared.request(APIRouter.get(url: API.LW_URL_CUSTOMER_LIST, params: params, identifier: nil)) { (response) in
            if response != nil{
                self.view.activityIndicatorView.stopAnimating()
                
                guard let customers = Mapper<ATCustomerModel>().mapArray(JSONObject: response!["customers"] )
                    else{
                        return
                }
                self.customers = []
                for customer in customers{
                    if(customer.status != 0){
                        self.customers.append(customer)
                    }
                }
                self.indexConstructions()
                self.tableView.reloadData()
            }
        }
    }
    
    //tableview
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.customers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell1 = tableView.dequeueReusableCell(withIdentifier: "ChoseItemViewCell") as? ChoseItemViewCell
        if (cell1 == nil) {
            cell1 = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "ChoseItemViewCell") as? ChoseItemViewCell
        }
        cell1?.valueLabel.text = self.customers[indexPath.row].customerName
        cell1?.statusLabel.text = self.customersKey[indexPath.row]
        if(self.customer != nil && self.customer?.customerId == self.customers[indexPath.row].customerId){
            cell1?.valueView.backgroundColor = AT_BUTTON_COLOR1
        }else{
            cell1?.valueView.backgroundColor = AT_COLOR_WHITE
        }
        if(indexPath.row == self.indexKeyChose) {
            cell1?.statusView.backgroundColor = AT_BUTTON_COLOR1
        }else {
            cell1?.statusView.backgroundColor = AT_COLOR_WHITE
        }
        return cell1!
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.00001
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.doneChoseCustomer(customer: self.customers[indexPath.row])
        comeback()
    }
    
    func comeback(){
        //        self.navigationController?.popViewController(animated: true)
        self.navigationController?.popViewController(animated: false)
    }
    
    func didChangeFilter(filterView: LWFilterByCharacterView, selected: String?) {
        self.filterCharacter = selected
    }
    
    //scroll to
    private func checkIndex(key:String,rows:[String],index:String)->Bool{
        for row in rows{
            if key.hasPrefix(row){
                self.nameKanaChose = index
                self.indexs[index]  = self.indexs[index]! + 1
                return true
            }
        }
        return false
    }
    
    private func indexConstructions(){
        self.nameKanaChose = ""
        self.indexs = [
            "aRow":0,
            "kaRow":0,
            "saRow":0,
            "taRow":0,
            "naRow":0,
            "haRow":0,
            "maRow":0,
            "yaRow":0,
            "raRow":0,
            "waRow":0
        ]
        
        for customer in self.customers{
            let key = customer.customerNameKana ?? ""
            
            if self.checkIndex(key: key, rows: aRows, index: "aRow"){
                self.customersKey.append(rows[0])
                continue
            }else if self.checkIndex(key: key, rows: kaRows, index: "kaRow"){
                self.customersKey.append(rows[1])
                continue
            }else if self.checkIndex(key: key, rows: saRows, index: "saRow"){
                self.customersKey.append(rows[2])
                continue
            }else if self.checkIndex(key: key, rows: taRows, index: "taRow"){
                self.customersKey.append(rows[3])
                continue
            }else if self.checkIndex(key: key, rows: naRows, index: "naRow"){
                self.customersKey.append(rows[4])
                continue
            }else if self.checkIndex(key: key, rows: haRows, index: "haRow"){
                self.customersKey.append(rows[5])
                continue
            }else if self.checkIndex(key: key, rows: maRows, index: "maRow"){
                self.customersKey.append(rows[6])
                continue
            }else if self.checkIndex(key: key, rows: yaRows, index: "yaRow"){
                self.customersKey.append(rows[7])
                continue
            }else if self.checkIndex(key: key, rows: raRows, index: "raRow"){
                self.customersKey.append(rows[8])
                continue
            }else if self.checkIndex(key: key, rows: waRows, index: "waRow"){
                self.customersKey.append(rows[9])
                continue
            }else {
                self.customersKey.append("")
                if self.nameKanaChose.elementsEqual(""){
                    self.indexs["aRow"] = self.indexs["aRow"]! + 1
                }else {
                    self.indexs[self.nameKanaChose] = self.indexs[self.nameKanaChose]! + 1
                }
            }
        }
        
        if self.customersKey.count > 0 {
            var key = self.customersKey[0]
            for index in 1..<self.customersKey.count {
                if self.customersKey[index].elementsEqual(key) {
                    self.customersKey[index] = ""
                }else {
                    key = self.customersKey[index]
                }
            }
        }
        //            print(self.indexs)
    }
    
    
    private func filterConstruction(key:String?){
        let aRow = self.indexs["aRow"] ?? 0
        let kaRow = self.indexs["kaRow"] ?? 0
        let saRow = self.indexs["saRow"] ?? 0
        let taRow = self.indexs["taRow"] ?? 0
        let naRow = self.indexs["naRow"] ?? 0
        let haRow = self.indexs["haRow"] ?? 0
        let maRow = self.indexs["maRow"] ?? 0
        let yaRow = self.indexs["yaRow"] ?? 0
        let raRow = self.indexs["raRow"] ?? 0
        let waRow = self.indexs["waRow"] ?? 0
        self.indexKeyChose = -1
        switch key{
        case rows[0]:
            if aRow > 0{
//                self.tableView.scrollToRow(at: IndexPath.init(row: 0, section: 0), at: UITableViewScrollPosition.top, animated: true)
                self.indexKeyChose = 0
            }
            
            break
        case rows[1]:
            if  kaRow > 0{
//                self.tableView.scrollToRow(at: IndexPath.init(row: aRow, section: 0), at: UITableViewScrollPosition.top, animated: true)
                self.indexKeyChose = aRow
            }
            
            break
        case rows[2]:
            if  saRow > 0{
//                self.tableView.scrollToRow(at: IndexPath.init(row: aRow + kaRow, section: 0), at: UITableViewScrollPosition.top, animated: true)
                self.indexKeyChose = aRow + kaRow
            }
            
            break
        case rows[3]:
            if  taRow > 0{
//                self.tableView.scrollToRow(at: IndexPath.init(row: aRow + kaRow + saRow, section: 0), at: UITableViewScrollPosition.top, animated: true)
                self.indexKeyChose = aRow + kaRow + saRow
            }
            
            break
        case rows[4]:
            if  naRow > 0{
//                self.tableView.scrollToRow(at: IndexPath.init(row: aRow + kaRow + saRow + taRow, section: 0), at: UITableViewScrollPosition.top, animated: true)
                self.indexKeyChose = aRow + kaRow + saRow + taRow
            }
            
            break
        case rows[5]:
            if  haRow > 0{
//                self.tableView.scrollToRow(at: IndexPath.init(row: aRow + kaRow + saRow + taRow+naRow, section: 0), at: UITableViewScrollPosition.top, animated: true)
                self.indexKeyChose = aRow + kaRow + saRow + taRow + naRow
            }
            
            break
        case rows[6]:
            if  maRow > 0{
//                self.tableView.scrollToRow(at: IndexPath.init(row: aRow + kaRow + saRow + taRow+naRow + haRow, section: 0), at: UITableViewScrollPosition.top, animated: true)
                self.indexKeyChose = aRow + kaRow + saRow + taRow + naRow + haRow
            }
            //                self.indexKeyChose = aRow + kaRow + saRow + taRow + naRow + haRow
            break
        case rows[7]:
            if  yaRow > 0{
//                self.tableView.scrollToRow(at: IndexPath.init(row: aRow + kaRow + saRow + taRow+naRow + haRow + maRow, section: 0), at: UITableViewScrollPosition.top, animated: true)
                self.indexKeyChose = aRow + kaRow + saRow + taRow + naRow + haRow + maRow
            }
            //                self.indexKeyChose = aRow + kaRow + saRow + taRow + naRow + haRow + maRow
            break
        case rows[8]:
            if  raRow > 0{
//                self.tableView.scrollToRow(at: IndexPath.init(row: aRow + kaRow + saRow + taRow+naRow + haRow + maRow + yaRow, section: 0), at: UITableViewScrollPosition.top, animated: true)
                self.indexKeyChose = aRow + kaRow + saRow + taRow + naRow + haRow + maRow + yaRow
                
            }
            break
        case rows[9]:
            if  waRow > 0{
//                self.tableView.scrollToRow(at: IndexPath.init(row: aRow + kaRow + saRow + taRow+naRow + haRow + maRow + yaRow + raRow, section: 0), at: UITableViewScrollPosition.top, animated: true)
                self.indexKeyChose = aRow + kaRow + saRow + taRow + naRow + haRow + maRow + yaRow + raRow
            }
            
            break
        default:
            break
        }
        self.tableView.reloadData()
        if self.indexKeyChose >= 0 {
            self.tableView.scrollToRow(at: IndexPath.init(row: self.indexKeyChose, section: 0), at: UITableViewScrollPosition.top, animated: true)
        }
    }
}
