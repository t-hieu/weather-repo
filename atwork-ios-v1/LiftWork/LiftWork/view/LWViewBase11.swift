//
//  LWViewBase11.swift
//  LiftWork
//
//  Created by CuongNV on 6/1/18.
//  Copyright © 2018 Trente. All rights reserved.
//

import UIKit

class LWViewBase11: UIView {

    @IBOutlet weak var labTitle: UILabel!
    @IBOutlet weak var labContent: UILabel!
    @IBOutlet var contentView: UIView!
    
    var delegate: LWViewBase35Delegate?
    var typeControl: String?
    var isAbleTap: Bool?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubview()
    }
    
    @IBOutlet weak var arrowImage: UIImageView!
    @IBAction func tapContentlab(_ sender: Any) {
        delegate?.TapContentLab(typeControl: typeControl!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSubview()
    }
    
    func initSubview() {
        
        Bundle.main.loadNibNamed("LWViewBase11", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        labTitle.layer.borderWidth = 1
        labTitle.layer.borderColor = LW_COLOR_BORDER.cgColor
        labTitle.backgroundColor = LW_COLOR_TITLE_INPUT_PERFORMACE
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = LW_COLOR_BORDER.cgColor
        labTitle.font = UIFont.systemFont(ofSize: LW_FONT_SIZE_NORMAL)
        labContent.font = UIFont.systemFont(ofSize: LW_FONT_SIZE_NORMAL)
    }

    func isHideArrow(isHide: Bool){
        self.arrowImage.isHidden = isHide
    }
}
