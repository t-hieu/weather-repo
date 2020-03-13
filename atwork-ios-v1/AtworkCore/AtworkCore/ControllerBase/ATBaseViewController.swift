//
//  ATBaseViewController.swift
//  AtworkCore
//
//  Created by CuongNV on 10/18/18.
//  Copyright © 2018 Atwork. All rights reserved.
//

import UIKit
import TrenteCoreSwift

public class ATBaseViewController: UIViewController {
    
    
    
    override public func viewDidLoad() {
        super.viewDidLoad()
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        
    }
//    @objc func keyboardWillShow(notification: NSNotification) {
//        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
//            self.keyboardHeight = keyboardSize.height
//
//        }
//    }
    override public func viewDidAppear(_ animated: Bool) {
//        self.hideKeyboardWhenTappedAround()
    }
//    @objc func hideKeyboardWhenTappedAround() {
//        <#code#>
//    }

//    func animateTextField(textField: UITextField, up: Bool)
//
    
//
//
//    public func textFieldDidBeginEditing(textField: UITextField)
//    {
//        self.animateTextField(textField: textField, up:true)
//    }
//
//    public func textFieldDidEndEditing(textField: UITextField)
//    {
//        self.animateTextField(textField: textField, up:false)
//    }
}
// Put this piece of code anywhere you like
extension UIViewController {
    
//    func hideKeyboardWhenTappedAround() {
//        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
//        tap.cancelsTouchesInView = false
//        view.addGestureRecognizer(tap)
//    }
    
//    @objc func dismissKeyboard() {
//        view.endEditing(true)
//    }
    
    // Put this piece of code anywhere you like
    public func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
        
    @objc public func dismissKeyboard() {
        view.endEditing(true)
    }
    
    public func setupViewResizerOnKeyboardShown() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillShowForResizing),
                                               name: Notification.Name.UIKeyboardWillShow,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillHideForResizing),
                                               name: Notification.Name.UIKeyboardWillHide,
                                               object: nil)
    }
    
    @objc public func keyboardWillShowForResizing(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
            let window = self.view.window?.frame {
            // We're not just minusing the kb height from the view height because
            // the view could already have been resized for the keyboard before
            self.view.frame = CGRect(x: self.view.frame.origin.x,
                                     y: self.view.frame.origin.y,
                                     width: self.view.frame.width,
                                     height: window.origin.y + window.height - keyboardSize.height+90)
        } else {
            debugPrint("We're showing the keyboard and either the keyboard size or window is nil: panic widely.")
        }
    }
    
    @objc public func keyboardWillHideForResizing(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
            let window = self.view.window?.frame{
            let viewHeight = window.origin.y + window.height
//                self.view.frame.height
            self.view.frame = CGRect(x: self.view.frame.origin.x,
                                     y: self.view.frame.origin.y,
                                     width: self.view.frame.width,
                                     height: viewHeight + keyboardSize.height-90)
        } else {
            debugPrint("We're about to hide the keyboard and the keyboard size is nil. Now is the rapture.")
        }
    }
    
    func animateTextField(textField: UITextField, up: Bool)
    {
        let frame = textField.frame
        //        frame.origin.y = frame.origin.y - 167
        let keyboardHeight: CGFloat! = 420
        var movementDistance:CGFloat = self.view.frame.height - keyboardHeight  - frame.origin.y
        if movementDistance > 0 {
            movementDistance = 0
        }
        let movementDuration: Double = 0.3
        
        var movement:CGFloat = 0
        if up
        {
            movement = movementDistance
        }
        else
        {
            movement = -movementDistance
        }
        UIView.beginAnimations("animateTextField", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration)
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }
    
    func getMyImage(imageName: String) -> UIImage? {
        let bundle = Bundle(for: type(of: self))
        return UIImage(named: imageName, in: bundle, compatibleWith: nil)
    }
    
    func animateView(isUp: Bool){
        let keyboardHeight: CGFloat! = 120
        let movementDuration: Double = 0.3
        var movement:CGFloat = 0
        if isUp{
            movement = -keyboardHeight
        }else{
            movement = keyboardHeight
        }
        UIView.beginAnimations("animateTextField", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration)
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }
    
    func animateMovePosView(isUp: Bool){
        let keyboardHeight: CGFloat! = 200
        var movement:CGFloat = 0
        if isUp{
            movement = -keyboardHeight
        }else{
            movement = keyboardHeight
        }
        self.view.frame.origin.y += movement
    }
    
    func confirmMessages(messages: String, funcOK: @escaping ()->Void){
        let okFunc = { (action:UIAlertAction!) -> Void in
            funcOK()
        }
        let alertController = UIAlertController(title: "", message: NSLocalizedString(messages, comment: ""), preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        let okAction = UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: .default, handler:okFunc)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    func showMessage(messages: String){
        let alertView = UIAlertController(title: "", message: messages, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
        }
        alertView.addAction(okAction)
        
        if let window = UIApplication.shared.delegate?.window, let rootVc = window?.rootViewController{
            rootVc.present(alertView, animated: true, completion: nil)
        }
    }
    
    func getStringDateJP(dateString: String) -> String{
        let date = TRDateUtil.makeDateCustom(date: dateString, format: "yyyy/MM/dd")
        switch date!.weekday {
            case 1:
                return dateString + "(日)"
            case 2 :
                return dateString + "(月)"
            case 3 :
                return dateString + "(火)"
            case 4 :
                return dateString + "(水)"
            case 5 :
                return dateString + "(木)"
            case 6 :
                return dateString + "(金)"
            case 7 :
                return dateString + "(土)"
            default:
                return dateString
        }
    }
    
    
}


