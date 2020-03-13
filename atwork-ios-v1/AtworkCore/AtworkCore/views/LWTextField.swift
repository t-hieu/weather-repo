//
//  LWTextField.swift
//  LiftWork
//
//  Created by VietND on 6/7/18.
//  Copyright © 2018 Trente. All rights reserved.
//

import UIKit
import TrenteCoreSwift

public class LWTextField: TRTextField {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
class LWRoundedTextField: LWTextField {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.borderStyle = .none
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 5.0
        self.layer.masksToBounds = true
        self.layer.borderWidth = 1.0
        self.addDoneButtonOnKeyboard()
    }
}

public class LWBlackNormalRegularTextField:LWTextField{
    override public func awakeFromNib() {
        super.awakeFromNib()
        self.customTextColor = AT_COLOR_BLACK
        self.customFont = UIFont.regularFont(size: AT_FONT_SIZE_NORMAL)
        self.addDoneButtonOnKeyboard()
    }
}

extension UITextField{
    
    @IBInspectable var doneAccessory: Bool{
        get{
            return self.doneAccessory
        }
        set (hasDone) {
            if hasDone{
                addDoneButtonOnKeyboard()
            }
        }
    }
    
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default

//        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "完了", style: .done, target: self, action: #selector(self.doneButtonAction))

        let items = [done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()

        self.inputAccessoryView = doneToolbar
        
//        //Add done button to numeric pad keyboard
//        let toolbarDone = UIToolbar.init()
//        toolbarDone.sizeToFit()
//        let barBtnDone = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.done,
//                                              target: self, action: #selector(self.self.doneButtonAction))
        
//        toolbarDone.items = [barBtnDone] // You can even add cancel button too
     //   self.inputAccessoryView = toolbarDone
    }
    
    @objc func doneButtonAction()
    {
        self.resignFirstResponder()
    }
}
