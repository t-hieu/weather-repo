//
//  TextFieldViewCell.swift
//  AtworkCore
//
//  Created by CuongNV on 10/11/18.
//  Copyright © 2018 Atwork. All rights reserved.
//

import UIKit

class TextFieldViewCell: UITableViewCell {

    @IBOutlet weak var textfield: LWBlackNormalRegularTextField!
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
