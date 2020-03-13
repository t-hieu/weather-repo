//
//  LWTimeRowView.swift
//  LiftWork
//
//  Created by CuongNV on 6/1/18.
//  Copyright © 2018 Trente. All rights reserved.
//

import UIKit

class LWTimeRowView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var labTime: UILabel!
    @IBOutlet weak var labFrom: UILabel!
    @IBOutlet weak var labTo: UILabel!
    @IBOutlet weak var txFTime: UITextField!
    @IBOutlet weak var labContentFrom: UILabel!
    @IBOutlet weak var labContentTo: UILabel!
    
    @IBAction func contentFromTap(_ sender: Any) {
        delegate?.TapContentLab(typeControl: LW_BASE_VIEW_35_TYPE_TIME_FROM)
    }
    
    @IBAction func contentToTap(_ sender: Any) {
        delegate?.TapContentLab(typeControl: LW_BASE_VIEW_35_TYPE_TIME_TO)
    }
    
    var delegate: LWViewBase35Delegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSubview()
    }
    
    func initSubview() {
        
        Bundle.main.loadNibNamed("LWTimeRow3", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        
        labTime.layer.borderWidth = 1
        labTime.layer.borderColor = LW_COLOR_BORDER.cgColor
        labTime.backgroundColor = LW_COLOR_TITLE_INPUT_PERFORMACE
        labTime.text = NSLocalizedString("lw_character_time", comment: "")
        labTime.font = UIFont.systemFont(ofSize: LW_FONT_SIZE_NORMAL)
        
        labFrom.layer.borderWidth = 1
        labFrom.layer.borderColor = LW_COLOR_BORDER.cgColor
        labFrom.backgroundColor = LW_COLOR_TITLE_INPUT_PERFORMACE
        labFrom.text = NSLocalizedString("lw_character_from", comment: "")
        labFrom.font = UIFont.systemFont(ofSize: LW_FONT_SIZE_NORMAL)
        
        labTo.layer.borderWidth = 1
        labTo.layer.borderColor = LW_COLOR_BORDER.cgColor
        labTo.backgroundColor = LW_COLOR_TITLE_INPUT_PERFORMACE
        labTo.text = NSLocalizedString("lw_character_to", comment: "")
        labTo.font = UIFont.systemFont(ofSize: LW_FONT_SIZE_NORMAL)
        
//        txFTime.layer.borderWidth = 1
//        txFTime.layer.borderColor = LW_COLOR_BORDER.cgColor
        txFTime.font = UIFont.systemFont(ofSize: LW_FONT_SIZE_NORMAL)
//        labContentFrom.layer.borderWidth = 1
//        labContentFrom.layer.borderColor = LW_COLOR_BORDER.cgColor
        labContentFrom.font = UIFont.systemFont(ofSize: LW_FONT_SIZE_NORMAL)
//        labContentTo.layer.borderWidth = 1
//        labContentTo.layer.borderColor = LW_COLOR_BORDER.cgColor
        labContentTo.font = UIFont.systemFont(ofSize: LW_FONT_SIZE_NORMAL)
        
        self.layer.borderWidth = 1
        self.layer.borderColor = LW_COLOR_BORDER.cgColor
       
    }
    
    func setTitleBackgoundColor(color: UIColor){
        self.labTime.backgroundColor = color
        self.labFrom.backgroundColor = color
        self.labTo.backgroundColor = color
    }
}
