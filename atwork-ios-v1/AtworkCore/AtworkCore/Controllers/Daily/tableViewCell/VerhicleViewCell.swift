//
//  VerhicleViewCell.swift
//  AtworkCore
//
//  Created by CuongNV on 11/9/18.
//  Copyright © 2018 Atwork. All rights reserved.
//

import UIKit

class VerhicleViewCell: UITableViewCell {
    @IBOutlet weak var numTextField: LWBlackNormalRegularTextField!
    @IBOutlet weak var titleLabel: LWBlackNormalRegularLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
