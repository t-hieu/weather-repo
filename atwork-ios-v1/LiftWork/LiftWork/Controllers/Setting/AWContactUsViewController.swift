//
//  AWContactUsViewController.swift
//  LiftWork
//
//  Created by CuongNV on 5/9/18.
//  Copyright © 2018 Trente. All rights reserved.
//

import UIKit
import TrenteCoreSwift
import ObjectMapper

class AWContactUsViewController: LWBaseViewController, LWViewOneLabelDelegate, UITextViewDelegate {
    @IBOutlet weak var topRow: LWViewOneLabel!
    @IBOutlet weak var companyRow: LWViewInputBase!
    @IBOutlet weak var nameRow: LWViewInputBase!
    @IBOutlet weak var emailRow: LWViewInputBase!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentArea: UITextView!
    @IBOutlet weak var viewContent: UIView!
    
    @IBOutlet weak var sendbt: LWRoundedBlueGreenButton!
    @IBAction func tapSendBt(_ sender: Any) {
        
        contactUs()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.topRow.labTitle.text = NSLocalizedString("lw_button_back", comment: "")
        self.topRow.delegate = self
        
        self.companyRow.labTitle.text = NSLocalizedString("lw_company_name", comment: "")
        self.nameRow.labTitle.text = NSLocalizedString("lw_name", comment: "")
        self.emailRow.labTitle.text = NSLocalizedString("lw_email", comment: "")
        
        self.nameRow.textFieldContent.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        self.emailRow.textFieldContent.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
//        self.emailRow.textFieldContent.delegate = self
//        self.contentArea.delegate = self
        
        self.titleLabel.text = NSLocalizedString("lw_contact_us_content", comment: "")
        self.titleLabel.layer.borderWidth = 1
        self.titleLabel.layer.borderColor = LW_COLOR_BORDER.cgColor
        self.titleLabel.backgroundColor = LW_COLOR_TITLE_INPUT_PERFORMACE
        self.titleLabel.font = UIFont.systemFont(ofSize: LW_FONT_SIZE_NORMAL)

        self.sendbt.setTitle(NSLocalizedString("lw_send", comment: ""), for: .normal)
        self.sendbt.setTitle(NSLocalizedString("lw_send", comment: ""), for: .disabled)
        self.sendbt.isEnabled = false
        self.contentArea.font = UIFont.regularFont(size: LW_FONT_SIZE_NORMAL)
        self.contentArea.delegate = self
        
//        self.contentArea.addTarget(self, action: #selector(textViewDidChange(textView: )), for: .editingChanged)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupViewResizerOnKeyboardShown()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.loadAccountInformation()
    }
    //call api
    
    func loadAccountInformation(){
        let params = LWParamUtil.initParamsLW()
        AlamofireManager.shared.request(APIRouter.get(url: API.LW_URL_ACCOUNT_DETAIL, params: params, identifier: nil)) { (response) in
            self.view.activityIndicatorView.stopAnimating()
            if response != nil{
                //data
                guard let data = response!["myself"] as? [String:Any],
                    let mySelf:LWUserModel = Mapper<LWUserModel>().map(JSON: data)
                    else{
                        return
                }
                self.companyRow.textFieldContent.text = mySelf.companyName
                self.companyRow.textFieldContent.isUserInteractionEnabled = false
//                self.userNameRow.labContent.text = mySelf.userName
//                if mySelf.systemAdmin != 0{
//                    self.informationRow.labContent.text = NSLocalizedString("ADMIN", comment: "")
//                }else if mySelf.companyAdmin != 0{
//                    self.informationRow.labContent.text = NSLocalizedString("ADMIN", comment: "")
//                }else{
//                    self.informationRow.labContent.text = NSLocalizedString("MEMBER", comment: "")
//                }
                
            }
        }
        
    }
    
    func contactUs(){
        var params = LWParamUtil.initParamsLW()
        params["companyName"] = self.companyRow.textFieldContent.text
        params["fullName"] = self.nameRow.textFieldContent.text
        params["email"] = self.emailRow.textFieldContent.text
        params["content"] = self.contentArea.text

        AlamofireManager.shared.request(APIRouter.post(url: API.LW_URL_CONTACT_US, params: params, identifier: nil)) { (response) in
            self.view.activityIndicatorView.stopAnimating()
            if response != nil{
                let alertController = UIAlertController(title: "", message: NSLocalizedString(NSLocalizedString("lw_send_contact_us_success", comment: ""), comment: ""), preferredStyle: .alert)
                let okAction = UIAlertAction(title: NSLocalizedString("ACTION_OK", comment: ""), style: .default, handler:{(action) in
                     self.backScreen()
                })
                
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
                
            }
        }
    }
    
    func setupViewResizerOnKeyboardShown() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillShowForResizing),
                                               name: Notification.Name.UIKeyboardWillShow,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillHideForResizing),
                                               name: Notification.Name.UIKeyboardWillHide,
                                               object: nil)
    }
    
    @objc func keyboardWillShowForResizing(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
            let window = self.view.window?.frame {
            // We're not just minusing the kb height from the view height because
            // the view could already have been resized for the keyboard before
            self.view.frame = CGRect(x: self.view.frame.origin.x,
                                     y: self.view.frame.origin.y,
                                     width: self.view.frame.width,
                                     height: window.origin.y + window.height - keyboardSize.height+150)
        } else {
            debugPrint("We're showing the keyboard and either the keyboard size or window is nil: panic widely.")
        }
    }
    
    @objc func keyboardWillHideForResizing(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let viewHeight = self.view.frame.height
            self.view.frame = CGRect(x: self.view.frame.origin.x,
                                     y: self.view.frame.origin.y,
                                     width: self.view.frame.width,
                                     height: viewHeight + keyboardSize.height-150)
        } else {
            debugPrint("We're about to hide the keyboard and the keyboard size is nil. Now is the rapture.")
        }
    }
    
    func isFillAllData() -> Bool{
        if(self.nameRow.textFieldContent.text?.isEmpty)! {
            return false
        }
        if(self.emailRow.textFieldContent.text?.isEmpty)! {
            return false
        }
        if(self.contentArea.text?.isEmpty)! {
            return false
        }
        return true
    }
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        if(self.isFillAllData()){
//            self.sendbt.isEnabled = true
//        }
//    }
    
    @objc private func textFieldDidChange(textField: UITextField) {
        if(self.isFillAllData()){
            self.sendbt.isEnabled = true
        }else {
            self.sendbt.isEnabled = false
        }
        
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if(self.isFillAllData()){
            self.sendbt.isEnabled = true
        }else {
            self.sendbt.isEnabled = false
        }
    }
    
    func tapViewOneLabelInTime(view: LWViewOneLabel) {
        
    }
    func tapViewOneLabelInTitle(view: LWViewOneLabel) {
        backScreen()
    }
    
    func backScreen()  {
        self.navigationController?.popViewController(animated: true)
    }
   
}
