//
//  ATInputAccountController.swift
//  AtworkCore
//
//  Created by CuongNV on 11/6/18.
//  Copyright © 2018 Atwork. All rights reserved.
//

import UIKit

class ATInputAccountController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var userId: LWBlackNormalRegularTextField!
    @IBOutlet weak var password: LWBlackNormalRegularTextField!
    
    @IBOutlet weak var btNext: LWRoundedLightBlueButton!
    
    var account: ATAccountModel!
    
    @IBAction func tapOK(_ sender: Any) {
        
        var params = LWParams.initParamsLW()
        params["verifyType"] = "accounts"
        params["customerId"] = self.account.customerId.description
        params["account"] = userId.text
        params["password"] = password.text
        
        AlamofireManager.shared.request(APIRouter.post(url: API.LW_URL_VERIFY_ACCOUNT, params: params, identifier: nil)) { (response) in
            self.view.activityIndicatorView.stopAnimating()
            if response != nil{
                let result = response!["status"] as! String
                if "OK".elementsEqual(result){
                    let vc = ATInputNameController.init(nibName: ATInputNameController.className, bundle: Bundle.init(for: ATInputNameController.self))
                    self.account.account = self.userId.text
                    self.account.password = self.password.text
                    vc.account = self.account
                    
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
        
        
        
    }
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
        
        self.navigationItem.title = "アカウント情報入力"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        
        //        btNext.dependsOn(textFields: [userId , password])
        userId.delegate = self
        userId.addTarget(self, action: #selector(textFieldDidChange(textField: )), for: .editingChanged)
        
        password.delegate = self
        password.addTarget(self, action: #selector(textFieldDidChange(textField: )), for: .editingChanged)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        self.hideKeyboardWhenTappedAround()
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
