//
//  ATTimePickerView.swift
//  AtworkCore
//
//  Created by CuongNV on 11/14/18.
//  Copyright © 2018 Atwork. All rights reserved.
//

import UIKit
import TrenteCoreSwift

@objc public protocol ATTimePickerViewDelegate {
    func donePickerView(pickerView: ATTimePickerView, hourSelected: String, minSelected: String)
    @objc optional func cancelPickerView(pickerView: ATTimePickerView)
}

public class ATTimePickerView: TRBasePickerView, UIPickerViewDelegate, UIPickerViewDataSource  {
    
    var pickerView: UIPickerView?
    public var pickerHourData = [String]()
    public var pickerMinData = [String]()
    public var selectedIndex1: Int! = -1
    public var selectedIndex2: Int! = -1
    public var timeInterval: Int! = 0
    public var hourAdd: Int! = 0
    public var delegate: ATTimePickerViewDelegate?
    


    override public func initialization() {
        super.initialization()
        //        selectedIndex = 0
    }
    
    override public func addPickerView() {
        self.pickerView = UIPickerView.init()
        pickerViewHeight = self.pickerView?.frame.size.height
        self.pickerView?.frame = CGRect.init(x: self.frame.origin.x, y: self.frame.origin.y + self.frame.size.height - pickerViewHeight!, width: self.frame.size.width, height: (self.pickerView?.frame.size.height)!)
        
        self.pickerView?.delegate = self
        self.pickerView?.backgroundColor = UIColor.init(red: 244.0 / 255.0, green: 250.0 / 255.0, blue: 250.0 / 255.0, alpha: 1.0)
        
        self.addSubview(self.pickerView!)
    }
    
    func setData(hourAdd: Int, timeInterval: Int, currentHour: Int, currentMin: Int){
        self.hourAdd = hourAdd
        self.timeInterval = timeInterval
        self.selectedIndex1 = -1
        self.selectedIndex2 = -1
        self.pickerHourData.removeAll()
        self.pickerMinData.removeAll()
        for index in 0..<24 {
            if index + hourAdd == currentHour {
                self.selectedIndex1 = index
            }
            var hour = String(index + hourAdd)
            if hour.count < 2 {
                hour = "0" + hour
            }
            self.pickerHourData.append(hour)
        }
        for index in 0..<60/timeInterval {
            if self.selectedIndex2 == -1 && index * timeInterval >= currentMin {
                self.selectedIndex2 = index
            }
            var min = String(index * timeInterval)
            if min.count < 2 {
                min = "0" + min
            }
            self.pickerMinData.append(min)
            
        }
        
        if self.selectedIndex1 == -1 {
            self.selectedIndex1 = 0
        }
        if self.selectedIndex2 == -1 {
            self.selectedIndex2 = 0
        }
    }
    
    public func show() {
        self.pickerView?.reloadAllComponents()
        if(selectedIndex1 != nil && selectedIndex1! >= 0 && selectedIndex1! < self.pickerHourData.count){
            self.pickerView?.selectRow(selectedIndex1!, inComponent: 0, animated: false)
        }
        if(selectedIndex2 != nil && selectedIndex2! >= 0 && selectedIndex2! < self.pickerMinData.count){
            self.pickerView?.selectRow(selectedIndex2!, inComponent: 1, animated: false)
        }
        super.keyWindow?.addSubview(self)
        self.alpha = 0
        UIView.animate(withDuration: 0.2, animations: {
            self.alpha = 1
        })
        keyWindow?.endEditing(true)
    }
    
    public func hide() {
        self.removeFromSuperview()
    }
    
    //    pragma mark - Handle Action In View
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let location = touches.first?.location(in: self),
            !toolBar!.frame.contains(location){
            self.hide()
        }
    }
    
    //    pragma mark PickerView DataSource
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return self.pickerHourData.count
        }
        return self.pickerMinData.count
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return self.pickerHourData[row]
        }
        return self.pickerMinData[row]
    }
    
    public func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50
    }
    public func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        if component == 0 {
            return NSAttributedString.init(string: pickerHourData[row], attributes: [NSAttributedStringKey.font : UIFont.regularFont(size: 20),
                                                                                 NSAttributedStringKey.foregroundColor : UIColor.black])
        }
        return NSAttributedString.init(string: pickerMinData[row], attributes: [NSAttributedStringKey.font : UIFont.regularFont(size: 20),
                                                                             NSAttributedStringKey.foregroundColor : UIColor.black])
    }
    
    override public func cancel() {
        if (self.delegate != nil) {
            let theMethod = self.delegate?.cancelPickerView
            if((theMethod) != nil){
                self.delegate?.cancelPickerView!(pickerView: self)
            }
        }
        self.hide()
    }
    
    override public func done() {
        selectedIndex1 = self.pickerView?.selectedRow(inComponent: 0)
        selectedIndex2 = self.pickerView?.selectedRow(inComponent: 1)
        if (self.delegate != nil) {
            self.delegate?.donePickerView(pickerView: self, hourSelected: self.pickerHourData[selectedIndex1], minSelected: self.pickerMinData[selectedIndex2])
        }
        self.hide()
    }
}

    

    


