//
//  LWBasicInformationTableViewCell.swift
//  LiftWork
//
//  Created by CuongNV on 5/11/18.
//  Copyright © 2018 Trente. All rights reserved.
//

import UIKit

class LWBasicInformationTableViewCell: UITableViewCell {
    @IBOutlet weak var labELV: UILabel!
    @IBOutlet weak var labELVContent: UILabel!
    @IBOutlet weak var labOperator: UILabel!
    @IBOutlet weak var labOperatorContent: UILabel!
    
    var delegate: LWViewBase35Delegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        labELV.layer.borderWidth = 1
        labELV.backgroundColor = LW_COLOR_TITLE_INPUT_PERFORMACE
        labELV.font = UIFont.systemFont(ofSize: LW_FONT_SIZE_NORMAL)
        
        labELVContent.layer.borderWidth = 1
        labELVContent.font = UIFont.systemFont(ofSize: LW_FONT_SIZE_NORMAL)
        
        labOperator.layer.borderWidth = 1
        labOperator.backgroundColor = LW_COLOR_TITLE_INPUT_PERFORMACE
        labOperator.font = UIFont.systemFont(ofSize: LW_FONT_SIZE_NORMAL)
        
        labOperatorContent.layer.borderWidth = 1
        labOperatorContent.font = UIFont.systemFont(ofSize: LW_FONT_SIZE_NORMAL)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func tapELVContent(_ sender: Any) {
        delegate?.TapContentLab(typeControl: LW_BASE_VIEW_35_TYPE_ELV)
    }
    
    @IBAction func tapOperatorContent(_ sender: Any) {
        delegate?.TapContentLab(typeControl: LW_BASE_VIEW_35_TYPE_OPERATOR)
    }
}
