//
//  WeekDayView.swift
//  LW_Customer
//
//  Created by CuongNV on 9/17/18.
//  Copyright © 2018 Trente. All rights reserved.
//

import UIKit

class WeekDayView: UIView {
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var dayOne: DayView!
     @IBOutlet weak var dayTwo: DayView!
     @IBOutlet weak var dayThree: DayView!
     @IBOutlet weak var dayFour: DayView!
     @IBOutlet weak var dayFive: DayView!
     @IBOutlet weak var daySix: DayView!
     @IBOutlet weak var daySeven: DayView!
    
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubview()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSubview()
    }
    
    func initSubview() {
        fromNib()
        self.contentView.layer.borderWidth = 1
        self.contentView.layer.borderColor = LW_COLOR_BORDER.cgColor
//        self.contentView.backgroundColor = LW_COLOR_TITLE_INPUT_PERFORMACE
       
    }
    
    func fillData(dates:[Int], index: Int) {
        if(index + 6 >=  dates.count){ return }
        dayOne.dayTitle.text = "\(dates[index])"
        dayTwo.dayTitle.text = "\(dates[index + 1])"
        dayThree.dayTitle.text = "\(dates[index + 2])"
        dayFour.dayTitle.text = "\(dates[index + 3])"
        dayFive.dayTitle.text = "\(dates[index + 4])"
        daySix.dayTitle.text = "\(dates[index + 5])"
        daySeven.dayTitle.text = "\(dates[index + 6])"
        
        dayOne.updatePercentWidth(percent: CGFloat(dates[index] * 100 / 31))
        dayTwo.updatePercentWidth(percent: CGFloat(dates[index + 1] * 100 / 31))
        dayThree.updatePercentWidth(percent: CGFloat(dates[index + 2] * 100 / 31))
        dayFour.updatePercentWidth(percent: CGFloat(dates[index + 3] * 100 / 31))
        dayFive.updatePercentWidth(percent: CGFloat(dates[index + 4] * 100 / 31))
        daySix.updatePercentWidth(percent: CGFloat(dates[index + 5] * 100 / 31))
        daySeven.updatePercentWidth(percent: CGFloat(dates[index + 6] * 100 / 31))
        
//        dayOne.updatePercentWidth(percent: CGFloat(dates[index] * 100 / 31))
//        dayTwo.updatePercentWidth(percent: CGFloat(dates[index + 1] * 100 / 31))
//        dayThree.updatePercentWidth(percent: CGFloat(dates[index + 2] * 100 / 31))
//        dayFour.updatePercentWidth(percent: CGFloat(dates[index + 3] * 100 / 31))
//        dayFive.updatePercentWidth(percent: CGFloat(dates[index + 4] * 100 / 31))
//        daySix.updatePercentWidth(percent: CGFloat(dates[index + 5] * 100 / 31))
//        daySeven.updatePercentWidth(percent: CGFloat(dates[index + 6] * 100 / 31))
        
        
        
    }
    
    func fillColor(state: String){
        if state == "0"{
            dayOne.updateBackGroundColor(state: "2")
        }else {
            dayOne.updateBackGroundColor(state: state)
        }
        dayTwo.updateBackGroundColor(state: state)
        dayThree.updateBackGroundColor(state: state)
        dayFour.updateBackGroundColor(state: state)
        dayFive.updateBackGroundColor(state: state)
        daySix.updateBackGroundColor(state: state)
        daySeven.updateBackGroundColor(state: state)
    }
}
