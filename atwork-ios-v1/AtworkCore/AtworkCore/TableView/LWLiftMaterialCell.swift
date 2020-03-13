//
//  LWLiftMaterialCell.swift
//  LiftWork
//
//  Created by CuongNV on 5/23/18.
//  Copyright © 2018 Trente. All rights reserved.
//

import UIKit

protocol LWLiftMaterialtCellDelegate {
    func tapLiftMatertial(tag: Int?)
}
class LWLiftMaterialCell: UITableViewCell {
    @IBOutlet weak var labelOne: UILabel!
    
    @IBOutlet weak var labelTwo: UILabel!
    
    @IBAction func tapLabelOne(_ sender: Any) {
        if(labelOne.tag >= 0){
            delegate?.tapLiftMatertial(tag: labelOne.tag)
        }
    }
    
    @IBAction func tapLabelTwo(_ sender: Any) {
        if(labelTwo.tag>=1) {
            delegate?.tapLiftMatertial(tag: labelTwo.tag)
        }
    }
    var delegate: LWLiftMaterialtCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        labelOne.font = UIFont.systemFont(ofSize: AT_FONT_SIZE_NORMAL)
        labelTwo.font = UIFont.systemFont(ofSize: AT_FONT_SIZE_NORMAL)
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setTextLabelOne(text: String) {
        labelOne.text = text
        labelOne.layer.borderWidth = 1
        labelOne.layer.borderColor = AT_COLOR_BORDER.cgColor
    }
    
    func setTextLabelTwo(text: String) {
        labelTwo.text = text
        labelTwo.layer.borderWidth = 1
        labelTwo.layer.borderColor = AT_COLOR_BORDER.cgColor
    }
    
}
