//
//  ATSignInViewController.swift
//  AtworkCore
//
//  Created by CuongNV on 11/6/18.
//  Copyright © 2018 Atwork. All rights reserved.
//

import UIKit
import TrenteCoreSwift
import ObjectMapper
import Alamofire
import Firebase

public class ATSignInViewController: ATBaseViewController {
    @IBAction func saveAccount(_ sender: Any) {
        toggleCheckbox()
    }
    @IBOutlet weak var lbSave: LWBlackNormalRegularLabel!
    var show = true
    @IBOutlet weak var Image: UIImageView!
    @IBOutlet weak var txfCompanyId: LWRoundedTextField!
    @IBOutlet weak var txfUserId: LWRoundedTextField!
    @IBOutlet weak var txfPassword: LWRoundedTextField!
    @IBOutlet weak var btSignIn: LWRoundedLightBlueButton!
    
    @IBOutlet weak var saveAccButton: UIButton!
    
    @IBOutlet weak var saveAccView: UIView!
    
    
    @IBAction func signIn(_ sender: Any) {
        self.view.endEditing(true)
        signInClick()
    }
    
    var account: ATAccountModel!
    
    @IBOutlet weak var regiterButton: UIButton!
    @IBAction func registerAccount(_ sender: Any) {
        let inputCompany = ATInputCompanyCodeController.init(nibName: ATInputCompanyCodeController.className, bundle: Bundle.init(for: ATInputCompanyCodeController.self))
        self.navigationController?.pushViewController(inputCompany, animated: true)
    }
    var isCheck: Bool!
    override public func viewDidLoad() {
        super.viewDidLoad()
        if ATUserDefaults.getCustomerUserFlag().elementsEqual("1") {
            self.regiterButton.isHidden = false
        }else {
            //pro
            self.regiterButton.isHidden = true
            self.txfCompanyId.placeholder = "会社ID"
            self.lbSave.text = "会社ID、ユーザーIDを保存する"
            
        }
        self.Image.image = UIImage(named: "ic_logo")
        btSignIn.dependsOn(textFields: [txfCompanyId, txfUserId, txfPassword])
        
        
        txfCompanyId.addTarget(self, action: #selector(textFieldDidChange(textField: )), for: .editingChanged)
        txfUserId.addTarget(self, action: #selector(textFieldDidChange(textField: )), for: .editingChanged)
        txfPassword.addTarget(self, action: #selector(textFieldDidChange(textField: )), for: .editingChanged)
        
        //        isCheck = false
        self.txfCompanyId.delegate = self
        self.txfCompanyId.font = UIFont.systemFont(ofSize: AT_FONT_SIZE_NORMAL)
        self.txfUserId.delegate = self
        self.txfUserId.font = UIFont.systemFont(ofSize: AT_FONT_SIZE_NORMAL)
        self.txfPassword.delegate = self
        self.txfPassword.font = UIFont.systemFont(ofSize: AT_FONT_SIZE_NORMAL)
        
//        let singleTap = UITapGestureRecognizer(target: self, action:#selector(handleSavePass(sender:)))
//        saveAccView.addGestureRecognizer(singleTap)
        isCheck = ATUserDefaults.getBoolean(key: "IS_SAVE_ACC")
        if (isCheck) {
            saveAccButton.setImage(UIImage(named: "cs_box_check_on"), for: .normal)
            self.txfUserId.text = ATUserDefaults.getUserAccount()
            self.txfCompanyId.text = ATUserDefaults.get(key: "USER_CODE")
            self.textFieldDidChange(textField: self.txfUserId)
            self.textFieldDidChange(textField: self.txfCompanyId)
        }else {
            saveAccButton.setImage(UIImage(named: "cs_box_check_off"), for: .normal)
        }
        
        if self.account != nil {
            self.txfUserId.text = self.account.account
            self.txfCompanyId.text = self.account.companyCode
            self.txfPassword.text = self.account.password
            self.textFieldDidChange(textField: self.txfUserId)
            self.textFieldDidChange(textField: self.txfCompanyId)
            self.textFieldDidChange(textField: self.txfPassword)
            self.btSignIn.isEnabled = true
        }
//        NotificationCenter.default.addObserver(self,
//                                               selector: #selector(self.keyboardWillShowForResizing),
//                                               name: Notification.Name.UIKeyboardWillShow,
//                                               object: nil)
//        NotificationCenter.default.addObserver(self,
//                                               selector: #selector(self.keyboardWillHideForResizing),
//                                               name: Notification.Name.UIKeyboardWillHide,
//                                               object: nil)
    }
    
    
//    @objc func handleSavePass(sender: UITapGestureRecognizer) {
//        toggleCheckbox()
//    }
    
    func toggleCheckbox(){
        if (isCheck) {
            isCheck = false
            saveAccButton.setImage(UIImage(named: "cs_box_check_off"), for: .normal)
        } else {
            isCheck = true
            saveAccButton.setImage(UIImage(named: "cs_box_check_on"), for: .normal)
        }
        ATUserDefaults.setBoolean(key: "IS_SAVE_ACC", val: isCheck)
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func signInClick() -> Void{
        
        var params = LWParams.initParamsLW()
        params["account"] = self.txfUserId.text
        params["password"] = self.txfPassword.text
        params["company"] = self.txfCompanyId.text
        params["customerUserFlag"] = ATUserDefaults.getCustomerUserFlag()
        params["deviceRegistrationId"] = Messaging.messaging().fcmToken
        AlamofireManager.shared.request(APIRouter.post(url: API.LW_URL_SIGN_IN, params: params, identifier: nil)) { (response) in
            self.view.activityIndicatorView.stopAnimating()
            if response != nil{
                guard let data = response!["myself"] as? [String: Any],
                    let userModel: ATUserModel = Mapper<ATUserModel>().map(JSON: data)
                    else{
                        return
                }
                ATUserDefaults.set(key: "USER_CODE", val: self.txfCompanyId.text!)
                
                ATUserDefaults.setUserAccount(val: userModel.userAccount!)
                ATUserDefaults.setUserId(val: TRStringUtil.toString(data: userModel.userId))
              
                ATUserDefaults.setCompanyId(val: TRStringUtil.toString(data: userModel.companyId))
                ATUserDefaults.setCustomerId(val: TRStringUtil.toString(data: userModel.customerId))
                ATUserDefaults.setToken(val: userModel.token ?? "")
                ATUserDefaults.setUserName(val: TRStringUtil.toString(data: userModel.userName))
                ATUserDefaults.setUserKana(val: TRStringUtil.toString(data: userModel.userNameKana))
                ATUserDefaults.setUserEmail(val: TRStringUtil.toString(data: userModel.userEmail))
                
                ATUserDefaults.setUserPhone(val: TRStringUtil.toString(data: userModel.userPhone))
                ATUserDefaults.setCompanyName(val: TRStringUtil.toString(data: userModel.companyName))
                APP_DELEGATE?.initRootViewController(index:0)
            }
        }
        
    }
    
    
    @objc func textFieldDidChange(textField: UITextField) {
        if(textField.text?.isEmpty)!{
            textField.backgroundColor = AT_COLOR_WHITE
        }else {
            textField.backgroundColor = AT_FILL_IN_TEXTFIELD
        }
    }
    
}

extension ATSignInViewController:UITextFieldDelegate{
    public func textFieldDidBeginEditing(_ textField: UITextField) {
//        animateTextField(textField: textField, up:true)
        animateView(isUp: true)
    }
    public func textFieldDidEndEditing(_ textField: UITextField) {
//        animateTextField(textField: textField, up: false)
        animateView(isUp: false)
        if(textField.text?.isEmpty)!{
            textField.backgroundColor = AT_COLOR_WHITE
        }else {
            textField.backgroundColor = AT_FILL_IN_TEXTFIELD
        }
    }
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.txfCompanyId{
            self.txfUserId.becomeFirstResponder()
        }else if textField == self.txfUserId{
            self.txfPassword.becomeFirstResponder()
        }else{
            if (self.txfCompanyId.text?.isEmpty)! {
                self.txfCompanyId.becomeFirstResponder()
            }else if (self.txfUserId.text?.isEmpty)! {
                self.txfUserId.becomeFirstResponder()
            }else if (self.txfPassword.text?.isEmpty)! {
                self.txfPassword.becomeFirstResponder()
            }else {
//                self.view.endEditing(true)
                self.signInClick()
            
            }
        }
        return true
    }
    
}
