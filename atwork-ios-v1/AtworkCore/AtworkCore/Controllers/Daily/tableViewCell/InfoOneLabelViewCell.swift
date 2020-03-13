//
//  InfoOneLabelViewCell.swift
//  AtworkCore
//
//  Created by CuongNV on 10/5/18.
//  Copyright © 2018 Atwork. All rights reserved.
//

import UIKit

protocol InfoOneLabelViewCellDelegate {
    func tapContentForInfoOneLabel(tagView: Int)
}
class InfoOneLabelViewCell: UITableViewCell {
    
    @IBOutlet weak var addLable: UILabel!
    @IBOutlet weak var titleLabel: LWBlackNormalRegularLabel!
    
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var contentLabel: LWBlackNormalRegularLabel!
    @IBOutlet weak var viewTitle: UIView!
    
    @IBOutlet weak var buttonTapContent: UIButton!
    @IBAction func tapContent(_ sender: UIButton) {
        if (delegate != nil) {
            delegate.tapContentForInfoOneLabel(tagView: self.tagView)
        }
    }
    
   
    var delegate: InfoOneLabelViewCellDelegate!
    var tagView: Int!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.viewContent.layer.borderColor = AT_COLOR_BORDER.cgColor
        self.viewContent.layer.borderWidth = 1
        
        viewTitle.backgroundColor = AT_COLOR_TITLE_INPUT_PERFORMACE
        viewTitle.layer.borderWidth = 1
        viewTitle.layer.borderColor = AT_COLOR_BORDER.cgColor
        
        self.selectionStyle = UITableViewCellSelectionStyle.none;
        self.addLable.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setActive(isActive: Bool){
        buttonTapContent.isUserInteractionEnabled = isActive
        
    }
    
    
    func setContentText(content: String?){
        if content != nil {
            self.contentLabel.text = content
        }else{
            self.contentLabel.text = ""
        }
    }
    
    func updateData(titleText: String, contentText: String, tagView: Int, isActive: Bool, delegate: InfoOneLabelViewCellDelegate, isShowAddLabel: Bool, isForce: Bool){
        setActive(isActive: isActive)
        titleLabel.text = titleText
        self.delegate = delegate
        self.tagView = tagView
        self.contentLabel.text = contentText
        if(isActive && isForce && contentText == ""){
            self.viewContent.backgroundColor =  AT_FILL_IN_TEXTFIELD_ADD_NEW_schedule
            self.viewContent.layer.borderColor = UIColor.orange.cgColor
        }else {
            self.viewContent.backgroundColor = AT_COLOR_WHITE
            self.viewContent.layer.borderColor = AT_COLOR_BORDER.cgColor
        }
        self.addLable.isHidden = !isShowAddLabel
    }
    
    
}
