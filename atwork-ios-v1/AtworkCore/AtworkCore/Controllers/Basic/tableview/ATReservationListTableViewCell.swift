//
//  ATReservationListTableViewCell.swift
//  AtworkCore
//
//  Created by Trần Tiến Anh on 11/2/18.
//  Copyright © 2018 Atwork. All rights reserved.
//

import UIKit

class ATReservationListTableViewCell: UITableViewCell {

    @IBOutlet weak var lbRequestStatus: UILabel!
    @IBOutlet weak var lbmonthDate: UILabel!
    @IBOutlet weak var lbtime: UILabel!
    @IBOutlet weak var lbContruction: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
