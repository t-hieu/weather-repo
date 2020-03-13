//
//  CustomerInputTableViewCell.swift
//  LiftWork
//
//  Created by CuongNV on 5/14/18.
//  Copyright © 2018 Trente. All rights reserved.
//

import UIKit

protocol CustomerInputDelegate {
    func customerInputDelegateTap()
}

class CustomerInputTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
   
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBAction func contentTap(_ sender: Any) {
        delegate?.customerInputDelegateTap()
    }
    
    var delegate: CustomerInputDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        titleLabel.backgroundColor = AT_COLOR_TITLE_INPUT_PERFORMACE
        titleLabel.text = "Customer"
        titleLabel.layer.borderWidth = 1
        titleLabel.font = UIFont.systemFont(ofSize: AT_FONT_SIZE_NORMAL)
       
        self.layer.borderWidth = 1
        contentLabel.font = UIFont.systemFont(ofSize: AT_FONT_SIZE_NORMAL)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
   
    
}
