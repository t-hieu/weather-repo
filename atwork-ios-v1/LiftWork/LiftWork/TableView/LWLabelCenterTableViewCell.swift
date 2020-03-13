//
//  LWLabelCenterTableViewCell.swift
//  LiftWork
//
//  Created by CuongNV on 9/13/18.
//  Copyright © 2018 Trente. All rights reserved.
//

import UIKit

class LWLabelCenterTableViewCell: UITableViewCell {
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        label.font = UIFont.systemFont(ofSize: LW_FONT_SIZE_NORMAL)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
}
