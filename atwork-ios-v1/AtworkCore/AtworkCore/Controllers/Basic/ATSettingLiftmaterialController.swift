//
//  ATSettingLiftmaterialController.swift
//  AtworkCore
//
//  Created by CuongNV on 11/7/18.
//  Copyright © 2018 Atwork. All rights reserved.
//

import UIKit
import ObjectMapper
import TrenteCoreSwift

class ATSettingLiftmaterialController: UIViewController, UITableViewDelegate, UITableViewDataSource, LWFilterByCharacterViewDelegate {
    
    @IBOutlet weak var sendButton: LWRoundedDarkOrangeButton!
    
//    @IBOutlet weak var row1: LWRowcharacter!
    
    @IBOutlet weak var viewTitleTable: UIView!
    
    @IBOutlet weak var viewTitle: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var filterView: LWFilterByCharacterView!
    
    
    @IBAction func actionSend(_ sender: Any) {
        if goodsChose.count == 0 {
            let alertView = UIAlertController(title: "", message: "揚重品目は一つ以上選択して下さい", preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: .destructive, handler:nil)
            alertView.addAction(okAction)
            present(alertView, animated: true, completion: nil)
            return
        }
        
        self.updateGoods()
    }
    
    var delegate: LWChoseConstructionViewDelegate!
    var labelchose: UILabel!
    var goods = [ATGoodModel]()
    var goodsKana = [String]()
    var goodsChose = [ATGoodModel]()
    var indexKeyChose: Int! = -1
    var nameKanaChose: String! = ""
    
    var indexs:[String:Int] = [:]
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
        
        self.navigationItem.title = "揚重品目設定"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        
        self.viewTitle.backgroundColor = AT_COLOR_TITLE_INPUT_PERFORMACE
        self.viewTitleTable.backgroundColor = AT_COLOR_TITLE_INPUT_PERFORMACE
        self.viewTitleTable.layer.borderWidth = 1
        self.viewTitleTable.layer.borderColor = AT_COLOR_BORDER.cgColor
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
        self.tableView.register(UINib.init(nibName: "LWCellOneLabel", bundle: Bundle.init(for: LWCellOneLabel.self)), forCellReuseIdentifier: "LWCellOneLabel")
        self.tableView.register(UINib.init(nibName: "ChoseGoodViewCell", bundle: Bundle.init(for: ChoseGoodViewCell.self)), forCellReuseIdentifier: "ChoseGoodViewCell")
        
        self.view.activityIndicatorView.startAnimating()
        self.filterView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        self.loadGoods()
        
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
    
    func loadGoods(){
        var params = LWParams.initParamsLW()
        params["customerId"] = ATUserDefaults.getCustomerId()
        params["companyId"] = ATUserDefaults.getCompanyId()   
        
        AlamofireManager.shared.request(APIRouter.get(url: API.LW_URL_GET_CUSTOMER_GOODS, params: params, identifier: nil)) { (response) in
            if response != nil{
                self.view.activityIndicatorView.stopAnimating()
                
                guard let goods = Mapper<ATGoodModel>().mapArray(JSONObject: response!["goods"] ), let selectedGoods = Mapper<ATGoodModel>().mapArray(JSONObject: response!["selectedGoods"])
                    else{
                        return
                }
                
                self.goods = []
                for good in goods{
                    if(good.status != 0){
                        self.goods.append(good)
                    }
                }
                
                self.goodsChose = []
                for good in selectedGoods{
                    if(good.status != 0){
                        self.goodsChose.append(good)
                    }
                }
                
                self.indexConstructions()
                //                self.filterConstruction(key:self.filterCharacter)
                self.tableView.reloadData()
            }
        }
    }
    
    func updateGoods(){
        var params = LWParams.initParamsLW()
        params["customerId"] = ATUserDefaults.getCustomerId()
        var strGoodIds = ""
        for good in self.goodsChose {
            strGoodIds += (good.goodId?.description)! + ","
        }
        params["strGoodIds"] = strGoodIds
        
        AlamofireManager.shared.request(APIRouter.post(url: API.LW_URL_UPDATE_CUSTOMER_GOODS, params: params, identifier: nil)) { (response) in
            if response != nil{
                self.view.activityIndicatorView.stopAnimating()
                self.navigationController?.popViewController(animated: true)
//                self.showError(responseObject: response! as NSDictionary?)
            }
        }
    }
    
