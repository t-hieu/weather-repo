//
//  ATPersionInChargeSetting.swift
//  AtworkCore
//
//  Created by Trần Tiến Anh on 11/1/18.
//  Copyright © 2018 Atwork. All rights reserved.
//

import UIKit
import ObjectMapper
import TrenteCoreSwift
class ATPersionInChargeSetting: UIViewController ,UITextFieldDelegate {
    @IBOutlet weak var DecisionChoice: LWRoundedBlueDarkButton!
    @IBOutlet weak var TableView: UITableView!
    let sectionTitle = ["担当者","連絡先"]
    let titleOfSectionPersionInCharge = ["氏名","氏名（読み）"]
    let titleOfSectionContact = ["Eメールアドレス","Mob"]
    var userName:String?
    var userKana:String?
    var userEmail:String?
    var userPhone:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUserInfo()
        
        self.navigationController?.navigationBar.barTintColor = UIColor.orange
        self.navigationController?.navigationBar.isTranslucent = false 
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        self.navigationItem.title = "　　担当者設定"
        let leftBarButton = UIBarButtonItem(title: "＜戻る", style: .plain, target: self, action: #selector(self.tapLeftBarButton))
        leftBarButton.titleTextAttributes(for: .normal)
        leftBarButton.setTitleTextAttributes([NSAttributedStringKey.font: UIFont.boldFont(size: AT_FONT_SIZE_NORMAL)], for: .normal)
        leftBarButton.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItem = leftBarButton
        TableView.register(UINib.init(nibName: "ATPersionInChargeSettingTableViewCell", bundle: Bundle.init(for: LWCellOneLabel.self)), forCellReuseIdentifier: "ATPersionInChargeSettingTableViewCell")
        TableView.dataSource = self
        TableView.delegate = self
        TableView.tableFooterView = UIView()
        TableView.isScrollEnabled = false
        hideKeyboardWhenTappedAround()
        DecisionChoice.layer.backgroundColor = UIColor.orange.cgColor
        DecisionChoice.isEnabled = false
        
        self.userName = ATUserDefaults.getUserName()
        self.userKana = ATUserDefaults.getUserKana()
        self.userPhone = ATUserDefaults.getUserPhone()
        self.userEmail = ATUserDefaults.getUserEmail()
        TableView.separatorStyle = .none
        
    }
   
    @IBAction func DecisionTap(_ sender: Any) {
//        self.DecisionChoice.endEditing(true)
        print("DecisionTap")
        self.view.endEditing(true)
        updatePersionInChageSetting()
    
    }
    @objc func tapLeftBarButton(){
        self.navigationController?.popViewController(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: - Table View

extension ATPersionInChargeSetting : UITableViewDataSource , UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell1 = tableView.dequeueReusableCell(withIdentifier: "ATPersionInChargeSettingTableViewCell") as? ATPersionInChargeSettingTableViewCell
        if (cell1 == nil) {
            cell1 = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "ATPersionInChargeSettingTableViewCell") as? ATPersionInChargeSettingTableViewCell
        }
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                cell1?.Title.text = titleOfSectionPersionInCharge[0]
                cell1?.TextFieldContent.text = userName
                cell1?.TextFieldContent.tag = 0
                cell1?.TextFieldContent.addTarget(self, action: #selector(textFieldDidChange(textField: )), for: .editingChanged)
                
                if #available(iOS 10.0, *) {
                    cell1?.TextFieldContent.textContentType = UITextContentType.name
                } else {
                    // Fallback on earlier versions
                }
                
            }
            if indexPath.row == 1 {
                cell1?.Title.text = titleOfSectionPersionInCharge[1]
                cell1?.TextFieldContent.text = userKana
                
                cell1?.TextFieldContent.tag = 1
                if #available(iOS 10.0, *) {
                    cell1?.TextFieldContent.textContentType = UITextContentType.name
                } else {
                    // Fallback on earlier versions
                }
                cell1?.TextFieldContent.addTarget(self, action: #selector(textFieldDidChange(textField: )), for: .editingChanged)
            }
            
            
            
        }
        if indexPath.section == 1 {
            if indexPath.row == 0 {
                cell1?.Title.text = titleOfSectionContact[0]
                cell1?.TextFieldContent.text = userEmail
                cell1?.TextFieldContent.tag = 2
                if #available(iOS 10.0, *) {
                    cell1?.TextFieldContent.textContentType = UITextContentType.emailAddress
                } else {
                    // Fallback on earlier versions
                }
                cell1?.TextFieldContent.addTarget(self, action: #selector(textFieldDidChange(textField: )), for: .editingChanged)
            }
            if indexPath.row == 1 {
                cell1?.Title.text = titleOfSectionContact[1]
                cell1?.TextFieldContent.text = userPhone
                cell1?.TextFieldContent.tag = 3
                if #available(iOS 10.0, *) {
                    cell1?.TextFieldContent.textContentType = UITextContentType.telephoneNumber
                } else {
                    // Fallback on earlier versions
                }
                cell1?.TextFieldContent.addTarget(self, action: #selector(textFieldDidChange(textField: )), for: .editingChanged)
            }
           
        }
         cell1?.TextFieldContent.delegate = self
        return cell1!
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 16))
        headerView.backgroundColor = AT_COLOR_TITLE_INPUT_PERFORMACE
        let label = UILabel()
        label.frame = CGRect.init(x: 3, y: 5, width: headerView.frame.width-10, height: headerView.frame.height)
        label.font = UIFont.boldFont(size: AT_FONT_SIZE_NORMAL)
        if section == 1 {
            label.text = sectionTitle[1]
        }
        if section == 0 {
            label.text = sectionTitle[0]
        }
        headerView.addSubview(label)
        
        return headerView
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitle[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 2
        }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    }
    // MARK: - Call API
