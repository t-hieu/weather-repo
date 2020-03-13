//
//  LWLiftMaterialTableViewCell.swift
//  LiftWork
//
//  Created by CuongNV on 5/14/18.
//  Copyright © 2018 Trente. All rights reserved.
//

import UIKit
protocol LWLiftMaterialTableViewCellDelegate {
    func tapLiftMaterialCellDelegate()
}

class LWLiftMaterialTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var unitTitle: UILabel!
    
    @IBOutlet weak var unitNumber: UITextField!
    
    @IBAction func tapContent(_ sender: Any) {
        delegate?.tapLiftMaterialCellDelegate()
    }
    @IBAction func tapContent2(_ sender: Any) {
        delegate?.tapLiftMaterialCellDelegate()
    }
    
    var delegate: LWLiftMaterialTableViewCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        titleLabel.text = NSLocalizedString("lw_character_lifting_material", comment: "")
        titleLabel.backgroundColor = LW_COLOR_TITLE_INPUT_PERFORMACE
        titleLabel.layer.borderWidth = 1
        titleLabel.font = UIFont.systemFont(ofSize: LW_FONT_SIZE_NORMAL)
//        contentTextView.layer.borderWidth = 0.5
        
        unitTitle.backgroundColor = LW_COLOR_TITLE_INPUT_PERFORMACE
        unitTitle.layer.borderWidth = 1
        unitTitle.font = UIFont.systemFont(ofSize: LW_FONT_SIZE_NORMAL)
        unitTitle.text = NSLocalizedString("lw_character_unit", comment: "")
        
        unitNumber.layer.borderWidth = 1
        unitNumber.font = UIFont.systemFont(ofSize: LW_FONT_SIZE_NORMAL)
        
        contentLabel.font = UIFont.systemFont(ofSize: LW_FONT_SIZE_NORMAL)
        self.layer.borderWidth = 1
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
