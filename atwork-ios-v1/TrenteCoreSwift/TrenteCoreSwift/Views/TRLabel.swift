//
//  TRLabel.swift
//  TrenteCoreSwift
//
//  Created by VietND on 6/7/18.
//  Copyright © 2018 Trente. All rights reserved.
//

import UIKit

open class TRLabel: UILabel {
    
    open var customFont: UIFont = UIFont.regularFont(size: 17) {
        didSet {
            commonInit()
        }
    }
    open var customTextColor: UIColor = UIColor.white {
        didSet {
            commonInit()
        }
    }
    
    
    open var customNumberOfLines: Int = 1 {
        didSet {
            commonInit()
        }
    }
    
    open var spacing: CGFloat = 7 {
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
    
    func commonInit() {
        if let text = self.text{
            self.setAtributedText(text: NSLocalizedString(text, comment: ""))
        }
        if let attributedText = self.attributedText{
            self.setAtributedText(text: NSLocalizedString(attributedText.string, comment: ""))
        }
        
    }
    
    private func setAtributedText(text: String?) {
        if let text = text {
            let style = NSMutableParagraphStyle()
            style.lineSpacing = self.spacing
            style.alignment = textAlignment
            style.lineBreakMode = self.lineBreakMode
            
            let attributedText = NSAttributedString(string: text, attributes: [
                NSAttributedStringKey.foregroundColor : self.customTextColor,
                NSAttributedStringKey.font: self.customFont,
                NSAttributedStringKey.paragraphStyle: style
                ])
            self.attributedText = attributedText
        } 
    }
    
    override open var text: String?{
        didSet{
            self.setAtributedText(text: text)
        }
    }
    
}
