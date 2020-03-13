//
//  LWViewOneLabel.swift
//  LiftWork
//
//  Created by CuongNV on 5/16/18.
//  Copyright © 2018 Trente. All rights reserved.
//

import UIKit

class LWSectionView: UITableViewHeaderFooterView {
//
    @IBOutlet weak var titleLabel: LWnormalBoldLabel!
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSubview()
    }
    

    
    func initSubview() {
//        fromNib()
       self.setBackgoundColor(color: LW_COLOR_BLUE_DARK)
    }
    
    func setBackgoundColor(color: UIColor){
        self.contentView.backgroundColor = color
    }
    func setTextLabel(text:String?){
        self.titleLabel.text = text
    }

}
