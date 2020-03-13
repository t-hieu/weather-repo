//
//  ATInputCompanyCodeController.swift
//  AtworkCore
//
//  Created by CuongNV on 11/6/18.
//  Copyright © 2018 Atwork. All rights reserved.
//

import UIKit
import TrenteCoreSwift


class ATInputCompanyCodeController: UIViewController, UITextFieldDelegate {
    
    var account: ATAccountModel!
    
    @IBOutlet weak var codeText: LWBlackNormalRegularTextField!
    @IBAction func tapNext(_ sender: Any) {
        self.view.endEditing(true)
        var params = LWParams.initParamsLW()
        params["companyCode"] = self.codeText.text
        AlamofireManager.shared.request(APIRouter.post(url: API.LW_URL_VERIFYCOMPANYCODE, params: params, identifier: nil)) { (response) in
            self.view.activityIndicatorView.stopAnimating()
            if response != nil{
                let result = response!["status"] as! String
                if "OK".elementsEqual(result){
                    self.account = ATAccountModel.init()
                    self.account.companyName = response!["companyName"] as? String
                    self.account.customerId = response!["customerId"] as? Int
                    self.account.companyCode = self.codeText.text
                    
                    let vc = ATConfirmCompanyCodeController.init(nibName: ATConfirmCompanyCodeController.className, bundle: Bundle.init(for: ATConfirmCompanyCodeController.self))
                    vc.account = self.account
                    self.navigationController?.pushViewController(vc, animated: true)
                }
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
        
        self.navigationItem.title = "会社CODE入力"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        //        btNext.dependsOn(textFields: [codeText])
        codeText.delegate = self
        codeText.addTarget(self, action: #selector(textFieldDidChange(textField: )), for: .editingChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //        setupViewResizerOnKeyboardShown()
    }
    @objc func tapLeftBarButton(){
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.hideKeyboardWhenTappedAround()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if(textField.text?.isEmpty)!{
            textField.backgroundColor = AT_COLOR_WHITE
        }else {
            textField.backgroundColor = AT_FILL_IN_TEXTFIELD
        }
        self.animateTextField(textField: textField, up:false)
    }
    @objc func textFieldDidChange(textField: UITextField) {
        if(textField.text?.isEmpty)!{
            textField.backgroundColor = AT_COLOR_WHITE
        }else {
            textField.backgroundColor = AT_FILL_IN_TEXTFIELD
        }
    }
    
    
    
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        
        self.animateTextField(textField: textField, up:true)
    }
    
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        if(textField.text?.isEmpty)!{
//            textField.backgroundColor = AT_COLOR_WHITE
//        }else {
//            textField.backgroundColor = AT_FILL_IN_TEXTFIELD
//        }
//    }
    
    
    
}

