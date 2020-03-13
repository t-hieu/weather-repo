//
//  ATTabBarButtonItem.swift
//  AtworkCore
//
//  Created by CuongNV on 10/4/18.
//  Copyright © 2018 Atwork. All rights reserved.
//

import UIKit
import TrenteCoreSwift

public class ATTabBarButtonItem: TRButton {
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        self.customFont = UIFont.boldFont(size: AT_FONT_SIZE_NORMAL)
    }
    
    public func changeSelected(isSelected:Bool){
        if isSelected{
            self.customBgColor = AT_COLOR_BLUE_LIGHT
            self.customTitleColor = AT_COLOR_WHITE
        }else{
            self.customBgColor = UIColor.clear
            self.customTitleColor = UIColor.black
        }
        
    }

}
public class ATTabBarGrayButtonItem: TRButton {
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        self.customFont = UIFont.boldFont(size: AT_FONT_SIZE_NORMAL)
            self.layer.cornerRadius = BUTTON_CORNER_RARIUS
            self.customFont = UIFont.regularFont(size: AT_FONT_SIZE_NORMAL)
    }
    
    public func changeSelected(isSelected:Bool){
        if isSelected{
            self.customBgColor = AT_COLOR_BLUE_LIGHT
            self.customTitleColor = AT_COLOR_WHITE
        }else{
            self.customBgColor = AT_COLOR_TITLE_INPUT_PERFORMACE
            self.customTitleColor = UIColor.black
        }
        
    }
    
}
