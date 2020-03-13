//
//  LWViewBase35.swift
//  LiftWork
//
//  Created by CuongNV on 5/17/18.
//  Copyright © 2018 Trente. All rights reserved.
//

import UIKit

protocol LWViewBase35Delegate {
    func TapContentLab(typeControl: String)
}

class LWViewBase35: UIView {
    @IBOutlet weak var labTitle: UILabel!
    @IBOutlet weak var labContent: UILabel!
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var arrowImage: UIImageView!
    
    var delegate: LWViewBase35Delegate?
    var typeControl: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubview()
    }
    
    @IBAction func tapContentlab(_ sender: Any) {
        delegate?.TapContentLab(typeControl: typeControl!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSubview()
    }
    
    func initSubview() {
        
        Bundle.main.loadNibNamed("LWViewBase35", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        labTitle.layer.borderWidth = 1
        labTitle.backgroundColor = LW_COLOR_TITLE_INPUT_PERFORMACE
        contentView.layer.borderWidth = 1
        
        labTitle.font = UIFont.systemFont(ofSize: LW_FONT_SIZE_NORMAL)
        labContent.font = UIFont.systemFont(ofSize: LW_FONT_SIZE_NORMAL)
        labTitle.layer.borderColor = LW_COLOR_BORDER.cgColor
        contentView.layer.borderColor = LW_COLOR_BORDER.cgColor
    }
    
    func isHideArrow(isHide: Bool){
        self.arrowImage.isHidden = isHide
    }

}
