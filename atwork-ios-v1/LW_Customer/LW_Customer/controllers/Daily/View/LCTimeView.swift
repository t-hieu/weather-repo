//
//  LCTimeView.swift
//  LW_Customer
//
//  Created by TrungND on 9/13/18.
//  Copyright © 2018 Trente. All rights reserved.
//

import UIKit
import TrenteCoreSwift

class LCTimeView: UIView {

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
        Bundle.main.loadNibNamed("LCTimeView", owner: self, options: nil)
        self.contentView.frame = self.bounds
        self.contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
         addSubview(contentView);
        
        for index in 0..<24 {
            let timeView = self.viewTimeForSize(frame: CGRect.init(x: 0, y: CGFloat(index) * SCHEDULE_HEIGHT, width: self.contentView.frame.size.width, height: SCHEDULE_HEIGHT), timeLabel: "\(index)")
            self.contentView.addSubview(timeView)
        }
    }
    
    func viewTimeForSize(frame: CGRect, timeLabel: String) -> UIView {
        let view = UIView.init(frame: frame);
        let label = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: frame.size.width, height: frame.size.height));
        label.font = UIFont.systemFont(ofSize: SCHEDULE_FONT_SIZE, weight: UIFont.Weight.regular)
        label.textAlignment = NSTextAlignment.center
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.numberOfLines = 0
        label.text = timeLabel
        label.isUserInteractionEnabled = false
        label.layer.borderWidth = 0.5
        label.layer.borderColor = UIColor.init(hex:"D8D8D8").cgColor
        view.addSubview(label)
        return view
    }
}
