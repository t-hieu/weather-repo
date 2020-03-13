//
//  LWLabel.swift
//  LiftWork
//
//  Created by VietND on 6/7/18.
//  Copyright © 2018 Trente. All rights reserved.
//

import UIKit
import TrenteCoreSwift

class LWLabel: TRLabel {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

class LWNormalRegularLabel:LWLabel{
    override func awakeFromNib() {
        super.awakeFromNib()
        self.customFont = UIFont.regularFont(size: LW_FONT_SIZE_NORMAL)
    }
}

class LWnormalBoldLabel:LWLabel{
    override func awakeFromNib() {
        super.awakeFromNib()
        self.customFont = UIFont.boldFont(size: LW_FONT_SIZE_NORMAL)
        
    }
}

class LWBlackNormalRegularLabel:LWNormalRegularLabel{
    override func awakeFromNib() {
        super.awakeFromNib()
        self.customTextColor = LW_COLOR_BLACK
        
    }
}

class LWBlackNormalBoldLabel:LWnormalBoldLabel{
    override func awakeFromNib() {
        super.awakeFromNib()
        self.customTextColor = LW_COLOR_BLACK
        
    }
}


class LWBigBoldLabel:LWLabel{
    override func awakeFromNib() {
        super.awakeFromNib()
        self.customFont = UIFont.boldFont(size: LW_FONT_SIZE_BIG)
    }
}

