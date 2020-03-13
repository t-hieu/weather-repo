//
//  LWLabelLabelLabelTableViewCell.swift
//  LiftWork
//
//  Created by CuongNV on 5/11/18.
//  Copyright © 2018 Trente. All rights reserved.
//

import UIKit

class LWLabelLabelLabelTableViewCell: UITableViewCell {
    @IBOutlet weak var titleCell: UILabel!
    @IBOutlet weak var dateCell: UILabel!
    @IBOutlet weak var timeCell: UILabel!
    @IBOutlet weak var labConstruction: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleCell.font = UIFont.boldSystemFont(ofSize: LW_FONT_SIZE_BIG)
        dateCell.font = UIFont.systemFont(ofSize: LW_FONT_SIZE_NORMAL)
        timeCell.font = UIFont.systemFont(ofSize: LW_FONT_SIZE_NORMAL)
        labConstruction.font = UIFont.boldSystemFont(ofSize: LW_FONT_SIZE_BIG)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setDateTime(date: String, time: String){
        dateCell.text = date
        timeCell.text = time
    }
    
}
