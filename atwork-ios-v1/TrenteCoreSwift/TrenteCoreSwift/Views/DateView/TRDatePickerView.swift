//
//  TRDatePickerView.swift
//  TrenteCoreSwift
//
//  Created by TrungND on 5/21/18.
//  Copyright © 2018 Trente. All rights reserved.
//

import UIKit

@objc public protocol TRDatePickerViewDelegate {
    func doneMonthPickerView(pickerView: TRDatePickerView)
    @objc optional func cancelMonthPickerView(pickerView: TRDatePickerView)
}

public class TRDatePickerView: UIView {
    
    var keyWindow: UIWindow?
    public var datePicker: UIDatePicker?
    var toolBar: UIToolbar?
    
    public var delegate: TRDatePickerViewDelegate?
    public var date: Date?
    
    public init(){
        super.init(frame: CGRect.init())
        self.initialization()
    }
    
    public override init(frame: CGRect){
        super.init(frame: frame)
        self.initialization()
    }
    public required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        self.initialization()
    }
    
    func initialization() {
        self.keyWindow = UIApplication.shared.keyWindow
        self.frame = (self.keyWindow?.frame)!
        self.backgroundColor = UIColor.init(white: 0, alpha: 0.4)
        
        self.addDatePicker()
        self.addToolbar()
    }

    func addDatePicker() {
        self.datePicker = UIDatePicker.init()
        self.datePicker?.locale = Locale(identifier: "ja")
//        if(self.datePicker?.datePickerMode == nil){
//            self.datePicker?.datePickerMode = .date
//        self.datePicker?.minuteInterval = 5
//        }
        let coordinateX = self.frame.origin.x
        let coordinateY = self.frame.origin.y + self.frame.size.height - (self.datePicker?.frame.size.height)!
        let width = self.frame.size.width
        let height = (self.datePicker?.frame.size.height)!
        
        self.datePicker?.frame = CGRect.init(x: coordinateX, y: coordinateY, width: width, height: height)
        
        
        self.datePicker?.backgroundColor = UIColor.init(red: 244.0 / 255.0, green: 250.0 / 255.0, blue: 250.0 / 255.0, alpha: 1.0)
        self.addSubview(self.datePicker!)
    }
    
    func addToolbar() {
        toolBar = UIToolbar.init(frame: CGRect.init(x: self.frame.origin.x, y: self.frame.origin.y + self.frame.size.height - (self.datePicker?.frame.size.height)! - 44, width: self.frame.size.width, height: 44))
        
        toolBar?.barStyle = UIBarStyle.default
        toolBar?.backgroundColor = UIColor.white
        
        let flexibleSpace = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        let leftFixedSpace = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.fixedSpace, target: self, action: nil)
        leftFixedSpace.width = 15
        let rightFixedSpace = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.fixedSpace, target: self, action: nil)
        rightFixedSpace.width = 15
        
        let cancelButton = UIButton.init()
        cancelButton.setTitle(NSLocalizedString("tr_common_action_cancel", comment: ""), for: UIControlState.normal)
        cancelButton.setTitleColor(UIColor.init(red: 79.0 / 255.0, green: 88.0 / 255.0, blue: 104.0 / 255.0, alpha: 1), for: UIControlState.normal)
        cancelButton.sizeToFit()
        cancelButton.addTarget(self, action: #selector(self.cancel), for: UIControlEvents.touchUpInside)
        let cancelBarButton = UIBarButtonItem.init(customView: cancelButton)
        
        let doneButton = UIButton.init()
        doneButton.setTitle(NSLocalizedString("tr_common_action_done", comment: ""), for: UIControlState.normal)
        doneButton.setTitleColor(UIColor.black, for: UIControlState.normal)
        doneButton.sizeToFit()
        doneButton.addTarget(self, action: #selector(self.done), for: UIControlEvents.touchUpInside)
        let doneBarButton = UIBarButtonItem.init(customView: doneButton)
        
        toolBar?.setItems([leftFixedSpace, cancelBarButton, flexibleSpace, doneBarButton, rightFixedSpace], animated: false)
        self.addSubview(toolBar!)
    }
    
    public func show() {
        if (date != nil) {
                self.datePicker?.setDate(self.date ?? Date(), animated: false);
        }
        keyWindow?.addSubview(self)
        self.alpha = 0
        UIView.animate(withDuration: 0.2, animations: {
            self.alpha = 1
        })
    }
    
    public func hide() {
        self.removeFromSuperview()
    }
    
    @objc func cancel() {
        if (self.delegate != nil) {
            let theMethod = self.delegate?.cancelMonthPickerView
            if((theMethod) != nil){
                self.delegate?.cancelMonthPickerView!(pickerView: self)
            }
        }
        self.hide()
    }
    
    @objc func done() {
        self.date = self.datePicker?.date
        if (self.delegate != nil) {
            self.delegate?.doneMonthPickerView(pickerView: self)
        }
        self.hide()
    }
}
