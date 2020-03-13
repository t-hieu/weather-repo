//
//  LCDailyPartView.swift
//  LW_Customer
//
//  Created by CuongNV on 9/24/18.
//  Copyright © 2018 Trente. All rights reserved.
//

import UIKit

class LCDailyPartView: UIView {

    @IBOutlet var contentView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubview();
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSubview();
    }
    
    func initSubview() {
        Bundle.main.loadNibNamed("LCDailyPartView", owner: self, options: nil)
        self.contentView.frame = self.bounds
        
        self.contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(contentView);
        
//        let label = UILabel.init(frame: self.bounds);
//        label.backgroundColor = UIColor.blue
        
//        self.contentView.addSubview(label)
        
        for index in 0..<24 {
            let timeView = self.addLine(frame: CGRect.init(x: -20, y: CGFloat(index) * SCHEDULE_HEIGHT, width: self.contentView.frame.size.width + 200, height: SCHEDULE_HEIGHT), timeLabel: "\(index)")
            self.contentView.addSubview(timeView)
        }
        
//        let text = addPerformanceView(frame: CGRect.init(x: 0, y: CGFloat(2) * SCHEDULE_HEIGHT, width: self.contentView.frame.width/2, height: SCHEDULE_HEIGHT), labelTitle: "kaka", color: UIColor.red)
//        self.contentView.addSubview(text)
//        
//        let text1 = addPerformanceView(frame: CGRect.init(x: self.contentView.frame.size.width/2, y: CGFloat(2) * SCHEDULE_HEIGHT, width: self.contentView.frame.size.width/2, height: SCHEDULE_HEIGHT), labelTitle: "kaka", color: UIColor.red)
//        self.contentView.addSubview(text1)
    }
    
    func addLine(frame: CGRect, timeLabel: String) -> UIView {
        let view = UIView.init(frame: frame);
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.init(hex:"D8D8D8").cgColor
        return view
    }
    
    func addPerformanceView(frame: CGRect, labelTitle: String, color: UIColor) -> UILabel{
//        let view = UIView.init(frame: frame);
        let label = UILabel.init(frame: frame);
        label.font = UIFont.systemFont(ofSize: SCHEDULE_FONT_SIZE, weight: UIFont.Weight.regular)
        label.textAlignment = NSTextAlignment.center
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.numberOfLines = 0
        label.text = labelTitle
        label.isUserInteractionEnabled = false
        label.layer.borderWidth = 0.5
        label.layer.borderColor = UIColor.black.cgColor
        label.backgroundColor = color
//        view.addSubview(label)
        return label
    }
    
    func addPerformance(timerTest: TimerTestModel){
        let width = self.contentView.frame.size.width / CGFloat(timerTest.numberSameCurrentTime)
        let x = CGFloat(timerTest.currentIndex) * width
        let y = CGFloat(timerTest.startTimeHour * 60 + timerTest.startTimeMin)/60 * SCHEDULE_HEIGHT
        let height = CGFloat((timerTest.endTimeHour - timerTest.startTimeHour) * 60 +  timerTest.endTimeMin - timerTest.startTimeMin ) / 60 * SCHEDULE_HEIGHT
        
        let text = addPerformanceView(frame: CGRect.init(x: x, y: y, width: width, height: height), labelTitle: timerTest.titleLabel, color: UIColor.red)
        self.contentView.addSubview(text)
    }
    
    

}
