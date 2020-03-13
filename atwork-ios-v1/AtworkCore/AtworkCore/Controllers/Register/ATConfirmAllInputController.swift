//
//  ATConfirmAllInputController.swift
//  AtworkCore
//
//  Created by CuongNV on 11/6/18.
//  Copyright © 2018 Atwork. All rights reserved.
//

import UIKit

class ATConfirmAllInputController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var userId: LWBlackNormalRegularTextField!
    @IBOutlet weak var password: LWBlackNormalRegularTextField!
    
    @IBOutlet weak var name: LWBlackNormalRegularTextField!
    
    @IBOutlet weak var readingName: LWBlackNormalRegularTextField!
    
    @IBOutlet weak var email: LWBlackNormalRegularTextField!
    @IBOutlet weak var phone: LWBlackNormalRegularTextField!
    
    var account: ATAccountModel!
    
    @IBAction func tapOK(_ sender: Any) {
        
        var params = LWParams.initParamsLW()
        params["account"] = self.userId.text
        params["userName"] = self.name.text
        params["userKana"] = self.readingName.text
        params["userEmail"] = self.email.text
        params["userPhone"] = self.phone.text
        params["password"] = self.password.text
        params["customerId"] = "\(self.account.customerId ?? 0)"
        
        AlamofireManager.shared.request(APIRouter.post(url: API.LW_URL_REGISTER_CUSTOMER, params: params, identifier: nil)) { (response) in
            self.view.activityIndicatorView.stopAnimating()
            if response != nil{
                let result = response!["status"] as! String
                if "OK".elementsEqual(result){
                    
                    let vc = ATRegisterSuccessController.init(nibName: ATRegisterSuccessController.className, bundle: Bundle.init(for: ATRegisterSuccessController.self))
                    vc.account = self.account
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                    //                    self.acount = LWCustomerAcount.init()
                    //                    self.acount.companyName = response!["companyName"] as? String
                    //                    self.acount.customerId = response!["customerId"] as? String
                    //
                    //                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "LWConfirmCompanyCodeController") as! LWConfirmCompanyCodeController
                    //                    vc.account = self.acount
                    //                    self.navigationController?.pushViewController(vc, animated: true)
                }
                //                guard let data = response!["myself"] as? [String: Any],
                //                    let userModel:LWUserModel = Mapper<LWUserModel>().map(JSON: data)
                //                    else{
                //                        return
                //                }
                
                //                LWUserDefaults.setUserId(val: TRStringUtil.toString(data: userModel.userId))
                //                LWUserDefaults.setCompanyId(val: TRStringUtil.toString(data: userModel.companyId))
                //                LWUserDefaults.setToken(val: userModel.token ?? "")
                //
                //                APP_DELEGATE?.initRootViewController(index:0)
            }
        }
        
        
        
    }
    
    @IBOutlet weak var btNext: LWRoundedLightBlueButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.barTintColor = UIColor.orange
        self.navigationController?.navigationBar.isTranslucent = false 
        
        let leftBarButton = UIBarButtonItem(title: "＜戻る", style: .plain, target: self, action: #selector(self.tapLeftBarButton))
        leftBarButton.titleTextAttributes(for: .normal)
        leftBarButton.setTitleTextAttributes([NSAttributedStringKey.font: UIFont.boldFont(size: AT_FONT_SIZE_NORMAL)], for: .normal)
        leftBarButton.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItem = leftBarButton
        
        self.navigationItem.title = "入力情報確認"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        
        
        userId.delegate = self
        userId.addTarget(self, action: #selector(textFieldDidChange(textField: )), for: .editingChanged)
        
        password.delegate = self
        password.addTarget(self, action: #selector(textFieldDidChange(textField: )), for: .editingChanged)
        name.delegate = self
        name.addTarget(self, action: #selector(textFieldDidChange(textField: )), for: .editingChanged)
        
        readingName.delegate = self
        readingName.addTarget(self, action: #selector(textFieldDidChange(textField: )), for: .editingChanged)
        email.delegate = self
        email.addTarget(self, action: #selector(textFieldDidChange(textField: )), for: .editingChanged)
        
        phone.delegate = self
        phone.addTarget(self, action: #selector(textFieldDidChange(textField: )), for: .editingChanged)
        
    }
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        self.hideKeyboardWhenTappedAround()
        userId.text = self.account.account
        userId.backgroundColor = AT_FILL_IN_TEXTFIELD
        password.text = self.account.password
        password.backgroundColor = AT_FILL_IN_TEXTFIELD
        name.text = self.account.userName
        name.backgroundColor = AT_FILL_IN_TEXTFIELD
        readingName.text = self.account.userKana
        readingName.backgroundColor = AT_FILL_IN_TEXTFIELD
        email.text = self.account.userEmail
        email.backgroundColor = AT_FILL_IN_TEXTFIELD
        phone.text = self.account.userPhone
        phone.backgroundColor = AT_FILL_IN_TEXTFIELD
        //        btNext.dependsOn(textFields: [userId, password, name, readingName, email , phone])
        //        btNext.isEnabled = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        setupViewResizerOnKeyboardShown()
    }
    
    @objc func tapLeftBarButton(){
        self.navigationController?.popViewController(animated: true)
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.animateTextField(textField: textField, up:true)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.animateTextField(textField: textField, up:false)
        if(textField.text?.isEmpty)!{
            textField.backgroundColor = AT_COLOR_WHITE
        }else {
            textField.backgroundColor = AT_FILL_IN_TEXTFIELD
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
