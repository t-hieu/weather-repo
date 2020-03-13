//
//  ATPersionInChargeSettingTableViewCell.swift
//  AtworkCore
//
//  Created by Trần Tiến Anh on 11/1/18.
//  Copyright © 2018 Atwork. All rights reserved.
//

import UIKit

class ATPersionInChargeSettingTableViewCell: UITableViewCell {
    @IBOutlet weak var ViewTitle: UIView!
    @IBOutlet weak var Title: UILabel!
    
    @IBOutlet weak var ViewContent: UIView!
    @IBOutlet weak var TextFieldContent: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.ViewTitle.backgroundColor =  AT_COLOR_TITLE_INPUT_PERFORMACE
        self.ViewTitle.layer.borderWidth = 0.5
        self.ViewTitle.layer.borderColor = AT_COLOR_BORDER.cgColor
        
        self.ViewContent.layer.borderWidth = 0.5
        self.ViewContent.layer.borderColor = AT_COLOR_BORDER.cgColor
        // Initialization code
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
