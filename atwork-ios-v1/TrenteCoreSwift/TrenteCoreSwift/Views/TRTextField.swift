//
//  TRTextField.swift
//  TrenteCoreSwift
//
//  Created by VietND on 6/7/18.
//  Copyright © 2018 Trente. All rights reserved.
//

import UIKit

open class TRTextField: UITextField {
    
    open var paddingLeft:CGFloat = 8{
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    open var customFont: UIFont = UIFont.regularFont(size: 17) {
        didSet {
            commonInit()
        }
    }
    
    open var customTextColor: UIColor = UIColor.black {
        didSet {
            commonInit()
        }
    }
    open var customPlaceholderColor: UIColor = UIColor.lightGray {
        didSet {
            commonInit()
        }
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
        self.font = self.customFont
        
        if let placeholder = self.placeholder{
            self.attributedPlaceholder =  NSAttributedString(string: NSLocalizedString(placeholder, comment: ""), attributes: [
                NSAttributedStringKey.foregroundColor : self.customPlaceholderColor,
                NSAttributedStringKey.font: self.customFont
                ])
        }
        
        if let atributedPlaceholder = self.attributedPlaceholder{
            self.attributedPlaceholder =  NSAttributedString(string: NSLocalizedString(atributedPlaceholder.string, comment: ""), attributes: [
                NSAttributedStringKey.foregroundColor : self.customPlaceholderColor,
                NSAttributedStringKey.font: self.customFont
                ])
        }
    }
    
    //       fileprivate func setAtributedText(text: String?) {
    //            if let text = text {
    //                let style = NSMutableParagraphStyle()
    //                style.alignment = textAlignment
    //
    //                let attributedText = NSAttributedString(string: text, attributes: [
    //                    NSAttributedStringKey.foregroundColor : self.customTextColor,
    //                    NSAttributedStringKey.font: self.customFont,
    //                    NSAttributedStringKey.paragraphStyle: style
    //                    ])
    //                self.attributedText = attributedText
    //            } else {
    //                self.text = text
    //            }
    //        }
    
    
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        let edgeInsets = UIEdgeInsets(top: 0, left: paddingLeft, bottom: 0, right: 0);
        return UIEdgeInsetsInsetRect(bounds, edgeInsets)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        let edgeInsets = UIEdgeInsets(top: 0, left: paddingLeft, bottom: 0, right: 0);
        return UIEdgeInsetsInsetRect(bounds, edgeInsets)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        let edgeInsets = UIEdgeInsets(top: 0, left: paddingLeft, bottom: 0, right: 0);
        return UIEdgeInsetsInsetRect(bounds, edgeInsets)
    }
    
}
