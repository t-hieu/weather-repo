//
//  FilterByCharacterButton.swift
//  LiftWork
//
//  Created by VietND on 7/3/18.
//  Copyright © 2018 Trente. All rights reserved.
//

import UIKit

class FilterByCharacterButton: LWButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderWidth = 1
        self.layer.borderColor = LW_COLOR_BORDER.cgColor
        self.customTitleColor = LW_COLOR_BLACK
        self.customFont = UIFont.regularFont(size: LW_FONT_SIZE_NORMAL)
        self.tintColor = UIColor.clear
    }
    

     override var isSelected: Bool{
        didSet{
            if isSelected{
                self.customBgColor = LW_COLOR_BLUE
                self.customTitleColor = LW_COLOR_WHITE
            }else{
                self.customBgColor = LW_COLOR_WHITE
                self.customTitleColor = LW_COLOR_BLACK
            }
        }
    }
}
