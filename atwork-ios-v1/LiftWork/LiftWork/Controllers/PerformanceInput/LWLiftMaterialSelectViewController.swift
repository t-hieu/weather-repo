//
//  LWLiftMaterialSelectViewController.swift
//  LiftWork
//
//  Created by CuongNV on 5/23/18.
//  Copyright © 2018 Trente. All rights reserved.
//

import UIKit
import TrenteCoreSwift
import ObjectMapper

protocol LWLiftMaterialSelectViewControllerDelegate {
    func liftMaterialSelectTap(liftMaterial: LWGoodModel?, unitQuantity: String,NameOfTypeisSelected : String)
    //Hieu
    func liftMaterialSelectTapMany(liftMaterials: [LWGoodModel], unitQuantity: String,NameOfTypeisSelected : String)
    //End
}

class LWLiftMaterialSelectViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, LWLiftMaterialtCellDelegate, LWViewOneLabelDelegate, KeyboardDelegate {
    
    
    @IBOutlet weak var titleView: LWViewOneLabel!
    
    @IBOutlet weak var unitView: LWUnitQuantityView!
    
    @IBOutlet weak var titleTableView: LWViewOneLabel!
    
    @IBOutlet weak var tableView: UITableView!
    
     @IBOutlet weak var carryintype: LWViewOneLabel!
    
    @IBOutlet weak var CarryInTypeView: LWCarryInTypeView!
    
    var liftMaterials = [LWGoodModel]()
    var construction: LWConstructionModel!
    //Hieu
    var selectedMaterials = [LWGoodModel]()
    //End
    var liftMaterial: LWGoodModel?
    var carries = [LWContructionCarryModel]()
//    var TypeIsSelected = [true,false,false,false]
    var delegate: LWLiftMaterialSelectViewControllerDelegate?
    var inputNumberPad: NumberPadView?
    var customerId: Int?
    var categoryId: Int! = 0
    var constructionId: Int?
    var unitQuantity: String?
    let Equipment = 1
    let Architect = 2
    var carryTypeName:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleView.labTitle.text = NSLocalizedString("lw_button_back", comment: "")
        titleView.delegate = self
        titleTableView.labTitle.text = NSLocalizedString("lw_character_list", comment: "")
        unitView.titlelabel.text = NSLocalizedString("lw_character_unit_quantity", comment: "")
                // set type name
//        self.updateLayout()
        carryintype.labTitle.text = "搬入タイプ"

        tableView.dataSource = self
        tableView.delegate = self
        self.tableView.register(UINib.init(nibName: "LWLiftMaterialCell", bundle: Bundle.init(for: LWLiftMaterialCell.self)), forCellReuseIdentifier: "LWLiftMaterialCell")
        let pickerViewHeight = self.view.frame.size.height/4
        self.inputNumberPad = NumberPadView.init(frame: CGRect(x: self.view.frame.origin.x, y: self.view.frame.origin.y + self.view.frame.size.height - pickerViewHeight, width: self.view.frame.size.width, height: pickerViewHeight))
        self.inputNumberPad?.delegate = self
        self.unitView.contentTextField.inputView = self.inputNumberPad
        
    }

    override func viewWillAppear(_ animated: Bool) {
        self.unitView.contentTextField.text = unitQuantity
        loadLiftMaterials()
    }
    override func viewDidAppear(_ animated: Bool) {
//        self.unitView.contentTextField.text = unitQuantity
//        loadLiftMaterial()
//        self.tableView.reloadData()
        
//        loadLiftMaterials()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    func NameOfTypeIsSelected(TypeIsSelected:[Bool]) ->String {
        var result:String = ""
        if TypeIsSelected[1] == true {
            result = carries[0].carryTypeName!
        }
        if TypeIsSelected[2] == true {
            result = carries[1].carryTypeName!
        }
        if TypeIsSelected[3] == true {
            result = carries[2].carryTypeName!
        }
        return result
    }
    
