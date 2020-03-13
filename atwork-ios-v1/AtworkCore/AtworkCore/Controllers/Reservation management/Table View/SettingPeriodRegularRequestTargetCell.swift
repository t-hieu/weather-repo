//
//  SettingPeriodRegularRequestTargetCell.swift
//  AtworkCore
//
//  Created by Trần Tiến Anh on 11/14/18.
//  Copyright © 2018 Atwork. All rights reserved.
//

import UIKit

class SettingPeriodRegularRequestTargetCell: UITableViewCell {
    @IBOutlet weak var TitleLable: UILabel!
    
    @IBOutlet weak var imgchoice: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        imgchoice.image = UIImage.init(named: "ic_radio_on")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        //        if indexPath.row == cellchosen {
//                    imgchoice.image = UIImage.init(named: "ic_radio_on")
        //            print(UIImage.init(named: "ic_radio_on"))
        //        }
        //        else {
        //            cell1?.imgchoice.image = UIImage.init(named: "ic_radio_off")
        //        }

        // Configure the view for the selected state
    }
    
}
