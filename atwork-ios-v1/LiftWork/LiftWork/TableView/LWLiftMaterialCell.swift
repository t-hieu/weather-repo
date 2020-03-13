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
    //Hieu
    var labelOneSelected: Bool = false
    var labelTwoSelected: Bool = false
    //End
    @IBAction func tapLabelOne(_ sender: Any) {
        if(labelOne.tag >= 0){
            //Hieu
            labelOneSelected = !labelOneSelected
            if labelOneSelected{
                labelOne.backgroundColor = LW_COLOR_TITLE_INPUT_PERFORMACE
            }else{
                labelOne.backgroundColor = LW_COLOR_WHITE
            }
            //End
            delegate?.tapLiftMatertial(tag: labelOne.tag)
        }
    }
    
    @IBAction func tapLabelTwo(_ sender: Any) {
        if(labelTwo.tag>=1) {
            //Hieu
            labelTwoSelected = !labelTwoSelected
            if labelTwoSelected{
                labelTwo.backgroundColor = LW_COLOR_TITLE_INPUT_PERFORMACE
            }else{
                labelTwo.backgroundColor = LW_COLOR_WHITE
            }
            //End
            delegate?.tapLiftMatertial(tag: labelTwo.tag)
        }
    }
    var delegate: LWLiftMaterialtCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        labelOne.font = UIFont.systemFont(ofSize: LW_FONT_SIZE_NORMAL)
        labelTwo.font = UIFont.systemFont(ofSize: LW_FONT_SIZE_NORMAL)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setTextLabelOne(text: String) {
        labelOne.text = text
        labelOne.layer.borderWidth = 1
        labelOne.layer.borderColor = LW_COLOR_BORDER.cgColor
    }
    
    func setTextLabelTwo(text: String) {
        labelTwo.text = text
        labelTwo.layer.borderWidth = 1
        labelTwo.layer.borderColor = LW_COLOR_BORDER.cgColor
    }
    
}
