//
//  LWPerformanceCell.swift
//  LiftWork
//
//  Created by CuongNV on 5/28/18.
//  Copyright © 2018 Trente. All rights reserved.
//

import UIKit

class LWPerformanceCell: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var customerLabel: UILabel!
    @IBOutlet weak var liftMaterialLabel: UILabel!
    @IBOutlet weak var fromToLabel: UILabel!
    
    @IBOutlet weak var line: UILabel!
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
        timeLabel.layer.borderWidth = 1
        timeLabel.layer.borderColor = LW_COLOR_BORDER.cgColor
        timeLabel.font = UIFont.systemFont(ofSize: LW_FONT_SIZE_NORMAL)
//        customerLabel.layer.borderWidth = 1
//        customerLabel.layer.borderColor = LW_COLOR_BORDER.cgColor
        customerLabel.font = UIFont.systemFont(ofSize: LW_FONT_SIZE_NORMAL)
//
        line.layer.borderWidth = 1
        line.layer.borderColor = LW_COLOR_BORDER.cgColor
        
        liftMaterialLabel.font = UIFont.systemFont(ofSize: LW_FONT_SIZE_NORMAL)
        fromToLabel.layer.borderWidth = 1
        fromToLabel.layer.borderColor = LW_COLOR_BORDER.cgColor
        fromToLabel.font = UIFont.systemFont(ofSize: LW_FONT_SIZE_NORMAL)
        
        self.layer.borderWidth = 1
        self.layer.borderColor = LW_COLOR_BORDER.cgColor
    }
    
    func setTextColor(color: UIColor){
        timeLabel.textColor = color
        customerLabel.textColor = color
        liftMaterialLabel.textColor = color
        fromToLabel.textColor = color
    }
    
    func setBackgroundColor(color: UIColor){
        contentView.backgroundColor = color
    }
}
