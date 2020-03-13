//
//  CellOneLabel.swift
//  LiftWork
//
//  Created by CuongNV on 5/25/18.
//  Copyright © 2018 Trente. All rights reserved.
//

import UIKit

class LWCellOneLabel: UITableViewCell {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imgCheck: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        label.font = UIFont.systemFont(ofSize: AT_FONT_SIZE_NORMAL)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
