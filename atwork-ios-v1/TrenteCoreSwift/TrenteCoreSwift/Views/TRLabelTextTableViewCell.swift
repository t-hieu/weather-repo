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
    
    @IBOutlet weak public var textViewTrailing: NSLayoutConstraint!
    
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
        
        self.contentTextView.layer.borderColor = UIColor.red.cgColor
        self.contentTextView.layer.borderWidth = 1
    }
    
    public func getHeightForRow(content: String, isDisclosure: Bool) -> CGFloat{
        self.contentTextView.text = content
        self.label.text = "None"
        let titleSize   = self.label.sizeThatFits(self.label.bounds.size)
        
        let screenWidth = UIScreen.main.bounds.width
        var textViewWidth = screenWidth - TR_TABLE_VIEW_CELL_PADDING_LEFT
        if(isDisclosure){
            textViewWidth -= 40
        }else{
            textViewWidth -= TR_TABLE_VIEW_CELL_PADDING_RIGHT
        }
        
        let contentSize = self.contentTextView.sizeThatFits(CGSize.init(width: textViewWidth, height: self.contentTextView.bounds.size.width))
        return titleSize.height + contentSize.height + TR_TABLE_VIEW_CELL_PADDING_TOP + TR_TABLE_VIEW_CELL_PADDING_INNER + TR_TABLE_VIEW_CELL_PADDING_BOTTOM
    }
    
    override public func layoutSubviews(){
        super.layoutSubviews()
    }

    override public func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
