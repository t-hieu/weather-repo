//
//  ATInputEmailController.swift
//  AtworkCore
//
//  Created by CuongNV on 11/6/18.
//  Copyright © 2018 Atwork. All rights reserved.
//

import UIKit

class ATInputEmailController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var email: LWBlackNormalRegularTextField!
    @IBOutlet weak var phone: LWBlackNormalRegularTextField!
    @IBAction func tapOK(_ sender: Any) {
        var params = LWParams.initParamsLW()
        params["verifyType"] = "mails"
        params["customerId"] = self.account.customerId.description
        params["userEmail"] = email.text
        params["userPhone"] = phone.text
        
        AlamofireManager.shared.request(APIRouter.post(url: API.LW_URL_VERIFY_ACCOUNT, params: params, identifier: nil)) { (response) in
            self.view.activityIndicatorView.stopAnimating()
            if response != nil{
                let result = response!["status"] as! String
                if "OK".elementsEqual(result){
                    let vc = ATConfirmAllInputController.init(nibName: ATConfirmAllInputController.className, bundle: Bundle.init(for: ATConfirmAllInputController.self))
                    self.account.userEmail = self.email.text
                    self.account.userPhone = self.phone.text
                    vc.account = self.account
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }
    
    @IBOutlet weak var btNext: LWRoundedLightBlueButton!
    
    var account : ATAccountModel!
    
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
        
        self.navigationItem.title = "連絡先入力"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        
        //        btNext.dependsOn(textFields: [email , phone])
        email.delegate = self
        email.addTarget(self, action: #selector(textFieldDidChange(textField: )), for: .editingChanged)
        
        phone.delegate = self
        phone.addTarget(self, action: #selector(textFieldDidChange(textField: )), for: .editingChanged)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        setupViewResizerOnKeyboardShown()
    }
    override func viewDidAppear(_ animated: Bool) {
        self.hideKeyboardWhenTappedAround()
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
