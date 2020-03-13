//
//  LWPerformanceTableViewCell.swift
//  LiftWork
//
//  Created by CuongNV on 5/28/18.
//  Copyright © 2018 Trente. All rights reserved.
//

import UIKit

class LWPerformanceTableViewCell: UITableViewCell {
   
    @IBOutlet weak var view: LWPerformanceCell!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func showData(time: String, customer: String, liftmaterial: String, fromto: String){
        view.timeLabel.text = time
        view.customerLabel.text = customer
        view.liftMaterialLabel.text = liftmaterial
        view.fromToLabel.text = fromto
    }
    
}
