//
//  LWTextField.swift
//  LW_Customer
//
//  Created by CuongNV on 9/28/18.
//  Copyright © 2018 Trente. All rights reserved.
//

import UIKit
import TrenteCoreSwift

class LWTextField: TRTextField {
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}
class LWRoundedTextField: LWTextField {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.borderStyle = .none
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 5.0
        self.layer.masksToBounds = true
        self.layer.borderWidth = 1.0
        
    }
}