//    func loadLiftMaterial(){
//        var params = LWParamUtil.initParamsLW()
//        //        params["account"] = self.txfUserId.text
//        //        params["password"] = self.txfPassword.text
//        //        params["company"] = self.txfCompanyId.text
//        self.liftMaterials.removeAll()
//        HTTPRequestManager.getInstance().asyncGET(url: LW_URL_LIFT_MATERIAL_LIST, params: params as [String : AnyObject], isLoading: true, success: {(response) -> Void in
//
//            for res in response["goods"] as! NSArray{
//                let liftMaterial = LWGoodModel.init(response: res as! [String: Any])
//                self.liftMaterials.append(liftMaterial)
//            }
//            self.tableView.reloadData()
//        } )
//    }
    
    func loadLiftMaterials(){
        var params = LWParamUtil.initParamsLW()
        params["customerId"] = self.customerId?.description
        params["siteId"] = self.constructionId?.description
        
        AlamofireManager.shared.request(APIRouter.get(url: API.LW_URL_LIFT_MATERIAL_LIST, params: params, identifier: nil)) { (response) in
            if response != nil{
                self.view.activityIndicatorView.stopAnimating()
                
                guard let goods = Mapper<LWGoodModel>().mapArray(JSONObject: response!["goods"] ), let constructionSite = Mapper<LWConstructionModel>().map(JSONObject: response!["constructionSite"] )
                    else{
                        return
                }
                self.construction = constructionSite
                self.liftMaterials = []
                for good in goods{
                    if(good.status != 0){
                        self.liftMaterials.append(good)
                    }
                }
                
                self.updateCategoryState()
//                self.updateLayout()
                self.tableView.reloadData()
                
            }
            
        }
    }
    
//    func updateLayout(){
    
//        CarryInTypeView.CarryInTypeIsEnable = TypeIsSelected
//        CarryInTypeView.CarryInSwapLable.text = carries[0].carryTypeName
//        CarryInTypeView.CarryInALable.text = carries[1].carryTypeName
//        CarryInTypeView.CarryInBLable.text = carries[2].carryTypeName
//        CarryInTypeView.SwapIsActive = carries[0].status!
//        CarryInTypeView.TypeAIsActive = carries[1].status!
//        CarryInTypeView.TypeBIsActive =  carries[2].status!
        // set active or inactive
//        print(CarryInTypeView.CarryInTypeIsEnable)
//        if CarryInTypeView.TypeAIsActive == false {
//            CarryInTypeView.CarryInALable.textColor = LW_COLOR_BORDER
//        }
//        if CarryInTypeView.SwapIsActive == false {
//            CarryInTypeView.CarryInSwapLable.textColor = LW_COLOR_BORDER
//
//        }
//        if CarryInTypeView.TypeBIsActive == false {
//            CarryInTypeView.CarryInBLable.textColor = LW_COLOR_BORDER
//
//        }
        // save state for carry in type
