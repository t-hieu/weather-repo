//
//  FromToViewCell.swift
//  AtworkCore
//
//  Created by CuongNV on 10/8/18.
//  Copyright © 2018 Atwork. All rights reserved.
//

import UIKit

protocol FromToViewCellDelegate {
    func tapContentFromTo(isFrom: Bool, tag: Int)
}
class FromToViewCell: UITableViewCell {
    @IBOutlet weak var viewTitle: UIView!
    @IBOutlet weak var labelTitle: LWBlackNormalRegularLabel!
    
    @IBOutlet weak var labelFrom: LWBlackNormalRegularLabel!
    
    @IBOutlet weak var viewFrom: UIView!
    
    @IBOutlet weak var viewTo: UIView!
    
    @IBOutlet weak var labelTo: LWBlackNormalRegularLabel!
    @IBOutlet weak var labelCenter: UILabel!
    
    @IBAction func tapFrom(_ sender: Any) {
        delegate!.tapContentFromTo(isFrom: true, tag: self.tagView)
    }
    
    @IBAction func tapTo(_ sender: Any) {
        if delegate != nil {
            delegate!.tapContentFromTo(isFrom: false, tag: self.tagView)
        }
    }
    
    @IBOutlet weak var btTapTo: UIButton!
    @IBOutlet weak var btTapFrom: UIButton!
    
    var delegate: FromToViewCellDelegate?
    var tagView: Int!
    override func awakeFromNib() {
        super.awakeFromNib()
        viewTitle.backgroundColor = AT_COLOR_TITLE_INPUT_PERFORMACE
        viewTitle.layer.borderWidth = 1
        viewTitle.layer.borderColor = AT_COLOR_BORDER.cgColor
        
        viewFrom.layer.borderWidth = 1
        viewFrom.layer.borderColor = AT_COLOR_BORDER.cgColor
        viewTo.layer.borderWidth = 1
        viewTo.layer.borderColor = AT_COLOR_BORDER.cgColor
        
        labelCenter.backgroundColor = AT_COLOR_TITLE_INPUT_PERFORMACE
        self.labelCenter.layer.borderColor = AT_COLOR_BORDER.cgColor
        self.labelCenter.layer.borderWidth = 1
        self.selectionStyle = UITableViewCellSelectionStyle.none;
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setActive(isActive: Bool){
        btTapFrom.isUserInteractionEnabled = isActive
        btTapTo.isUserInteractionEnabled = isActive
        
    }
    
    func setContentText(isFrom: Bool, contentText: String?){
        var text : String
        if contentText != nil {
            text = contentText!
        }else {
            text = ""
        }
        if isFrom {
            self.labelFrom.text = text
        }else {
            self.labelTo.text = text
        }
        
    }
    func updateData(titleText: String, contentTextFrom: String, contentTextTo: String, textAlignment: NSTextAlignment, tagView: Int, isActive: Bool, delegate: FromToViewCellDelegate, isForce: Bool){
        self.setActive(isActive: isActive)
        self.labelTitle.text = titleText
        self.labelFrom.text = contentTextFrom
        self.labelTo.text = contentTextTo
        self.tagView = tagView
        self.delegate = delegate
        if(isActive && isForce && contentTextFrom == ""){
            self.viewFrom.backgroundColor =  AT_FILL_IN_TEXTFIELD_ADD_NEW_schedule
            self.viewFrom.layer.borderColor = UIColor.orange.cgColor
        }else {
            self.viewFrom.backgroundColor = AT_COLOR_WHITE
            self.viewFrom.layer.borderColor = AT_COLOR_BORDER.cgColor
        }
        
        if(isActive && isForce && contentTextTo == ""){
            self.viewTo.backgroundColor =  AT_FILL_IN_TEXTFIELD_ADD_NEW_schedule
            self.viewTo.layer.borderColor = UIColor.orange.cgColor
        }else {
            self.viewTo.backgroundColor = AT_COLOR_WHITE
            self.viewTo.layer.borderColor = AT_COLOR_BORDER.cgColor
        }
        
        self.labelFrom.textAlignment = textAlignment
        self.labelTo.textAlignment = textAlignment
        
    }
    
    
}
