//
//  LWViewBase.swift
//  LiftWork
//
//  Created by CuongNV on 5/15/18.
//  Copyright © 2018 Trente. All rights reserved.
//

import UIKit

protocol LWViewBaseDelegate {
    func actionClickLabContent()
}

class LWViewBase: UIView {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var labTitle: UILabel!
    @IBOutlet weak var labContent: UILabel!
    
    @IBOutlet weak var iconArrow: UIImageView!
    
    @IBOutlet weak var containerView: UIView!
    var delegate: LWViewBaseDelegate?
    var isAbleTap: Bool?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubview()
    }
    
    @IBAction func tapContentlab(_ sender: Any) {
        delegate?.actionClickLabContent()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSubview()
    }
    
    func initSubview() {
        fromNib()

        labTitle.backgroundColor = AT_COLOR_TITLE_INPUT_PERFORMACE
        labTitle.layer.borderWidth = 1
        containerView.layer.borderWidth = 1
        labTitle.layer.borderColor = AT_COLOR_BORDER.cgColor
        containerView.layer.borderColor = AT_COLOR_BORDER.cgColor
    }
    
    func isHideArrow(isHide: Bool){
        self.iconArrow.isHidden = isHide
    }
    
    func setAlpha(alphaView: CGFloat){
        if(self.isAbleTap)!{
            self.alpha = alphaView
        }
    }
}
