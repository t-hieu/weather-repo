//
//  MonthlyViewCell.swift
//  AtworkCore
//
//  Created by CuongNV on 10/19/18.
//  Copyright © 2018 Atwork. All rights reserved.
//

import UIKit

class MonthlyViewCell: UITableViewCell {
    @IBOutlet weak var dayOne: DayView!
    @IBOutlet weak var dayTwo: DayView!
    @IBOutlet weak var dayThree: DayView!
    @IBOutlet weak var dayFour: DayView!
    @IBOutlet weak var dayFive: DayView!
    @IBOutlet weak var daySix: DayView!
    @IBOutlet weak var daySeven: DayView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.layer.borderWidth = 1
        self.contentView.layer.borderColor = AT_COLOR_BORDER.cgColor
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fillData(dailies: [ATDailyModel], week: Int, delegate: DayViewDelegate, indexChose: Int!, cellWidth: CGFloat){
        if(week * 7 + 6 < dailies.count){
            dayOne.delegate = delegate
            dayOne.fillData(dayModel: dailies[week * 7], cellWidth: cellWidth)
            
            
            dayTwo.delegate = delegate
            dayTwo.fillData(dayModel: dailies[week * 7 + 1], cellWidth: cellWidth)
            
            dayThree.delegate = delegate
            dayThree.fillData(dayModel: dailies[week * 7 + 2], cellWidth: cellWidth)
            
            dayFour.delegate = delegate
            dayFour.fillData(dayModel: dailies[week * 7 + 3], cellWidth: cellWidth)
            
            dayFive.delegate = delegate
            dayFive.fillData(dayModel: dailies[week * 7 + 4], cellWidth: cellWidth)
            
            daySix.delegate = delegate
            daySix.fillData(dayModel: dailies[week * 7 + 5], cellWidth: cellWidth)
            
            daySeven.delegate = delegate
            daySeven.fillData(dayModel: dailies[week * 7 + 6], cellWidth: cellWidth)
            
            switch indexChose {
            case week * 7 :
                dayOne.TapDay()
                break
            case week * 7 + 1:
                dayTwo.TapDay()
                break
            case week * 7 + 2:
                dayThree.TapDay()
                break
            case week * 7 + 3:
                dayFour.TapDay()
                break
            case week * 7 + 4:
                dayFive.TapDay()
                break
            case week * 7 + 5:
                daySix.TapDay()
                break
            case week * 7 + 6:
                daySeven.TapDay()
                break
            default:
                break
            }
            
        }
    }
}
