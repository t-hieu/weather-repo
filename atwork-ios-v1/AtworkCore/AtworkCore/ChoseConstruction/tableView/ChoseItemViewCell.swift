//
//  ChoseItemViewCell.swift
//  AtworkCore
//
//  Created by CuongNV on 11/7/18.
//  Copyright © 2018 Atwork. All rights reserved.
//

import UIKit

class ChoseItemViewCell: UITableViewCell {
    @IBOutlet weak var statusLabel: LWBlackNormalRegularLabel!
    
    @IBOutlet weak var valueLabel: LWBlackNormalRegularLabel!
    @IBOutlet weak var statusView: UIView!
    
    @IBOutlet weak var valueView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
