//
//  FromTo3ViewCell.swift
//  AtworkCore
//
//  Created by dangquang-hieu on 2020/01/08.
//  Copyright © 2020 Atwork. All rights reserved.
//

import UIKit

enum Floor{
    case From, To, To2, To3
}

protocol FromTo3ViewCellDelegate {
    func tapContentFromTo3(floor: Floor, tag: Int)
}

class FromTo3ViewCell: UITableViewCell {
    
    var delegate: FromTo3ViewCellDelegate?
    var tagView: Int!
    
    @IBOutlet weak var viewTitle: UIView!
    @IBOutlet weak var labelTitle: LWBlackNormalRegularLabel!
    @IBOutlet weak var labelCenter: UILabel!
    
    
    @IBOutlet weak var viewFrom: UIView!
    @IBOutlet weak var labelFrom: LWBlackNormalRegularLabel!
    @IBOutlet weak var btTapFrom: UIButton!
    
    @IBOutlet weak var viewTo: UIView!
    @IBOutlet weak var labelTo: LWBlackNormalRegularLabel!
    @IBOutlet weak var btTapTo: UIButton!
    
    @IBOutlet weak var viewTo2: UIView!
    @IBOutlet weak var labelTo2: LWBlackNormalRegularLabel!
    @IBOutlet weak var btTapTo2: UIButton!
    
    @IBOutlet weak var viewTo3: UIView!
    @IBOutlet weak var labelTo3: LWBlackNormalRegularLabel!
    @IBOutlet weak var btTapTo3: UIButton!
    
    @IBAction func tapFrom(_ sender: Any) {
        delegate!.tapContentFromTo3(floor: .From, tag: TAG_ROW_FROM)
    }
    
    @IBAction func tapTo(_ sender: Any) {
        if delegate != nil {
            delegate!.tapContentFromTo3(floor: .To, tag: TAG_ROW_TO)
        }
    }
    
    @IBAction func tapTo2(_ sender: Any) {
        if delegate != nil {
            delegate!.tapContentFromTo3(floor: .To2, tag: TAG_ROW_TO2)
        }
    }
    
    @IBAction func tapTo3(_ sender: Any) {
        if delegate != nil {
            delegate!.tapContentFromTo3(floor: .To3, tag: TAG_ROW_TO3)
        }
    }
    
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
        
        viewTo2.layer.borderWidth = 1
        viewTo2.layer.borderColor = AT_COLOR_BORDER.cgColor
        
        viewTo3.layer.borderWidth = 1
        viewTo3.layer.borderColor = AT_COLOR_BORDER.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setActive(isActive: Bool){
        btTapFrom.isUserInteractionEnabled = isActive
        btTapTo.isUserInteractionEnabled = isActive
        btTapTo2.isUserInteractionEnabled = isActive
        btTapTo3.isUserInteractionEnabled = isActive
    }
    
    func setContentText(floor: Floor, contentText: String?){
        var text : String
        if contentText != nil {
            text = contentText!
        }else {
            text = ""
        }
        
        switch floor {
        case .From:
            self.labelFrom.text = text
        case .To:
            self.labelTo.text = text
        case .To2:
            self.labelTo2.text = text
        case .To3:
            self.labelTo3.text = text
        
        }
        
    }
    
    func updateDataForFloor(titleText: String, contentTextFrom: String, contentTextTo: String, contentTextTo2: String, contentTextTo3: String, textAlignment: NSTextAlignment, tagView: Int, isActive: Bool, delegate: FromTo3ViewCellDelegate, isForce: Bool){
        self.setActive(isActive: isActive)
        self.labelTitle.text = titleText
        self.labelFrom.text = contentTextFrom
        self.labelTo.text = contentTextTo
        self.labelTo2.text = contentTextTo2
        self.labelTo3.text = contentTextTo3
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
        
        if(isActive && isForce && contentTextTo2 == ""){
            self.viewTo2.backgroundColor =  AT_FILL_IN_TEXTFIELD_ADD_NEW_schedule
            self.viewTo2.layer.borderColor = UIColor.blue.cgColor
        }else {
            self.viewTo2.backgroundColor = AT_COLOR_WHITE
            self.viewTo2.layer.borderColor = AT_COLOR_BORDER.cgColor
        }
        
        if(isActive && isForce && contentTextTo3 == ""){
            self.viewTo3.backgroundColor =  AT_FILL_IN_TEXTFIELD_ADD_NEW_schedule
            self.viewTo3.layer.borderColor = UIColor.green.cgColor
        }else {
            self.viewTo3.backgroundColor = AT_COLOR_WHITE
            self.viewTo3.layer.borderColor = AT_COLOR_BORDER.cgColor
        }
        
        self.labelFrom.textAlignment = textAlignment
        self.labelTo.textAlignment = textAlignment
        self.labelTo2.textAlignment = textAlignment
        self.labelTo3.textAlignment = textAlignment
    }
    
}
