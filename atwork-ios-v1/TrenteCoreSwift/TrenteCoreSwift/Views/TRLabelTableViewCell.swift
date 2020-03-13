//
//  TRLabelTableViewCell.swift
//  TrenteCoreSwift
//
//  Created by TrungND on 8/22/17.
//  Copyright © 2017 Trente. All rights reserved.
//

import UIKit

public class TRLabelTableViewCell: UITableViewCell {

    
    @IBOutlet weak var label: UILabel!
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
//    
    public func setLabel(label: String) {
        self.label.text = label
    }
    
    public func setBackgroundColor(color: UIColor) {
        self.backgroundColor = color
    }

    public override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