//        if CarryInTypeView.CarryInTypeIsEnable[0] == true {
//            print(CarryInTypeView.CarryInTypeIsEnable)
//            CarryInTypeView.CarryInNomalChoice.setImage(UIImage(named: "ic_radio_on"), for: .normal)
//        }
//        else {
//            CarryInTypeView.CarryInNomalChoice.setImage(UIImage(named: "ic_radio_off"), for: .normal)
//        }
//        if CarryInTypeView.SwapIsActive == true && CarryInTypeView.CarryInTypeIsEnable[1] == true {
//            CarryInTypeView.CarryInSwapChoice.setImage(UIImage(named: "ic_radio_on"), for: .normal)
//        }
//        else {
//            CarryInTypeView.CarryInSwapChoice.setImage(UIImage(named: "ic_radio_off"), for: .normal)
//        }
//        if CarryInTypeView.TypeAIsActive == true && CarryInTypeView.CarryInTypeIsEnable[2] == true {
//            CarryInTypeView.CarryInAChoice.setImage(UIImage(named: "ic_radio_on"), for: .normal)
//        }
//        else {
//            CarryInTypeView.CarryInAChoice.setImage(UIImage(named: "ic_radio_off"), for: .normal)
//        }
//        if  CarryInTypeView.TypeBIsActive == true && CarryInTypeView.CarryInTypeIsEnable[3] == true {
//            CarryInTypeView.CarryInBChoice.setImage(UIImage(named: "ic_radio_on"), for: .normal)
//        }
//        else {
//            CarryInTypeView.CarryInBChoice.setImage(UIImage(named: "ic_radio_off"), for: .normal)
//        }
//    }
    
    func updateCategoryState(){
        if self.categoryId == 0 || self.categoryId == 3
        {
            
            let carryModel1 = LWContructionCarryModel()
            carryModel1.status = false
            carryModel1.carryTypeName = "盛替"
            carryModel1.categoryId = 0
            let carryModel2 = LWContructionCarryModel()
            carryModel2.status = false
            carryModel2.carryTypeName = "搬入A"
            carryModel2.categoryId = 0
            let carryModel3 = LWContructionCarryModel()
            carryModel3.status = false
            carryModel3.carryTypeName = "搬入B"
            carryModel3.categoryId = 0
            self.carries = [carryModel1,carryModel2,carryModel3]
        }
        if self.categoryId == Equipment
        {
            if self.construction?.carryEquipment != nil {
                self.carries =  (self.construction?.carryEquipment)!
            }
        }
        if self.categoryId == Architect
        {
            if self.construction?.carryArchitect != nil {
                self.carries =  (self.construction?.carryArchitect)!
            }
        }
        
        self.CarryInTypeView.updateChoice(labelText: self.carryTypeName ?? "")
        self.CarryInTypeView.updateActiveChoice(SwapIsActive: self.carries[0].status!, TypeAIsActive: self.carries[1].status!, TypeBIsActive: self.carries[2].status!)
        
    }
    //table view
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "LWLiftMaterialCell") as? LWLiftMaterialCell
        if (cell == nil) {
            cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "LWLiftMaterialCell") as? LWLiftMaterialCell
        }
        cell?.setTextLabelOne(text: self.liftMaterials[indexPath.row*2].goodName!)
        cell?.labelOne.tag = indexPath.row*2
        
        if(self.liftMaterial != nil && self.liftMaterial?.goodId == self.liftMaterials[indexPath.row*2].goodId){
            cell?.labelOne.backgroundColor = LW_COLOR_TITLE_INPUT_PERFORMACE
        }else {
            cell?.labelOne.backgroundColor = LW_COLOR_WHITE
        }
        
        if(indexPath.row*2 + 1 < self.liftMaterials.count){
            cell?.setTextLabelTwo(text: self.liftMaterials[indexPath.row*2 + 1].goodName!)
            cell?.labelTwo.tag = indexPath.row*2+1
            if(self.liftMaterial != nil && self.liftMaterial?.goodId == self.liftMaterials[indexPath.row*2+1].goodId){
                cell?.labelTwo.backgroundColor = LW_COLOR_TITLE_INPUT_PERFORMACE
            }else {
                cell?.labelTwo.backgroundColor = LW_COLOR_WHITE
            }
        }else {
            cell?.setTextLabelTwo(text: "")
        }
        
        
        cell?.delegate = self
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
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

    func setUnitQuantity(unitQuantity: String){
       self.unitQuantity = unitQuantity
    }
    //delegate
    //Hieu
    
    func indexOfGood(goods: [LWGoodModel], good: LWGoodModel) -> Int{
        for index in 0..<goods.count {
            if goods[index].goodId == good.goodId {
                return index
            }
        }
        return -1
    }
    
    func tapLiftMatertial(tag: Int?) {
        //Hieu
        /*
        delegate?.liftMaterialSelectTap(liftMaterial: self.liftMaterials[tag!], unitQuantity: self.unitView.contentTextField.text!, NameOfTypeisSelected:  CarryInTypeView.getLabelChoice())
       
        self.navigationController?.popViewController(animated: false)
        */
        //End
        if tag! >= 0 {
            let index = self.indexOfGood(goods: self.selectedMaterials, good: self.liftMaterials[tag!])
            if index >= 0 {
                self.selectedMaterials.remove(at: index)
            }else {
               self.selectedMaterials.append(self.liftMaterials[tag!])
            }
            
            //self.tableView.reloadData()
        }
    }
    
    func tapViewOneLabelInTime(view: LWViewOneLabel) {
        
    }
    
    func tapViewOneLabelInTitle(view: LWViewOneLabel) {
        //Hieu
        checkMaterialSelected(selectedMaterials: selectedMaterials)
        
        delegate?.liftMaterialSelectTapMany(liftMaterials: self.selectedMaterials,  unitQuantity: self.unitView.contentTextField.text!, NameOfTypeisSelected: CarryInTypeView.getLabelChoice())
        
        self.navigationController?.popViewController(animated: false)
    }
    
    //Hieu
    func checkMaterialSelected(selectedMaterials: [LWGoodModel]){
        let count = selectedMaterials.count
        if count < 1 || count > 3{
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            
            let message = NSLocalizedString("SELECTED_ALERT", comment: "")
            
            let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
            
            alert.addAction(action)
            
            self.present(alert, animated: true, completion: nil)
            return
        }
    }
    
    func changeTextKeyBoard(text: String) {
        self.unitView.contentTextField.text = text
    }
    
    func doneEditing() {
        self.unitView.contentTextField.endEditing(true)
    }
    
}