extension ATPersionInChargeSetting  {
    @objc func textFieldDidChange(textField: UITextField){
        if (textField.text?.isEmpty)!  {
            DecisionChoice.isEnabled = false
        }
        let kActualText = (textField.text ?? "")
        switch textField.tag {
        case 0:
            userName = kActualText

        case 1:
            userKana = kActualText
        case 2:
            userEmail = kActualText
        case 3:
            userPhone = kActualText
            
        default:
            print("It is nothing")
        }
        
        if (userEmail != ATUserDefaults.getUserEmail() || userName != ATUserDefaults.getUserName() || userPhone != ATUserDefaults.getUserPhone() || userKana != ATUserDefaults.getUserKana()) {
//             DecisionChoice.isEnabled = true
            if ((userEmail?.count)! > 1 && (userName?.count)! > 1 && (userPhone?.count)! > 1  && (userKana?.count)! > 1 ) {
                
                DecisionChoice.isEnabled = true
            }
            else {
                DecisionChoice.isEnabled = false
            }
        }
        else {
            DecisionChoice.isEnabled = false
        }
        
       
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTag = textField.tag + 1
        if let nextResponder = textField.superview?.viewWithTag(nextTag) {
            nextResponder.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }

    func updatePersionInChageSetting(){
//        DecisionChoice.isEnabled = false
        var params = LWParams.initParamsLW()
        params["key"] = ATUserDefaults.getUserId()
        params["userName"] = self.userName
        params["userKana"] = self.userKana
        params["userEmail"] = self.userEmail
        params["userPhone"] = self.userPhone
        
        AlamofireManager.shared.request(APIRouter.post(url: API.AT_URL_ACCOUNT_UPDATE, params: params, identifier: nil)) { (response) in
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
                        ATUserDefaults.setUserName(val: self.userName!)
                        ATUserDefaults.setUserKana(val: self.userKana! )
                        ATUserDefaults.setUserEmail(val: self.userEmail!)
                        ATUserDefaults.setUserPhone(val: self.userPhone!)
                        self.navigationController?.popViewController(animated: false)
                    }
                
                 
              
           }
        }
    }
    }
    func loadUserInfo()
    {
        var params = LWParams.initParamsLW()
        params["key"] = ATUserDefaults.getUserId()
        AlamofireManager.shared.request(APIRouter.get(url: API.AT_URL_ACCOUNT_USERINFO, params: params, identifier: nil)) { (response) in
            
            if response != nil{
                guard let data = response!["myself"] as? [String: Any],
                    let userModel: ATUserModel = Mapper<ATUserModel>().map(JSON: data)
                    else{
                        return
                }
                self.userName = userModel.userName
                self.userKana = userModel.userNameKana
                self.userEmail = userModel.userEmail
                self.userPhone = userModel.userPhone
                self.TableView.reloadData()
            
        }
    }
}
}
        

    
    

