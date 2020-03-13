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
        self.layer.borderColor = AT_COLOR_BORDER.cgColor
        self.customTitleColor = AT_COLOR_BLACK
        self.customFont = UIFont.regularFont(size: AT_FONT_SIZE_NORMAL)
        self.tintColor = UIColor.clear
        self.isSelectedButton = false
    }
    

    var isSelectedButton: Bool!
    func updateButtonView(isSelected: Bool){
        self.isSelectedButton = isSelected
            if self.isSelectedButton{
                self.customBgColor = AT_BUTTON_COLOR1
//                self.customTitleColor = AT_COLOR_WHITE
            }else{
                self.customBgColor = AT_COLOR_WHITE
//                self.customTitleColor = AT_COLOR_BLACK
            }
        
    }
}
