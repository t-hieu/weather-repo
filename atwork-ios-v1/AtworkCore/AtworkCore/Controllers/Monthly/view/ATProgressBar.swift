//
//  ATProgressBar.swift
//  AtworkCore
//
//  Created by CuongNV on 1/4/19.
//  Copyright © 2019 Atwork. All rights reserved.
//

import UIKit

class ATProgressBar: UIView {
    @IBOutlet weak var progressWidth: NSLayoutConstraint!
    @IBOutlet var contentView: UIView!
    var progress: CGFloat! = 0
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
        let nib = UINib(nibName: "ATProgressBar", bundle: bundle)
        self.contentView = nib.instantiate(withOwner: self, options: nil).first as? UIView
        
        self.contentView.frame = self.bounds
        self.contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.contentView.layer.borderWidth = 1
        self.contentView.layer.borderColor = AT_COLOR_BLACK.cgColor
        addSubview(contentView)
//        self.viewPercent.layer.borderWidth = 1
//        self.viewPercent.layer.borderColor = AT_COLOR_BLACK.cgColor
//        self.removeTapDay()
        
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let width = self.contentView.bounds.size.width
        self.progressWidth.constant = (width - 2) * self.progress
    }
    

}
