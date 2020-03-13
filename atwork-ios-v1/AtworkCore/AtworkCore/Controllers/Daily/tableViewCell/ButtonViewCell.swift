//
//  ButtonViewCell.swift
//  AtworkCore
//
//  Created by CuongNV on 10/8/18.
//  Copyright © 2018 Atwork. All rights reserved.
//

import UIKit

protocol ButtonViewCellDelegate {
    func tapButton(state: Int)
}
class ButtonViewCell: UITableViewCell {

    @IBOutlet weak var confirmButton: LWRoundedGrayBlackButton!
    
    @IBOutlet weak var backButton: LWRoundedGrayBlackButton!
    
    @IBOutlet weak var sendButton: LWRoundedBlueGreenButton!
    
    @IBAction func tapConfirm(_ sender: Any) {
        delegate.tapButton(state: AT_SCHEDULE_NEW_CONFIRM)
    }
    
    @IBAction func tapSend(_ sender: Any) {
        delegate.tapButton(state: AT_SCHEDULE_NEW_CONFIRM_OK)
    }
    
    @IBAction func tapBack(_ sender: Any) {
        delegate.tapButton(state: AT_SCHEDULE_NEW_CREATE)
    }
    
    var stateView: Int! = -1
    
    func updateStateButton(state: Int, isActiveConfirmBT: Bool){
        if stateView != state {
            stateView = state
            switch state {
            case AT_SCHEDULE_NEW_CONFIRM:
                self.confirmButton.isHidden = true
                self.sendButton.isHidden = false
                self.backButton.isHidden = false
                break
            case AT_SCHEDULE_NEW_CONFIRM_OK:
                break
            case AT_SCHEDULE_NEW_CREATE:
                self.confirmButton.isHidden = false
                self.sendButton.isHidden = true
                self.backButton.isHidden = true
                break
            default:
                break
            }
        }
        
        if state == AT_SCHEDULE_NEW_CREATE {
            self.confirmButton.isUserInteractionEnabled = isActiveConfirmBT
            if isActiveConfirmBT {
                self.confirmButton.customTitleColor = AT_COLOR_WHITE
                self.confirmButton.customBgColor = UIColor.orange
            }else {
                self.confirmButton.customTitleColor = AT_COLOR_BLACK
                self.confirmButton.customBgColor = AT_COLOR_TITLE_INPUT_PERFORMACE
            }
        }
    }
    
    var delegate: ButtonViewCellDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.layer.borderWidth = 1
        self.contentView.layer.borderColor = AT_COLOR_BORDER.cgColor
        self.selectionStyle = UITableViewCellSelectionStyle.none;
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateButton(isConfirm: Bool){
        self.confirmButton.isHidden = isConfirm
        self.sendButton.isHidden = !isConfirm
        self.backButton.isHidden = !isConfirm
    }
    
    func updateStateButtonConfirm(isActive: Bool){
        self.confirmButton.isUserInteractionEnabled = isActive
        if !isActive {
            self.confirmButton.customTitleColor = AT_COLOR_WHITE
            self.confirmButton.customBgColor = UIColor.orange
        }else {
            self.confirmButton.customTitleColor = AT_COLOR_BLACK
            self.confirmButton.customBgColor = AT_COLOR_TITLE_INPUT_PERFORMACE
        }
    }
    
}
