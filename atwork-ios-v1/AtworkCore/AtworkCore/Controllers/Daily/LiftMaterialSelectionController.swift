//
//  LiftMaterialSelectionController.swift
//  AtworkCore
//
//  Created by CuongNV on 10/9/18.
//  Copyright © 2018 Atwork. All rights reserved.
//

import UIKit
import TrenteCoreSwift
import ObjectMapper


protocol LiftMaterialSelectionDelegate {
    func doneLiftMaterialSelection(liftMaterials: [ATGoodModel])
}

class LiftMaterialSelectionController: UIViewController, UITableViewDelegate, UITableViewDataSource, LWLiftMaterialtCellDelegate {
    @IBOutlet weak var tableView: UITableView!
    var liftMaterials = [ATGoodModel]()
    var liftMaterialChosed = [ATGoodModel]()
    var delegate: LiftMaterialSelectionDelegate!
    var Tile:String?
    @IBAction func DecisionTap(_ sender: Any) {
        delegate?.doneLiftMaterialSelection(liftMaterials: self.liftMaterialChosed)
        self.navigationController?.popViewController(animated: true)
    }
    @IBOutlet weak var labelSettingGood: UILabel!
    var customerId: String!
    var constructionId: Int!
    var currentDate: Date!
    var isCustomerApp: Bool!
    @IBAction func tapChoseGoods(_ sender: Any) {
        if isCustomerApp{
            let vc = ATSettingLiftmaterialController.init(nibName: ATSettingLiftmaterialController.className, bundle: Bundle.init(for: ATSettingLiftmaterialController.self))
            self.navigationController?.pushViewController(vc, animated: false)
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
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        
        self.tableView.register(UINib.init(nibName: "LWLiftMaterialCell", bundle: Bundle.init(for: LWLiftMaterialCell.self)), forCellReuseIdentifier: "LWLiftMaterialCell")
    }

    @objc func tapLeftBarButton(){
//        delegate?.doneLiftMaterialSelection(liftMaterials: self.liftMaterialChosed)
        self.navigationController?.popViewController(animated: true)
    }
    
    func loadGoods(){
        var params = LWParams.initParamsLW()
        params["customerId"] = self.customerId
        params["companyId"] = ATUserDefaults.getCompanyId()        
        AlamofireManager.shared.request(APIRouter.get(url: API.LW_URL_GET_CUSTOMER_GOODS, params: params, identifier: nil)) { (response) in
            if response != nil{
                self.view.activityIndicatorView.stopAnimating()
                
                guard let goods = Mapper<ATGoodModel>().mapArray(JSONObject: response!["selectedGoods"])
                    else{
                        return
                }
                self.liftMaterials = []
                for good in goods{
                    if(good.status != 0){
                        self.liftMaterials.append(good)
                    }
                }
                if (self.liftMaterials.isEmpty && !self.isCustomerApp) {
                    let alertView = UIAlertController(title: "", message: "該当業者にて揚重品目の選択がされていません。該当業者に連絡し基本メニュー→揚重品目設定より設定を行うように連絡してください。（揚重品目の設定がない場合は申請を行うことができません。）", preferredStyle: UIAlertControllerStyle.alert)
                    let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                        self.navigationController?.popViewController(animated: true)
                    }
                    alertView.addAction(okAction)
                    self.present(alertView, animated: true, completion: nil)
                }
                self.tableView.reloadData()
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = Tile
        self.labelSettingGood.isHidden = !self.isCustomerApp
        
    }
    override func viewDidAppear(_ animated: Bool) {
        loadGoods()
        
    }
    

    func indexOfGood(goods: [ATGoodModel], good: ATGoodModel) -> Int{
        for index in 0..<goods.count {
            if goods[index].goodId == good.goodId {
                return index
            }
        }
        return -1
    }
    //table view
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "LWLiftMaterialCell") as? LWLiftMaterialCell
        if (cell == nil) {
            cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "LWLiftMaterialCell") as? LWLiftMaterialCell
        }
        cell?.setTextLabelOne(text: self.liftMaterials[indexPath.row*2].goodName!)
        cell?.labelOne.tag = indexPath.row*2
        if(self.indexOfGood(goods: self.liftMaterialChosed, good: self.liftMaterials[indexPath.row * 2]) >= 0){
            cell?.labelOne.backgroundColor = AT_BUTTON_COLOR1
        }else {
            cell?.labelOne.backgroundColor = AT_COLOR_WHITE
        }
        
        if(indexPath.row*2 + 1 < self.liftMaterials.count){
            cell?.labelTwo.isHidden = false
            cell?.setTextLabelTwo(text: self.liftMaterials[indexPath.row*2 + 1].goodName!)
            cell?.labelTwo.tag = indexPath.row*2+1
            if(self.indexOfGood(goods: self.liftMaterialChosed, good: self.liftMaterials[indexPath.row * 2 + 1]) >= 0){
                cell?.labelTwo.backgroundColor = AT_BUTTON_COLOR1
            }else {
                cell?.labelTwo.backgroundColor = AT_COLOR_WHITE
            }
        }else {
            cell?.labelTwo.isHidden = true
            cell?.labelTwo.tag = -1
        }
        
        cell?.delegate = self
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(self.liftMaterials.count % 2 > 0){
            return self.liftMaterials.count/2 + 1
        }
        return self.liftMaterials.count/2
    }
    
   // delegate
    
    func tapLiftMatertial(tag: Int?) {
        if tag! >= 0 {
            let index = self.indexOfGood(goods: self.liftMaterialChosed, good: self.liftMaterials[tag!])
            if index >= 0 {
                self.liftMaterialChosed.remove(at: index)
            }else {
                self.liftMaterialChosed.append(self.liftMaterials[tag!])
            }
            self.tableView.reloadData()
        }
    }
}
