//
//  PhoneNumberCell.swift
//  AtworkCore
//
//  Created by Trần Tiến Anh on 12/19/18.
//  Copyright © 2018 Atwork. All rights reserved.
//

import UIKit
protocol PhoneNumberCellDelegate {
    func call()  
}
class PhoneNumberCell: UITableViewCell {
    var delegate :PhoneNumberCellDelegate!
    @IBOutlet weak var label: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
       self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
