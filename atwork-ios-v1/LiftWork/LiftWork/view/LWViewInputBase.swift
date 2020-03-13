//
//  LWViewInputBase.swift
//  LiftWork
//
//  Created by CuongNV on 6/8/18.
//  Copyright © 2018 Trente. All rights reserved.
//

import UIKit

class LWViewInputBase: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var labTitle: UILabel!
    @IBOutlet weak var textFieldContent: UITextField!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSubview()
    }
    
    func initSubview() {
        
        Bundle.main.loadNibNamed("LWViewInputBase", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        
        self.labTitle.backgroundColor = LW_COLOR_TITLE_INPUT_PERFORMACE
        self.labTitle.layer.borderWidth = 1
        self.labTitle.layer.borderColor = LW_COLOR_BORDER.cgColor
        self.labTitle.font = UIFont.systemFont(ofSize: LW_FONT_SIZE_NORMAL)
        self.textFieldContent.font = UIFont.systemFont(ofSize: LW_FONT_SIZE_NORMAL)
        
        self.layer.borderWidth = 1
        self.layer.borderColor = LW_COLOR_BORDER.cgColor
    }
    
    
}
