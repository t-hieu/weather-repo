//
//  WeekTitleView.swift
//  LW_Customer
//
//  Created by CuongNV on 9/17/18.
//  Copyright © 2018 Trente. All rights reserved.
//

import UIKit

class WeekTitleView: UIView {
    @IBOutlet var contentView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubview()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSubview()
    }
    
    func initSubview() {
        fromNib()
        self.contentView.layer.borderWidth = 1
        self.contentView.layer.borderColor = LW_COLOR_BORDER.cgColor
        self.contentView.backgroundColor = LW_COLOR_TITLE_INPUT_PERFORMACE
//        Bundle.main.loadNibNamed("LWBasicInformationView", owner: self, options: nil)
//        addSubview(view)
//        view.frame = bounds
        
//        labTitle.backgroundColor = LW_COLOR_TITLE_INPUT_PERFORMACE
//        labTitle.layer.borderWidth = 1
//        containerView.layer.borderWidth = 1
//        labTitle.layer.borderColor = LW_COLOR_BORDER.cgColor
//        containerView.layer.borderColor = LW_COLOR_BORDER.cgColor
    }

}
