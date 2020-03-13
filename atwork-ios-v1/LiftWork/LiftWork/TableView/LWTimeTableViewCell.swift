//
//  LWTimeTableViewCell.swift
//  LiftWork
//
//  Created by CuongNV on 5/15/18.
//  Copyright © 2018 Trente. All rights reserved.
//

import UIKit

class LWTimeTableViewCell: UITableViewCell {
    @IBOutlet weak var labTime: UILabel!
    @IBOutlet weak var labFrom: UILabel!
    @IBOutlet weak var labTo: UILabel!
    @IBOutlet weak var txFTime: UITextField!
    @IBOutlet weak var labContentFrom: UILabel!
    @IBOutlet weak var labContentTo: UILabel!
    
    @IBAction func contentFromTap(_ sender: Any) {
        delegate?.TapContentLab(typeControl: LW_BASE_VIEW_35_TYPE_TIME_FROM)
    }
    
    @IBAction func contentToTap(_ sender: Any) {
        delegate?.TapContentLab(typeControl: LW_BASE_VIEW_35_TYPE_TIME_TO)
    }
    
    var delegate: LWViewBase35Delegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        labTime.layer.borderWidth = 1
        labTime.backgroundColor = LW_COLOR_TITLE_INPUT_PERFORMACE
        labTime.text = NSLocalizedString("lw_character_time", comment: "")
        labTime.font = UIFont.systemFont(ofSize: LW_FONT_SIZE_NORMAL)
        
        labFrom.layer.borderWidth = 1
        labFrom.backgroundColor = LW_COLOR_TITLE_INPUT_PERFORMACE
        labFrom.text = NSLocalizedString("lw_character_from", comment: "")
        labFrom.font = UIFont.systemFont(ofSize: LW_FONT_SIZE_NORMAL)
        
        labTo.layer.borderWidth = 1
        labTo.backgroundColor = LW_COLOR_TITLE_INPUT_PERFORMACE
        labTo.text = NSLocalizedString("lw_character_to", comment: "")
        labTo.font = UIFont.systemFont(ofSize: LW_FONT_SIZE_NORMAL)
        
        txFTime.layer.borderWidth = 1
        txFTime.font = UIFont.systemFont(ofSize: LW_FONT_SIZE_NORMAL)
        labContentFrom.layer.borderWidth = 1
        labContentFrom.font = UIFont.systemFont(ofSize: LW_FONT_SIZE_NORMAL)
        labContentTo.layer.borderWidth = 1
        labContentTo.font = UIFont.systemFont(ofSize: LW_FONT_SIZE_NORMAL)
        
        self.layer.borderWidth = 1
//        self.txFTime.keyboardType = UIKeyboardType.numberPad
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
