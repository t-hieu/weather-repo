//
//  ViewFullLabelCell.swift
//  AtworkCore
//
//  Created by CuongNV on 10/19/18.
//  Copyright © 2018 Atwork. All rights reserved.
//

import UIKit

public class ViewFullLabelCell: UITableViewCell {
    @IBOutlet weak public var label: UILabel!
    
    @IBOutlet weak public var arrowRight: UIButton!
    override public func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override public func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
