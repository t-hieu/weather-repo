//
//  SignInViewController.swift
//  LiftWork
//
//  Created by CuongNV on 5/8/18.
//  Copyright © 2018 Trente. All rights reserved.
//

import UIKit
import TrenteCoreSwift
import ObjectMapper
import Alamofire

class SignInViewController: LWBaseViewController,MainStoryboard {
    @IBOutlet weak var txfCompanyId: UITextField!
    @IBOutlet weak var txfUserId: UITextField!
    @IBOutlet weak var txfPassword: UITextField!
    @IBOutlet weak var btSignIn: LWRoundedLightBlueButton!
    
    @IBAction func signIn(_ sender: Any) {
        signInClick()
    }
    
    var isCheck: Bool!
    override func viewDidLoad() {
        super.viewDidLoad()
        btSignIn.dependsOn(textFields: [txfCompanyId, txfUserId, txfPassword])
       
        
        txfCompanyId.addTarget(self, action: #selector(textFieldDidChange(textField: )), for: .editingChanged)
        txfUserId.addTarget(self, action: #selector(textFieldDidChange(textField: )), for: .editingChanged)
        txfPassword.addTarget(self, action: #selector(textFieldDidChange(textField: )), for: .editingChanged)
        
        isCheck = false
        self.txfCompanyId.delegate = self
        self.txfCompanyId.font = UIFont.systemFont(ofSize: LW_FONT_SIZE_NORMAL)
        self.txfUserId.delegate = self
        self.txfUserId.font = UIFont.systemFont(ofSize: LW_FONT_SIZE_NORMAL)
        self.txfPassword.delegate = self
        self.txfPassword.font = UIFont.systemFont(ofSize: LW_FONT_SIZE_NORMAL)
        
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func signInClick() -> Void{
        self.view.endEditing(true)
        var params = LWParamUtil.initParamsLW()
        params["account"] = self.txfUserId.text
        params["password"] = self.txfPassword.text
        params["company"] = self.txfCompanyId.text
        AlamofireManager.shared.request(APIRouter.post(url: API.LW_URL_SIGN_IN, params: params, identifier: nil)) { (response) in
            self.view.activityIndicatorView.stopAnimating()
            if response != nil{
                guard let data = response!["myself"] as? [String: Any],
                    let userModel:LWUserModel = Mapper<LWUserModel>().map(JSON: data)
                    else{
                        return
                }

                LWUserDefaults.setUserId(val: TRStringUtil.toString(data: userModel.userId))
                LWUserDefaults.setCompanyId(val: TRStringUtil.toString(data: userModel.companyId))
                LWUserDefaults.setToken(val: userModel.token ?? "")
                
                APP_DELEGATE?.initRootViewController(index:0)
            }
        }
        
    }
    
    
    @objc func textFieldDidChange(textField: UITextField) {
        if(textField.text?.isEmpty)!{
            textField.backgroundColor = LW_COLOR_WHITE
        }else {
            textField.backgroundColor = LW_FILL_IN_TEXTFIELD
        }
    }

}

extension SignInViewController:UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        if(textField.text?.isEmpty)!{
            textField.backgroundColor = LW_COLOR_WHITE
        }else {
            textField.backgroundColor = LW_FILL_IN_TEXTFIELD
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.txfCompanyId{
            self.txfUserId.becomeFirstResponder()
        }else if textField == self.txfUserId{
            self.txfPassword.becomeFirstResponder()
        }else{
            self.signInClick()
        }
        return true
    }

}
