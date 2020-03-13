//
//  TaBarButtonItem.swift
//  LiftWork
//
//  Created by VietND on 6/8/18.
//  Copyright © 2018 Trente. All rights reserved.
//

import UIKit
import TrenteCoreSwift

class LWTabBarButtonItem: TRButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.customFont = UIFont.boldFont(size: LW_FONT_SIZE_NORMAL)
    }
    
    func changeSelected(isSelected:Bool){
        if isSelected{
            self.customBgColor = LW_COLOR_BLUE_LIGHT
            self.customTitleColor = LW_COLOR_WHITE
        }else{
            self.customBgColor = UIColor.clear
            self.customTitleColor = UIColor.black
        }
        
    }

}
