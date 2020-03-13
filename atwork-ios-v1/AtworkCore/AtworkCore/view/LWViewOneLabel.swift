//
//  LWViewOneLabel.swift
//  LiftWork
//
//  Created by CuongNV on 5/16/18.
//  Copyright © 2018 Trente. All rights reserved.
//

import UIKit

protocol LWViewOneLabelDelegate {
    func tapViewOneLabelInTime(view: LWViewOneLabel)
    func tapViewOneLabelInTitle(view: LWViewOneLabel)
}
class LWViewOneLabel: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var labTitle: UILabel!
    @IBOutlet weak var labTime: UILabel!
    @IBAction func tapTime(_ sender: Any) {
        self.delegate?.tapViewOneLabelInTime(view: self)
    }
    @IBOutlet weak var arrowImage: UIImageView!
    @IBAction func tapTitle(_ sender: Any) {
        self.delegate?.tapViewOneLabelInTitle(view: self)
    }
    var delegate: LWViewOneLabelDelegate?
    var isAbleTap: Bool?
    
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
//        Bundle.main.loadNibNamed("LWViewOneLabel", owner: self, options: nil)
//        addSubview(contentView)
//        contentView.frame = bounds
        
        contentView.backgroundColor = AT_COLOR_BLUE_LIGHT
        self.labTitle.font = UIFont.boldSystemFont(ofSize: AT_FONT_SIZE_BIG)
        self.labTime.font = UIFont.boldSystemFont(ofSize: AT_FONT_SIZE_NORMAL)
        
        
    }
    
    func setBackgoundColor(color: UIColor){
        self.contentView.backgroundColor = color
    }

}
