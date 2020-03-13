//
//  OwnerViewCell.swift
//  AtworkCore
//
//  Created by CuongNV on 11/8/18.
//  Copyright © 2018 Atwork. All rights reserved.
//

import UIKit

class OwnerViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: LWBlackNormalRegularLabel!
    
    @IBOutlet weak var contentLabel: LWBlackNormalRegularLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentView.layer.borderColor = AT_COLOR_BORDER.cgColor
        self.contentView.layer.borderWidth = 1
        self.contentView.backgroundColor = AT_COLOR_TITLE_INPUT_PERFORMACE
        self.selectionStyle = UITableViewCellSelectionStyle.none;
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
