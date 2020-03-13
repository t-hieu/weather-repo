//
//  DayView.swift
//  LW_Customer
//
//  Created by CuongNV on 9/17/18.
//  Copyright © 2018 Trente. All rights reserved.
//

import UIKit

class DayView: UIView {
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var dayTitle: UILabel!
    @IBOutlet weak var viewPercent: UIView!
    
    @IBOutlet weak var percentWidthContraint: NSLayoutConstraint!
    
    
    
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
        self.viewPercent.layer.borderWidth = 1
        self.viewPercent.layer.borderColor = LW_COLOR_BLACK.cgColor
//        self.viewPercent.backgroundColor = LW_COLOR_TITLE_INPUT_PERFORMACE
       
    }
    
    func updatePercentWidth(percent: CGFloat){
        let width = self.viewPercent.frame.width
        self.percentWidthContraint.constant = percent * width / 100
    }
    
    func updateBackGroundColor(state: String){
        switch state {
        case "-1":
            self.contentView.backgroundColor = UIColor.darkGray
            self.dayTitle.textColor = LW_COLOR_WHITE
            break
        case "0":
            self.contentView.backgroundColor = UIColor.orange
            self.dayTitle.textColor = LW_COLOR_BLACK
            break
        case "2":
            self.contentView.backgroundColor = LW_COLOR_BLUE_LIGHT
            self.dayTitle.textColor = LW_COLOR_BLACK
            break
        default:
            self.contentView.backgroundColor = LW_COLOR_WHITE
            self.dayTitle.textColor = LW_COLOR_BLACK
            break
        }
    }
    
    

}
