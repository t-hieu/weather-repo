//
//  TRPickerView.swift
//  TrenteCoreSwift
//
//  Created by TrungND on 8/27/17.
//  Copyright © 2017 Trente. All rights reserved.
//

import UIKit

@objc public protocol TRPickerViewDelegate {
    func donePickerView(pickerView: TRPickerView, selectedIndex: Int)
    @objc optional func cancelPickerView(pickerView: TRPickerView)
}

public class TRPickerView: TRBasePickerView, UIPickerViewDelegate, UIPickerViewDataSource  {

    var pickerView: UIPickerView?
    public var pickerData = [String]()
    public var selectedIndex: Int?
    
    public var delegate: TRPickerViewDelegate?
    
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

    public func show() {
        self.pickerView?.reloadAllComponents()
        if(selectedIndex != nil && selectedIndex! >= 0 && selectedIndex! < self.pickerData.count){
            self.pickerView?.selectRow(selectedIndex!, inComponent: 0, animated: false)
        }
        keyWindow?.addSubview(self)
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
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    public func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50
    }
    public func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString.init(string: pickerData[row], attributes: [NSAttributedStringKey.font : UIFont.regularFont(size: 20),
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
        selectedIndex = self.pickerView?.selectedRow(inComponent: 0)
        if (self.delegate != nil) {
            self.delegate?.donePickerView(pickerView: self, selectedIndex: selectedIndex!)
        }
        self.hide()
    }
}
