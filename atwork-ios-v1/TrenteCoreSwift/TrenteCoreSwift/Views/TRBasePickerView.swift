//
//  TRBasePickerView.swift
//  TrenteCoreSwift
//
//  Created by TrungND on 8/27/17.
//  Copyright © 2017 Trente. All rights reserved.
//

import UIKit

open class TRBasePickerView: UIView {
    
    public let TOOLBAR_HEIGHT = CGFloat(50)
    public var keyWindow: UIWindow?
    public var toolBar: UIToolbar?
    public var pickerViewHeight: CGFloat?
    
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
    
    open func initialization() {
        self.keyWindow = UIApplication.shared.keyWindow
        self.frame = (self.keyWindow?.frame)!
        self.backgroundColor = UIColor.init(white: 0, alpha: 0.4)
        
        self.addPickerView()
        self.addToolbar()
    }
    
    open func addPickerView() {
        
    }
    
    open func addToolbar() {
        toolBar = UIToolbar.init(frame: CGRect.init(x: self.frame.origin.x, y: self.frame.origin.y + self.frame.size.height - pickerViewHeight! - TOOLBAR_HEIGHT, width: self.frame.size.width, height: TOOLBAR_HEIGHT))
        
        toolBar?.barStyle = UIBarStyle.default
        toolBar?.backgroundColor = UIColor.white
        
        let flexibleSpace = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        let leftFixedSpace = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.fixedSpace, target: self, action: nil)
        leftFixedSpace.width = 15
        let rightFixedSpace = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.fixedSpace, target: self, action: nil)
        rightFixedSpace.width = 15
        
        let cancelButton = TRButton()
        cancelButton.setTitle(NSLocalizedString("ACTION_CANCEL", comment: ""), for: UIControlState.normal)
        //"キャンセル"
        cancelButton.customFont = UIFont.boldFont(size: 20)
        cancelButton.customTitleColor = UIColor.init(red: 79.0 / 255.0, green: 88.0 / 255.0, blue: 104.0 / 255.0, alpha: 1)
        //        cancelButton.setTitleColor(UIColor.init(red: 79.0 / 255.0, green: 88.0 / 255.0, blue: 104.0 / 255.0, alpha: 1), for: UIControlState.normal)
        cancelButton.contentEdgeInsets = UIEdgeInsets.init(top: 8, left: 15, bottom: 8, right: 15)
        cancelButton.sizeToFit()
        cancelButton.addTarget(self, action: #selector(self.cancel), for: UIControlEvents.touchUpInside)
        let cancelBarButton = UIBarButtonItem.init(customView: cancelButton)
        
        let doneButton = TRButton()
        doneButton.setTitle(NSLocalizedString("ACTION_DONE", comment: ""), for: UIControlState.normal)
        //"決定"
        doneButton.customFont = UIFont.boldFont(size: 20)
        doneButton.customTitleColor = UIColor.init(red: 79.0 / 255.0, green: 88.0 / 255.0, blue: 104.0 / 255.0, alpha: 1)
        //        doneButton.setTitleColor(UIColor.black, for: UIControlState.normal)

        doneButton.contentEdgeInsets = UIEdgeInsets.init(top: 8, left: 15, bottom: 8, right: 15)
        doneButton.sizeToFit()
        
        doneButton.addTarget(self, action: #selector(self.done), for: UIControlEvents.touchUpInside)
        let doneBarButton = UIBarButtonItem.init(customView: doneButton)
        
        toolBar?.setItems([leftFixedSpace, cancelBarButton, flexibleSpace, doneBarButton, rightFixedSpace], animated: false)
        self.addSubview(toolBar!)
    }
    
    @objc open func cancel() {
        
    }
    
    @objc open func done() {
        
    }
}
