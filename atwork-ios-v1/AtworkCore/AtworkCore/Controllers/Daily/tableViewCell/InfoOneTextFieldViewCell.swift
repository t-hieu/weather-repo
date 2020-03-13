//
//  InfoOneTextFieldViewCell.swift
//  AtworkCore
//
//  Created by CuongNV on 10/9/18.
//  Copyright © 2018 Atwork. All rights reserved.
//

import UIKit

class InfoOneTextFieldViewCell: UITableViewCell {
    @IBOutlet weak var titleView: UIView!
//    @IBOutlet weak var addLable: UILabel!
    @IBOutlet weak var titlelabel: LWBlackNormalRegularLabel!
    @IBOutlet weak var textFieldContent: LWBlackNormalRegularTextField!
    
    @IBOutlet weak var viewContent: UIView!
    
    @IBOutlet weak var view: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.titleView.backgroundColor = AT_COLOR_TITLE_INPUT_PERFORMACE
        self.titleView.layer.borderColor = AT_COLOR_BORDER.cgColor
        self.titleView.layer.borderWidth = 1
        self.viewContent.layer.borderColor = AT_COLOR_BORDER.cgColor
        self.viewContent.layer.borderWidth = 1
        self.selectionStyle = UITableViewCellSelectionStyle.none;
//        self.addLable.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setActive(isActive: Bool){
        self.textFieldContent.isUserInteractionEnabled = isActive
        
    }
    
    func updateData(titleText: String, contentText: String, tagView: Int, isActive: Bool, delegate: UITextFieldDelegate, isForce: Bool){
        setActive(isActive: isActive)
        self.titlelabel.text = titleText
        self.textFieldContent.delegate = delegate
        self.textFieldContent.tag = tagView
        self.textFieldContent.text = contentText
        self.textFieldContent.backgroundColor = UIColor.clear
        if(isActive && isForce && contentText == ""){
            self.viewContent.backgroundColor =  AT_FILL_IN_TEXTFIELD_ADD_NEW_schedule
            self.viewContent.layer.borderColor = UIColor.orange.cgColor
        }else {
            self.viewContent.backgroundColor = AT_COLOR_WHITE
            self.viewContent.layer.borderColor = AT_COLOR_BORDER.cgColor
        }
    }
}
