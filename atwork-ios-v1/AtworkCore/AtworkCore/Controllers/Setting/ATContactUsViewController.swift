//
//  ATContactUsViewController.swift
//  AtworkCore
//
//  Created by CuongNV on 11/1/18.
//  Copyright © 2018 Atwork. All rights reserved.
//

import UIKit

public class ATContactUsViewController: UIViewController, UITextViewDelegate {

    
    @IBOutlet weak var viewTitle: UIView!
    @IBOutlet weak var textFieldEmail: LWBlackNormalRegularTextField!
    @IBOutlet weak var viewTitleContent: UIView!
    
    @IBOutlet weak var contentArea: LWBlackNormalRegularTextView!
    @IBOutlet weak var viewContent: UIView!
    
    @IBOutlet weak var sendbt: LWRoundedDarkBlueButton!
    @IBAction func tapSendBt(_ sender: Any) {
        let chars = [Character](self.contentArea.text)
        if textFieldEmail.text?.isEmpty == true && self.contentArea.text.isEmpty == true {
            let alertController = UIAlertController(title: "", message: "Emailアドレスを入力してください。\n問い合わせ内容は3文字以上、1000文字以内で入力して下さい。", preferredStyle: .alert)
            let okAction = UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: .default, handler:nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
            return
        }
        if textFieldEmail.text?.isEmpty == true  {
            let alertController = UIAlertController(title: "", message: "Emailアドレスを入力してください。", preferredStyle: .alert)
            let okAction = UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: .default, handler:nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
            return
        }
        if (chars.count < 3 || chars.count > 1000 ) {
            let alertController = UIAlertController(title: "", message: " 問い合わせ内容は3文字以上、1000文字以内で入力して下さい。", preferredStyle: .alert)
            let okAction = UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: .default, handler:nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
            return
        }
        

        contactUs()
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barTintColor = UIColor.orange
        self.navigationController?.navigationBar.isTranslucent = false 
        let leftBarButton = UIBarButtonItem(title: "＜戻る", style: .plain, target: self, action: #selector(self.tapLeftBarButton))
        leftBarButton.titleTextAttributes(for: .normal)
        leftBarButton.setTitleTextAttributes([NSAttributedStringKey.font: UIFont.boldFont(size: AT_FONT_SIZE_NORMAL)], for: .normal)
        leftBarButton.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItem = leftBarButton
        
        self.navigationItem.title = "お問い合わせ"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        
        self.textFieldEmail.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        self.textFieldEmail.text = ATUserDefaults.getUserEmail()
        
//        self.emailRow.textFieldContent.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        //        self.emailRow.textFieldContent.delegate = self
        //        self.contentArea.delegate = self
        
        self.viewTitle.layer.borderColor = AT_COLOR_BORDER.cgColor
        self.viewTitle.layer.borderWidth = 0.5
        self.viewTitle.backgroundColor = AT_COLOR_TITLE_INPUT_PERFORMACE
        
        self.viewTitleContent.layer.borderColor = AT_COLOR_BORDER.cgColor
        self.viewTitleContent.layer.borderWidth = 0.5
        self.viewTitleContent.backgroundColor = AT_COLOR_TITLE_INPUT_PERFORMACE
        
        self.viewContent.layer.borderColor = AT_COLOR_BORDER.cgColor
        self.viewContent.layer.borderWidth = 0.5
        
//        self.sendbt.setTitle(NSLocalizedString("lw_send", comment: ""), for: .normal)
//        self.sendbt.setTitle(NSLocalizedString("lw_send", comment: ""), for: .disabled)
//        self.sendbt.isEnabled = false
        self.contentArea.font = UIFont.regularFont(size: AT_FONT_SIZE_NORMAL)
        self.contentArea.delegate = self
        
        //        self.contentArea.addTarget(self, action: #selector(textViewDidChange(textView: )), for: .editingChanged)
    }
    
    @objc func tapLeftBarButton(){
        self.navigationController?.popViewController(animated: true)
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //setupViewResizerOnKeyboardShown()
        
    }
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override public func viewDidAppear(_ animated: Bool) {
    }
    
    //call api
    func contactUs(){
        var params = LWParams.initParamsLW()
        params["companyName"] = ATUserDefaults.getCompanyName()
        params["fullName"] = ATUserDefaults.getUserName()
        params["email"] = self.textFieldEmail.text
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
    
//    func setupViewResizerOnKeyboardShown() {
//        NotificationCenter.default.addObserver(self,
//                                               selector: #selector(self.keyboardWillShowForResizing),
//                                               name: Notification.Name.UIKeyboardWillShow,
//                                               object: nil)
//        NotificationCenter.default.addObserver(self,
//                                               selector: #selector(self.keyboardWillHideForResizing),
//                                               name: Notification.Name.UIKeyboardWillHide,
//                                               object: nil)
//    }
//
//    @objc func keyboardWillShowForResizing(notification: Notification) {
//        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
//            let window = self.view.window?.frame {
//            // We're not just minusing the kb height from the view height because
//            // the view could already have been resized for the keyboard before
//            self.view.frame = CGRect(x: self.view.frame.origin.x,
//                                     y: self.view.frame.origin.y,
//                                     width: self.view.frame.width,
//                                     height: window.origin.y + window.height - keyboardSize.height+90)
//        } else {
//            debugPrint("We're showing the keyboard and either the keyboard size or window is nil: panic widely.")
//        }
//    }
//
//    @objc func keyboardWillHideForResizing(notification: Notification) {
//        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
//            let viewHeight = self.view.frame.height
//            self.view.frame = CGRect(x: self.view.frame.origin.x,
//                                     y: self.view.frame.origin.y,
//                                     width: self.view.frame.width,
//                                     height: viewHeight + keyboardSize.height-150)
//        } else {
//            debugPrint("We're about to hide the keyboard and the keyboard size is nil. Now is the rapture.")
//        }
//    }
    
    func isFillAllData() -> Bool{
        if(self.textFieldEmail.text?.isEmpty)! {
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
//            self.sendbt.isEnabled = true
        }else {
//            self.sendbt.isEnabled = false
        }
        
    }
    
    public func textViewDidChange(_ textView: UITextView) {
        if(self.isFillAllData()){
           self.sendbt.isEnabled = true
        }else {
//            self.sendbt.isEnabled = false
        }
    }
    
    func backScreen()  {
        self.navigationController?.popViewController(animated: true)
    }
    
}
