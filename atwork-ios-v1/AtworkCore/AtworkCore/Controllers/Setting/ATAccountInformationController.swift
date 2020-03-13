//
//  ATAccountInformationController.swift
//  AtworkCore
//
//  Created by CuongNV on 11/1/18.
//  Copyright © 2018 Atwork. All rights reserved.
//

import UIKit

public class ATAccountInformationController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var viewId: UIView!
    
    @IBOutlet weak var viewIdContent: UIView!
    
    @IBOutlet weak var idContentLabel: LWBlackNormalRegularLabel!
    
    @IBOutlet weak var viewSwitch: UIView!
    @IBAction func isChangePassword(_ sender: UISwitch) {
        self.updateViewChangePass()
    }
    
    @IBOutlet weak var viewChangePassword: UIView!
    
    @IBOutlet weak var oldPass: LWBlackNormalRegularTextField!
    @IBOutlet weak var newPass: LWBlackNormalRegularTextField!
    @IBOutlet weak var confirmPass: LWBlackNormalRegularTextField!
    
    @IBOutlet weak var enableChangePas: UISwitch!
    
    
    
    @IBAction func actionChangePassword(_ sender: Any) {
//        if !(self.confirmPass.text?.elementsEqual((self.newPass.text)!))!{
//            let alertController = UIAlertController(title: "", message: NSLocalizedString(NSLocalizedString("新しいパスワードと新しいパスワード（再確認）が異なります。確認して下さい。", comment: ""), comment: ""), preferredStyle: .alert)
//            let okAction = UIAlertAction(title: NSLocalizedString("ACTION_OK", comment: ""), style: .cancel, handler:{(action) in
////                alertController.dismissKeyboard()
//            })
//
//
//            alertController.addAction(okAction)
//            self.present(alertController, animated: true, completion: nil)
            updatePassword()
 //       }
    }
    
    @IBOutlet weak var btChange: LWRoundedDarkBlueButton!
    
//    var isChangePass: Bool!
    
    override public func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.barTintColor = UIColor.orange
        self.navigationController?.navigationBar.isTranslucent = false 
        let leftBarButton = UIBarButtonItem(title: "＜戻る", style: .plain, target: self, action: #selector(self.tapLeftBarButton))
        leftBarButton.titleTextAttributes(for: .normal)
        leftBarButton.setTitleTextAttributes([NSAttributedStringKey.font: UIFont.boldFont(size: AT_FONT_SIZE_NORMAL)], for: .normal)
        leftBarButton.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItem = leftBarButton
        
        self.navigationItem.title = "アカウント情報"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        
        self.viewId.layer.borderWidth = 0.5
        self.viewId.layer.borderColor = AT_COLOR_BORDER.cgColor
        self.viewId.backgroundColor = AT_COLOR_TITLE_INPUT_PERFORMACE
        
        self.viewIdContent.layer.borderColor = AT_COLOR_BORDER.cgColor
        self.viewIdContent.layer.borderWidth = 0.5
        
        self.viewSwitch.layer.borderColor = AT_COLOR_BORDER.cgColor
        self.viewSwitch.layer.borderWidth = 0.5
        
//        self.btChange.dependsOn(textFields: [self.newPass, self.oldPass, self.confirmPass])
        self.oldPass.addTarget(self, action: #selector(textFieldDidChange(textField: )), for: .editingChanged)
        self.confirmPass.addTarget(self, action: #selector(textFieldDidChange(textField: )), for: .editingChanged)
        self.newPass.addTarget(self, action: #selector(textFieldDidChange(textField: )), for: .editingChanged)
        
        self.enableChangePas.onTintColor = UIColor.orange
//        self.isChangePass = false
        self.enableChangePas.isOn = false
        self.updateViewChangePass()
        self.idContentLabel.text = ATUserDefaults.getUserAccount()
    }
    
    func updateViewChangePass(){
        self.viewChangePassword.isHidden = !self.enableChangePas.isOn
    }

    @objc func tapLeftBarButton(){
        self.navigationController?.popViewController(animated: true)
        
    }
    @objc func textFieldDidChange(textField: UITextField) {
        if(textField.text?.isEmpty)!{
            textField.backgroundColor = AT_COLOR_WHITE
        }else {
            textField.backgroundColor = AT_FILL_IN_TEXTFIELD
        }
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        if(textField.text?.isEmpty)!{
            textField.backgroundColor = AT_COLOR_WHITE
        }else {
            textField.backgroundColor = AT_FILL_IN_TEXTFIELD
        }
    }
    func updatePassword(){
        var params = LWParams.initParamsLW()
        params["key"] = ATUserDefaults.getUserId()
        params["password"] = self.oldPass.text
        params["newPassword"] = self.newPass.text
        params["confirmPassword"] = self.confirmPass.text

        AlamofireManager.shared.request(APIRouter.post(url: API.AT_URL_UPDATE_PASSWORD, params: params, identifier: nil)) { (response) in
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
                    } else {
                        if let message: String = response?["message"] as? String{
                           
                        }
                    }
                }
//                self.navigationController?.popViewController(animated: false)
////
            }
        }
    }
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        if textField == self.txfCompanyId{
//            self.txfUserId.becomeFirstResponder()
//        }else if textField == self.txfUserId{
//            self.txfPassword.becomeFirstResponder()
//        }else{
//            self.signInClick()
//        }
//        return true
//    }

}
