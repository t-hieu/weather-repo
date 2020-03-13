//
//  Button.swift
//  LiftWork
//
//  Created by VietND on 6/6/18.
//  Copyright © 2018 Trente. All rights reserved.
//

import UIKit
import TrenteCoreSwift

 let BUTTON_CORNER_RARIUS = CGFloat(7)

class LWButton: TRButton {
   override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
class LWRoundedLightBlueButton: TRButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = BUTTON_CORNER_RARIUS
        self.customTitleColor = AT_COLOR_WHITE
        self.customBgColor = AT_COLOR_BLUE_LIGHT
        self.customFont = UIFont.regularFont(size: AT_FONT_SIZE_NORMAL)
    }
}

class LWRoundedDarkBlueButton: TRButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = BUTTON_CORNER_RARIUS
        self.customTitleColor = AT_COLOR_WHITE
        self.customBgColor = AT_COLOR_BLUE_DARK
        self.customFont = UIFont.regularFont(size: AT_FONT_SIZE_NORMAL)
    }
}
class LWRoundedDarkRedButton: TRButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = BUTTON_CORNER_RARIUS
        self.customTitleColor = AT_COLOR_WHITE
        self.customBgColor = UIColor.red
        self.customFont = UIFont.regularFont(size: AT_FONT_SIZE_NORMAL)
    }
}

class LWRoundedDarkOrangeButton: TRButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = BUTTON_CORNER_RARIUS
        self.customTitleColor = AT_COLOR_WHITE
        self.customBgColor = UIColor.orange
        self.customFont = UIFont.regularFont(size: AT_FONT_SIZE_NORMAL)
    }
}


class LWRoundedBlueGreenButton: TRButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = BUTTON_CORNER_RARIUS
        self.customTitleColor = AT_COLOR_BLUE
        self.customBgColor = AT_COLOR_GREEN
        self.customFont = UIFont.regularFont(size: AT_FONT_SIZE_NORMAL)
    }
}

class LWRoundedGrayBlackButton: TRButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = BUTTON_CORNER_RARIUS
        self.customTitleColor = AT_COLOR_BLACK
        self.customBgColor = AT_COLOR_TITLE_INPUT_PERFORMACE
        self.customFont = UIFont.regularFont(size: AT_FONT_SIZE_NORMAL)
    }
}

class LWRoundedWhiteBlackButton: TRButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = BUTTON_CORNER_RARIUS
        self.customTitleColor = AT_COLOR_BLACK
        self.customBgColor = AT_COLOR_WHITE
        self.customFont = UIFont.regularFont(size: AT_FONT_SIZE_NORMAL)
    }
}

class LWRoundedLightGrayButton: TRButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = BUTTON_CORNER_RARIUS
        self.customTitleColor = AT_COLOR_BLACK
        self.customBgColor = AT_COLOR_LIGHT_GRAY
        self.customFont = UIFont.regularFont(size: AT_FONT_SIZE_NORMAL)
    }
}

class LWRoundedBlueDarkButton: TRButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = BUTTON_CORNER_RARIUS
        self.customTitleColor = AT_COLOR_WHITE
        self.customBgColor = AT_COLOR_BLUE_DARK
        self.customFont = UIFont.regularFont(size: AT_FONT_SIZE_NORMAL)
        
    }
    func setAttributedTitleColor(title: String, titleColor: UIColor, backgroundColor: UIColor){
        self.customBgColor = backgroundColor
        self.customTitleColor = titleColor
        self.setTitle(title, for: .normal)
    }
}