    func showError(responseObject: NSDictionary?) {
        
        if let response  = responseObject,var messages = response["messages"] as? String,!messages.isEmpty{
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
    }
    
    func getIndexGood(goods: [ATGoodModel], goodId: Int) -> Int {
        for index in 0..<goods.count {
            if goods[index].goodId == goodId {
                return index
            }
        }
        return -1
    }
    
    //tableview
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.goods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell1 = tableView.dequeueReusableCell(withIdentifier: "ChoseGoodViewCell") as? ChoseGoodViewCell
        if (cell1 == nil) {
            cell1 = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "ChoseGoodViewCell") as? ChoseGoodViewCell
        }
        cell1?.valueLabel.text = self.goods[indexPath.row].goodName
        cell1?.statusLabel.text = self.goodsKana[indexPath.row]
        if self.getIndexGood(goods: self.goodsChose, goodId: self.goods[indexPath.row].goodId!) != -1 {
            cell1?.checkImage.image = UIImage.init(named: "cs_box_check_on")
        }else{
            cell1?.checkImage.image = UIImage.init(named: "cs_box_check_off")
        }
        if(indexPath.row == self.indexKeyChose) {
            cell1?.contentView.backgroundColor = AT_BUTTON_COLOR1
        }else {
            cell1?.contentView.backgroundColor = UIColor.clear
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
//        self.delegate?.tapChoseConstructionView(construction: self.constructions[indexPath.row])
//        comeback()
        let index = self.getIndexGood(goods: self.goodsChose, goodId: self.goods[indexPath.row].goodId!)
        if index != -1 {
            self.goodsChose.remove(at: index)
        }else {
            self.goodsChose.append(self.goods[indexPath.row])
        }
        tableView.reloadData()
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
        
        for good in self.goods{
            let key = good.goodNameKana ?? ""
            
            if self.checkIndex(key: key, rows: aRows, index: "aRow"){
                self.goodsKana.append(rows[0])
                continue
            }else if self.checkIndex(key: key, rows: kaRows, index: "kaRow"){
                self.goodsKana.append(rows[1])
                continue
            }else if self.checkIndex(key: key, rows: saRows, index: "saRow"){
                self.goodsKana.append(rows[2])
                continue
            }else if self.checkIndex(key: key, rows: taRows, index: "taRow"){
                self.goodsKana.append(rows[3])
                continue
            }else if self.checkIndex(key: key, rows: naRows, index: "naRow"){
                self.goodsKana.append(rows[4])
                continue
            }else if self.checkIndex(key: key, rows: haRows, index: "haRow"){
                self.goodsKana.append(rows[5])
                continue
            }else if self.checkIndex(key: key, rows: maRows, index: "maRow"){
                self.goodsKana.append(rows[6])
                continue
            }else if self.checkIndex(key: key, rows: yaRows, index: "yaRow"){
                self.goodsKana.append(rows[7])
                continue
            }else if self.checkIndex(key: key, rows: raRows, index: "raRow"){
                self.goodsKana.append(rows[8])
                continue
            }else if self.checkIndex(key: key, rows: waRows, index: "waRow"){
                self.goodsKana.append(rows[9])
                continue
            }else {
                self.goodsKana.append("")
                if self.nameKanaChose.elementsEqual(""){
                    self.indexs["aRow"] = self.indexs["aRow"]! + 1
                }else {
                    self.indexs[self.nameKanaChose] = self.indexs[self.nameKanaChose]! + 1
                }
            }
        }
        
        if self.goodsKana.count > 0 {
            var key = self.goodsKana[0]
            for index in 1..<self.goodsKana.count {
                if self.goodsKana[index].elementsEqual(key) {
                    self.goodsKana[index] = ""
                }else {
                    key = self.goodsKana[index]
                }
            }
        }
        print(self.indexs)
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
