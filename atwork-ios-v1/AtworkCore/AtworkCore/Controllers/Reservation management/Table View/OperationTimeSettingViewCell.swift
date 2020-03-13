//
//  OperationTimeSettingViewCell.swift
//  AtworkCore
//
//  Created by Trần Tiến Anh on 11/16/18.
//  Copyright © 2018 Atwork. All rights reserved.
//

import UIKit

protocol OperationTimeSettingViewCellDelegate  {
    func tapContentFromTo(isFrom: Bool, tag: Int)
}
class OperationTimeSettingViewCell: UITableViewCell {

    @IBOutlet weak var labelFrom: LWBlackNormalRegularLabel!
    
    @IBOutlet weak var labelTo: LWBlackNormalRegularLabel!
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
    var delegate:OperationTimeSettingViewCellDelegate?
    var tagView: Int!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = UITableViewCellSelectionStyle.none;    }

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
    
    
}
