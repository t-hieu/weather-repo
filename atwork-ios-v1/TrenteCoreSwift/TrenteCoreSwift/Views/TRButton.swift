//
//  TRButton.swift
//  TrenteCoreSwift
//
//  Created by TrungND on 5/31/17.
//  Copyright © 2017 Trente. All rights reserved.
//

import UIKit

 open class TRButton: UIButton {
   open var customFont: UIFont = UIFont.regularFont(size: 17) {
        didSet {
            commonInit()
        }
    }
    open var customTitleColor: UIColor = UIColor.white {
        didSet {
            commonInit()
        }
    }
    
   open var customBgColor: UIColor? = UIColor.clear{
        didSet{
            self.backgroundColor = customBgColor
        }
    }
    
    var textFields = [UITextField]()
    
    public func initilization(title: String, color: UIColor, radius: CGFloat, textFields: [UITextField]?) {
        self.customBgColor = color
        self.layer.cornerRadius = radius
        
        if(textFields != nil){
            self.textFields = textFields!
            
            if((textFields?.count)! > 0){
                self.isEnabled = false
                for textField in textFields! {
                    textField.addTarget(self, action: #selector(textFieldDidChange(textField: )), for: .editingChanged)
                }
            }
        }
    }
    public func dependsOn( textFields: [UITextField]?) {
        
        if(textFields != nil){
            self.textFields = textFields!
            
            if((textFields?.count)! > 0){
                self.isEnabled = false
                for textField in textFields! {
                    textField.addTarget(self, action: #selector(textFieldDidChange(textField: )), for: .editingChanged)
                }
            }
        }
    }
    
    @objc func textFieldDidChange(textField: UITextField) {
        var isEnabled = true
        for textField in textFields {
            if textField.text == nil || textField.text!.isEmpty{
                isEnabled = false
                break
            }
        }
        self.isEnabled = isEnabled
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    fileprivate func commonInit() {
        self.backgroundColor = customBgColor
        if let title = self.title(for: .normal){
            self.setAttributedText(title, for: .normal)
        }
        if let title = self.title(for: .selected){
            self.setAttributedText(title, for: .selected)
        }
        if let title = self.title(for: .highlighted){
            self.setAttributedText(title, for: .highlighted)
        }
        if let title = self.title(for: .disabled){
            self.setAttributedText(title, for: .disabled)
        }
        if let attributedTitle = self.attributedTitle(for: .normal){
            self.setAttributedText(attributedTitle.string, for: .normal)
        }
        if let attributedTitle = self.attributedTitle(for: .selected){
            self.setAttributedText(attributedTitle.string, for: .selected)
        }
        if let attributedTitle = self.attributedTitle(for: .highlighted){
            self.setAttributedText(attributedTitle.string, for: .highlighted)
        }
        if let attributedTitle = self.attributedTitle(for: .disabled){
            self.setAttributedText(attributedTitle.string, for: .disabled)
        }
        
    }
    
    func setAttributedText(_ title: String?, for state: UIControlState) {
        if let titleLabel = self.titleLabel,let title = title{
            let style = NSMutableParagraphStyle()
            style.alignment = titleLabel.textAlignment
            style.lineBreakMode = titleLabel.lineBreakMode
            let attributedText = NSAttributedString(string: NSLocalizedString(title, comment: ""), attributes: [
                NSAttributedStringKey.foregroundColor : customTitleColor,
                NSAttributedStringKey.font: customFont,
                NSAttributedStringKey.paragraphStyle: style
                ])
            self.setAttributedTitle(attributedText, for: state)
        }
    }
    
    override open func setTitle(_ title: String?, for state: UIControlState) {
        self.setAttributedText(title, for: state)
    }
    
    
    override open var isHighlighted: Bool {
        didSet {
            if(isHighlighted) {
                self.alpha = 0.5
            }else {
                self.alpha = 1
            }
        }
    }
    
    override open var isEnabled: Bool {
        didSet {
            if(isEnabled) {
                self.alpha = 1
            }else {
                self.alpha = 0.5
            }
        }
    }
    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        isHighlighted = true
        super.touchesBegan(touches, with: event)
    }
    
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        isHighlighted = false
        super.touchesEnded(touches, with: event)
    }
    
    open override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        isHighlighted = false
        super.touchesCancelled(touches, with: event)
    }
}
