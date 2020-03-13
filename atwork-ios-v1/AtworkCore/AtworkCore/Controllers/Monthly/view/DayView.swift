//
//  DayView.swift
//  LW_Customer
//
//  Created by CuongNV on 9/17/18.
//  Copyright © 2018 Trente. All rights reserved.
//

import UIKit
import TrenteCoreSwift

protocol DayViewDelegate {
    func tapDayView(dayView: DayView)
}

class DayView: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var dayTitle: UILabel!
    
    @IBOutlet weak var progressBar: ATProgressBar!
    @IBOutlet weak var buttonTap: UIButton!
    @IBAction func tapDayView(_ sender: Any) {
        self.delegate.tapDayView(dayView: self)
    }
    
    var dayModel: ATDailyModel!
    var delegate: DayViewDelegate!
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
        let nib = UINib(nibName: "DayView", bundle: bundle)
        self.contentView = nib.instantiate(withOwner: self, options: nil).first as? UIView
        
        self.contentView.frame = self.bounds
        self.contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.contentView.layer.borderWidth = 0.5
        self.contentView.layer.borderColor = AT_COLOR_BORDER.cgColor
        addSubview(contentView)
        self.removeTapDay()
       
    }
    
    func fillData(dayModel: ATDailyModel, cellWidth: CGFloat){
        self.dayModel = dayModel
        self.dayTitle.text = TRFormatUtil.formatDateCustom(date: dayModel.date, format: "d")
        self.dayTitle.textColor = TRColorUtil.getColor4Hexa(hexString: dayModel.textColorCode!)
        self.contentView.backgroundColor = TRColorUtil.getColor4Hexa(hexString: dayModel.bgColorCode!)

        if dayModel.isShowStatus {
            self.progressBar.isHidden = false
            var percent = dayModel.progress
            if percent! > 100 {
                percent = 100
            }
            self.progressBar.progress = CGFloat(percent!) / 100
            
        }else {
            self.progressBar.isHidden = true
        }
        
        self.removeTapDay()
    }

    func removeTapDay(){
        self.buttonTap.layer.borderWidth = 0
    }
    
    func TapDay(){
        self.buttonTap.layer.borderWidth = 3
        self.buttonTap.layer.borderColor = AT_COLOR_BLUE_DARK.cgColor
    }
}
