//
//  TransportVehicleController.swift
//  AtworkCore
//
//  Created by CuongNV on 10/10/18.
//  Copyright © 2018 Atwork. All rights reserved.
//

import UIKit
import TrenteCoreSwift

protocol TransportVehicleControllerDelegate {
    func doneChoseTransport(Vehicles: [VehicleModel])
}
class TransportVehicleController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate{
    var texttitle:String?
    var currentDate: Date!
    @IBAction func tapDone(_ sender: Any) {
        self.view.endEditing(true)
        delegate.doneChoseTransport(Vehicles: self.vehicles)
        comeback()
    }
    @IBOutlet weak var tableView: UITableView!
    var vehicles = [VehicleModel]()
//    var vehiclesChose = [VehicleModel]()
//    var vehicleID : VehicleModel!
//    var number: Int!
    var delegate: TransportVehicleControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barTintColor = UIColor.orange
        self.navigationController?.navigationBar.isTranslucent = false 
        let leftBarButton = UIBarButtonItem(title: "＜戻る", style: .plain, target: self, action: #selector(self.tapLeftBarButton))
        leftBarButton.titleTextAttributes(for: .normal)
        leftBarButton.setTitleTextAttributes([NSAttributedStringKey.font: UIFont.boldFont(size: AT_FONT_SIZE_NORMAL)], for: .normal)
        leftBarButton.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItem = leftBarButton
        
        self.navigationItem.title = texttitle
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
        
//        self.tableView.register(UINib.init(nibName: "LWCellOneLabel", bundle: Bundle.init(for: LWCellOneLabel.self)), forCellReuseIdentifier: "LWCellOneLabel")
        self.tableView.register(UINib.init(nibName: "VerhicleViewCell", bundle: Bundle.init(for: VerhicleViewCell.self)), forCellReuseIdentifier: "VerhicleViewCell")
    }
    
    func setData(vehicles: [VehicleModel], vehicleChose: [VehicleModel]){
        self.vehicles = [VehicleModel]()
        for vehicle in vehicles {
            let vehicleTemp = VehicleModel.init().copyOther(vehicle: vehicle)
            vehicleTemp.number = 0
            for vehicle1 in vehicleChose {
                if vehicle.key == vehicle1.key{
                    vehicleTemp.number = vehicle1.number
                }
            }
            self.vehicles.append(vehicleTemp)
        }
    }
    
    @objc func tapLeftBarButton(){
        self.navigationController?.popViewController(animated: true)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        self.navigationItem.title = TRFormatUtil.formatDateCustom(date: self.currentDate, format: "yyyy年M月d日 申請フォーム")
    }
    
    //tableview
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if(section == 1) {return 1}
        return self.vehicles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if(indexPath.section == 0){
        var cell = tableView.dequeueReusableCell(withIdentifier: "VerhicleViewCell") as? VerhicleViewCell
        if (cell == nil) {
            cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "VerhicleViewCell") as? VerhicleViewCell
        }
        cell?.titleLabel.text = self.vehicles[indexPath.row].value
        cell?.numTextField.tag = Int(indexPath.row)
        cell?.numTextField.delegate = self
        cell?.numTextField.text = String(self.vehicles[indexPath.row].number)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
////        self.delegate.doneELVSelection(lift: self.elvList[indexPath.row])
////        comeback()
////        self.
//        self.vehicleID = self.vehicles[indexPath.row]
//    }
    
    func comeback(){
        self.navigationController?.popViewController(animated: true)
    }

    @objc func textFieldDidChange(textField: UITextField) {
//        if(textField.text?.isEmpty)!{
//            textField.backgroundColor = AT_COLOR_WHITE
//        }else {
//            textField.backgroundColor = AT_FILL_IN_TEXTFIELD
//        }
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        animateView(isUp: true)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        animateView(isUp: false)
        if(textField.text?.isEmpty)!{
//            textField.backgroundColor = AT_COLOR_WHITE
            self.vehicles[textField.tag].number = 0
        }else {
//            textField.backgroundColor = AT_FILL_IN_TEXTFIELD
            self.vehicles[textField.tag].number = Int(textField.text!)
        }
        self.tableView.reloadData()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        if textField.text == "0"{
            textField.text = ""
        }
        let count = text.count + string.count - range.length
        return count <= 2
    }
    
    
}


