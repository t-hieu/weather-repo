//
//  ATInputNameController.swift
//  AtworkCore
//
//  Created by CuongNV on 11/6/18.
//  Copyright © 2018 Atwork. All rights reserved.
//

import UIKit

class ATInputNameController: UIViewController , UITextFieldDelegate {
    @IBOutlet weak var name: LWBlackNormalRegularTextField!
    
    @IBOutlet weak var nameReading: LWBlackNormalRegularTextField!
    
    @IBOutlet weak var btNext: LWRoundedLightBlueButton!
    
    var account : ATAccountModel!
    
    @IBAction func tapOK(_ sender: Any) {
        
        var params = LWParams.initParamsLW()
        params["verifyType"] = "names"
        params["customerId"] = self.account.customerId.description
        params["userName"] = name.text
        params["userKana"] = nameReading.text
        
        AlamofireManager.shared.request(APIRouter.post(url: API.LW_URL_VERIFY_ACCOUNT, params: params, identifier: nil)) { (response) in
            self.view.activityIndicatorView.stopAnimating()
            if response != nil{
                let result = response!["status"] as! String
                if "OK".elementsEqual(result){
                    let vc = ATInputEmailController.init(nibName: ATInputEmailController.className, bundle: Bundle.init(for: ATInputEmailController.self))
                    self.account.userName = self.name.text
                    self.account.userKana = self.nameReading.text
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
        
        self.navigationItem.title = "氏名入力"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        
        //        btNext.dependsOn(textFields: [name , nameReading])
        name.delegate = self
        name.addTarget(self, action: #selector(textFieldDidChange(textField: )), for: .editingChanged)
        
        nameReading.delegate = self
        nameReading.addTarget(self, action: #selector(textFieldDidChange(textField: )), for: .editingChanged)
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
    override func viewDidAppear(_ animated: Bool) {
        self.hideKeyboardWhenTappedAround()
    }
}
