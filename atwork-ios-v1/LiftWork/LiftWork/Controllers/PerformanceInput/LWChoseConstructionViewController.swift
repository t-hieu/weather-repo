//
//  LWChoseConstructionViewController.swift
//  LiftWork
//
//  Created by CuongNV on 5/16/18.
//  Copyright © 2018 Trente. All rights reserved.
//

import UIKit
import TrenteCoreSwift
import ObjectMapper

protocol LWChoseConstructionViewDelegate {
    func tapChoseConstructionView(construction: LWConstructionModel)
}

class LWChoseConstructionViewController: LWBaseViewController , UITableViewDataSource, UITableViewDelegate, LWViewOneLabelDelegate{

    @IBOutlet weak var filterView: LWFilterByCharacterView!
    @IBOutlet weak var infomationView: LWViewOneLabel!
    @IBOutlet weak var titleList: LWViewOneLabel!
    @IBOutlet weak var tableView: UITableView!
    
    var delegate: LWChoseConstructionViewDelegate?
    var labelchose: UILabel!
    var constructions = [LWConstructionModel]()
    var construction: LWConstructionModel?
    
//    var indexs:[String:Int] = [:]
    internal var displayConstructions:[LWConstructionModel] = []
    internal var filterCharacter:String?{
        didSet{
            self.filterConstruction(key: filterCharacter)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.infomationView.labTitle.text = NSLocalizedString("lw_button_back", comment: "")
        self.infomationView.delegate = self
        
        titleList.labTitle.text = NSLocalizedString("lw_character_construction_select_list", comment: "")
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.register(UINib.init(nibName: "LWCellOneLabel", bundle: Bundle.init(for: LWCellOneLabel.self)), forCellReuseIdentifier: "LWCellOneLabel")
        
        self.view.activityIndicatorView.startAnimating()
        self.filterView.delegate = self
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
    
    private func checkIndex(item:LWConstructionModel,rows:[String])->Bool{
        let key  = item.constructionKana ?? ""
        for row in rows{
            if key.hasPrefix(row){
                return true
            }
        }
        return false
    }
    
    private func filterConstruction(key:String?){
        var filterArrays:[LWConstructionModel] = []
        for construction in self.constructions{
//            let rows = ["あ","か","さ","た","な","は","ま","や","ら","わ"]
            switch key{
            case "あ"?:
                if self.checkIndex(item: construction, rows: aRows){
                    filterArrays.append(construction)
                }
                break
            case "か"?:
                if self.checkIndex(item: construction, rows: kaRows){
                    filterArrays.append(construction)
                }
                break
            case "さ"?:
                if self.checkIndex(item: construction, rows: saRows){
                    filterArrays.append(construction)
                }
                break
            case "た"?:
                if self.checkIndex(item: construction, rows: taRows){
                    filterArrays.append(construction)
                }
                break
            case "な"?:
                if self.checkIndex(item: construction, rows: naRows){
                    filterArrays.append(construction)
                }
                break
            case "は"?:
                if self.checkIndex(item: construction, rows: haRows){
                    filterArrays.append(construction)
                }
                break
            case "ま"?:
                if self.checkIndex(item: construction, rows: maRows){
                    filterArrays.append(construction)
                }
                break
            case "や"?:
                if self.checkIndex(item: construction, rows: yaRows){
                    filterArrays.append(construction)
                }
                break
            case "ら"?:
                if self.checkIndex(item: construction, rows: raRows){
                    filterArrays.append(construction)
                }
                break
            case "わ"?:
                if self.checkIndex(item: construction, rows: waRows){
                    filterArrays.append(construction)
                }
                break
            default:
                filterArrays = self.constructions
                break
            }
            
        }
        self.displayConstructions = filterArrays
        self.tableView.reloadData()
        self.perform(#selector(scrollToTop), with: nil, afterDelay: 1)
    }
    @objc func scrollToTop(){
        self.tableView.scrollsToTop = true
    }
    
//    private func indexConstructions(){
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
//        for construction in self.constructions{
//            let key = construction.constructionKana ?? ""
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
//            }
//        }
//        print(self.indexs)
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadConStructions()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func loadConStructions(){
        let params = LWParamUtil.initParamsLW()
        
        AlamofireManager.shared.request(APIRouter.get(url: API.LW_URL_CONSTRUCTION_LIST, params: params, identifier: nil)) { (response) in
            if response != nil{
                self.view.activityIndicatorView.stopAnimating()
                
                guard let constructions = Mapper<LWConstructionModel>().mapArray(JSONObject: response!["constructions"] )
                    else{
                        return
                }
                
                self.constructions = []
                for construction in constructions{
                    if(construction.status != 0){
                        self.constructions.append(construction)
                    }
                   
                }
                
//                self.indexConstructions()
                self.filterConstruction(key:self.filterCharacter)
                self.tableView.reloadData()
                
            }
            
        }

    }

    //tableview
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.displayConstructions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell1 = tableView.dequeueReusableCell(withIdentifier: "LWCellOneLabel") as? LWCellOneLabel
        if (cell1 == nil) {
            cell1 = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "LWCellOneLabel") as? LWCellOneLabel
        }
        cell1?.label.text = self.displayConstructions[indexPath.row].constructionName
        if(self.construction != nil && self.construction?.key == self.displayConstructions[indexPath.row].key){
            cell1?.backgroundColor = LW_COLOR_TITLE_INPUT_PERFORMACE
        }else{
            cell1?.backgroundColor = UIColor.clear
        }
        return cell1!
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.00001
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.tapChoseConstructionView(construction: self.displayConstructions[indexPath.row])
        comeback()
    }
    
    func comeback(){
        //        self.navigationController?.popViewController(animated: true)
        self.navigationController?.popViewController(animated: true)
       
    }

    func tapViewOneLabelInTitle(view: LWViewOneLabel) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func tapViewOneLabelInTime(view: LWViewOneLabel) {
        
    }
    
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
//            if self.constructions.count > 0{
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

extension LWChoseConstructionViewController:LWFilterByCharacterViewDelegate{
    func didChangeFilter(filterView: LWFilterByCharacterView, selected: String?) {
        self.filterCharacter = selected
    }
}
