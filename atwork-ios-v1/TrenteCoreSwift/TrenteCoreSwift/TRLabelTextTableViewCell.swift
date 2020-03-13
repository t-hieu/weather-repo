//
//  TRLabelTextTableViewCell.swift
//  TrenteCoreSwift
//
//  Created by TrungND on 5/26/17.
//  Copyright © 2017 Trente. All rights reserved.
//

import UIKit

public class TRLabelTextTableViewCell: UITableViewCell {

    @IBOutlet weak public var label: UILabel!
    @IBOutlet weak public var contentTextView: UITextView!
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.layoutIfNeeded()
        self.label.font = UIFont.systemFont(ofSize: FONT_SIZE)
        self.contentTextView.font = UIFont.systemFont(ofSize: FONT_SIZE)
        self.label.textColor = TR_TEXT_COLOR_LIGHT
        self.contentTextView.textColor = TR_TEXT_COLOR
        self.contentTextView.textContainer.lineFragmentPadding = 0
        self.contentTextView.textContainerInset = UIEdgeInsets.init(top: 0, left: -self.contentTextView.textContainer.lineFragmentPadding, bottom: 0, right: contentTextView.textContainer.lineFragmentPadding)
    }
    
    public func getHeightForRow(content: String) -> CGFloat{
        self.contentTextView.text = content
        self.label.text = "None"
        let titleSize   =  self.label.sizeThatFits(self.label.bounds.size)
        let contentSize = self.contentTextView.sizeThatFits(self.contentTextView.bounds.size)
        return titleSize.height + contentSize.height + TR_TABLE_VIEW_CELL_PADDING_TOP + TR_TABLE_VIEW_CELL_PADDING_INNER + TR_TABLE_VIEW_CELL_PADDING_BOTTOM
    }

    override public func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
