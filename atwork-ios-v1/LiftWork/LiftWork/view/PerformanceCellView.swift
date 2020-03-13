//
//  PerformanceCellView.swift
//  LiftWork
//
//  Created by CuongNV on 5/25/18.
//  Copyright © 2018 Trente. All rights reserved.
//

import UIKit

class LWPerformanceCellView: UIView {
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var customerLabel: UILabel!
    @IBOutlet weak var liftMaterialLabel: UILabel!
    
    @IBOutlet weak var fromToLabel: UILabel!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSubview()
    }
    
    func initSubview() {
        
        Bundle.main.loadNibNamed("LWPerformanceCell", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        viewTitle.layer.borderWidth = 1
        viewTitle.backgroundColor = LW_COLOR_TITLE_INPUT_PERFORMACE
        contentTextField.layer.borderWidth = 1
        
        contentTextField.font = UIFont.systemFont(ofSize: LW_FONT_SIZE_NORMAL)
        titlelabel.font = UIFont.systemFont(ofSize: LW_FONT_SIZE_NORMAL)
        
    }
}

