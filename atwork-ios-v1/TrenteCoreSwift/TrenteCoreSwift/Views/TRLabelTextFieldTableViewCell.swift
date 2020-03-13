//
//  TRLabelTextFieldTableViewCell.swift
//  TrenteCoreSwift
//
//  Created by HtHoan on 5/29/17.
//  Copyright © 2017 Trente. All rights reserved.
//

import UIKit

public class TRLabelTextFieldTableViewCell: UITableViewCell {
    
    @IBOutlet weak public var label: UILabel!
    
    @IBOutlet weak public var contentTextField: UITextField!
    override public func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layoutIfNeeded()
        self.label.font = UIFont.systemFont(ofSize: FONT_SIZE)
        self.contentTextField.font = UIFont.systemFont(ofSize: FONT_SIZE)
        self.label.textColor = TR_TEXT_COLOR_LIGHT
        self.contentTextField.textColor = TR_TEXT_COLOR
        
    }
    public func getHeightForRow(content: String) -> CGFloat{
        self.contentTextField.text = content
        self.label.text = "None"
        let titleSize   =  self.label.sizeThatFits(self.label.bounds.size)
        let contentSize = self.contentTextField.sizeThatFits(self.contentTextField.bounds.size)
        return titleSize.height + contentSize.height + TR_TABLE_VIEW_CELL_PADDING_TOP + TR_TABLE_VIEW_CELL_PADDING_INNER + TR_TABLE_VIEW_CELL_PADDING_BOTTOM
    }
    
    override public func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    
}
