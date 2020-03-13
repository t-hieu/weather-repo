//
//  TRImageTableViewCell.swift
//  TrenteCoreSwift
//
//  Created by TrungND on 5/30/17.
//  Copyright © 2017 Trente. All rights reserved.
//

import UIKit

public class TRImageTableViewCell: UITableViewCell {

    @IBOutlet weak public var imageViewCell: UIImageView!
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    public override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
