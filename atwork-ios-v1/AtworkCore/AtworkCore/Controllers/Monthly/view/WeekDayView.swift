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
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "WeekDayView", bundle: bundle)
        self.contentView = nib.instantiate(withOwner: self, options: nil).first as? UIView
        self.contentView.frame = self.bounds
        self.contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(contentView)
        self.contentView.layer.borderWidth = 1
        self.contentView.layer.borderColor = AT_COLOR_BORDER.cgColor
    }
}
