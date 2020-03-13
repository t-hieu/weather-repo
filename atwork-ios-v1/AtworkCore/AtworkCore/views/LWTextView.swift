//
//  LWTextView.swift
//  AtworkCore
//
//  Created by CuongNV on 11/2/18.
//  Copyright © 2018 Atwork. All rights reserved.
//

import Foundation
import TrenteCoreSwift

class LWTextView: UITextView {
    
}

class LWBlackNormalRegularTextView:LWTextView{
    override func awakeFromNib() {
        super.awakeFromNib()
        self.textColor = AT_COLOR_BLACK
        self.font = UIFont.regularFont(size: AT_FONT_SIZE_NORMAL)
        self.addDoneButtonOnKeyboard()
    }
}

extension UITextView{
    
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
        
//                let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
                let done: UIBarButtonItem = UIBarButtonItem(title: "完了", style: .done, target: self, action: #selector(self.doneButtonAction))
        
                let items = [done]
                doneToolbar.items = items
                doneToolbar.sizeToFit()
        
                self.inputAccessoryView = doneToolbar
        
        //Add done button to numeric pad keyboard
//        let toolbarDone = UIToolbar.init()
//        toolbarDone.sizeToFit()
//        let barBtnDone = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.done,
//                                              target: self, action: #selector(self.self.doneButtonAction))
//
//        toolbarDone.items = [barBtnDone] // You can even add cancel button too
//        self.inputAccessoryView = toolbarDone
    }
    
    @objc func doneButtonAction()
    {
        self.resignFirstResponder()
    }
}


