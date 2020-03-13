//
//  TRButtonBean.swift
//  TrenteCoreSwift
//
//  Created by TrungND on 5/31/17.
//  Copyright © 2017 Trente. All rights reserved.
//

import UIKit

public class TRButtonBean: NSObject, UITextViewDelegate {

    var button: UIButton?
    var array: [UITextInput]?
    
    public init(button: UIButton, array: [UITextInput]) {
        super.init()
        self.button = button
        self.array = array
    }
    
    public func addDelegate(){
        for control in array! {
            if(control is UITextField){
                (control as! UITextField).addTarget(self, action: #selector(self.textFieldDidChange), for: .editingChanged)
            }else if(control is UITextView){
                (control as! UITextView).delegate = self
            }
        }
    }
    
    //MARK:- TextFielDelegate
    @objc public func textFieldDidChange() {
        self.judgeButtonEnabled()
    }
    
    //MARK:- TextViewDelegate
    public func textViewDidChange(_ textView: UITextView) {
        self.judgeButtonEnabled()
    }
    
    func judgeButtonEnabled(){
        var isEnabled = true
        for control in array! {
            if(control is UITextField){
                if (control as! UITextField).text!.isEmpty{
//                if(TRStringUtil.isEmpty(data: (control as! UITextField).text)){
                    isEnabled = false
                    break
                }
            }else if(control is UITextView){
                if (control as! UITextView).text!.isEmpty{
                    isEnabled = false
                    break
                }
            }
        }
        self.button?.isEnabled = isEnabled
    }
}
