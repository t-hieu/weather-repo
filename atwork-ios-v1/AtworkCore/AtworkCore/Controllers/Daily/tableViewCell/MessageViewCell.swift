//
//  MessageViewCell.swift
//  AtworkCore
//
//  Created by CuongNV on 10/8/18.
//  Copyright © 2018 Atwork. All rights reserved.
//

import UIKit

class MessageViewCell: UITableViewCell {
    @IBOutlet weak var titleView: UIView!
    
    @IBOutlet weak var titleLabel: LWBlackNormalRegularLabel!
    
    @IBOutlet weak var textContent: LWBlackNormalRegularTextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.titleView.backgroundColor = AT_COLOR_TITLE_INPUT_PERFORMACE
        self.contentView.layer.borderColor = AT_COLOR_BORDER.cgColor
        self.contentView.layer.borderWidth = 1
        
        self.selectionStyle = UITableViewCellSelectionStyle.none;
        textContent.isScrollEnabled = true
        textContent.isUserInteractionEnabled = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setActive(isActive: Bool){
        self.textContent.isEditable = isActive
        
    }
    
}
