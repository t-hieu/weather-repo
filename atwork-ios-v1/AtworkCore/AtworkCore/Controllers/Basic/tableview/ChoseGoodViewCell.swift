//
//  ChoseGoodViewCell.swift
//  AtworkCore
//
//  Created by CuongNV on 11/8/18.
//  Copyright © 2018 Atwork. All rights reserved.
//

import UIKit

class ChoseGoodViewCell: UITableViewCell {
    @IBOutlet weak var valueLabel: LWBlackNormalRegularLabel!
    
    @IBOutlet weak var statusLabel: LWBlackNormalRegularLabel!
    
    @IBOutlet weak var checkImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
