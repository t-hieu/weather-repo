//
//  LWUnitQuantityView.swift
//  LiftWork
//
//  Created by CuongNV on 5/23/18.
//  Copyright © 2018 Trente. All rights reserved.
//

import UIKit

class LWUnitQuantityView: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var titlelabel: UILabel!
    
    @IBOutlet weak var viewTitle: UIView!
    @IBOutlet weak var contentTextField: UITextField!
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSubview()
    }
    
    func initSubview() {
        
        Bundle.main.loadNibNamed("LWUnitQuantityView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        viewTitle.layer.borderWidth = 1
        viewTitle.layer.borderColor = LW_COLOR_BORDER.cgColor
        viewTitle.backgroundColor = LW_COLOR_TITLE_INPUT_PERFORMACE
        contentTextField.layer.borderWidth = 1
        contentTextField.layer.borderColor = LW_COLOR_BORDER.cgColor
        contentTextField.font = UIFont.systemFont(ofSize: LW_FONT_SIZE_NORMAL)
        titlelabel.font = UIFont.systemFont(ofSize: LW_FONT_SIZE_NORMAL)
        
    }
}
