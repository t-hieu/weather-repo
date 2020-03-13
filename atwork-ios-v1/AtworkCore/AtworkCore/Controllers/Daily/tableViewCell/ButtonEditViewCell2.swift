//
//  ButtonEditViewCell.swift
//  AtworkCore
//
//  Created by CuongNV on 11/13/18.
//  Copyright © 2018 Atwork. All rights reserved.
//

import UIKit

class ButtonEditViewCell2: UITableViewCell {
    @IBOutlet weak var btOne: LWRoundedDarkOrangeButton!
    
    @IBOutlet weak var btTwo: LWRoundedDarkOrangeButton!
    
    @IBOutlet weak var btThree: LWRoundedDarkOrangeButton!
    
    var stateView: Int!
    var isEventMode: Bool!
    var delegate: ButtonViewCellDelegate!
    
    @IBAction func tapButton(_ sender: UIButton) {
        switch self.stateView {
        case AT_SCHEDULE_DETAIL_VIEW:
            if sender.tag == 0 {
                delegate.tapButton(state: AT_SCHEDULE_DETAIL_EDIT)
            }
            break
            
        case AT_SCHEDULE_DETAIL_EDIT:
            if sender.tag == 0 {
                delegate.tapButton(state: AT_SCHEDULE_DETAIL_CONFIRM)
            }else if sender.tag == 1 {
                delegate.tapButton(state: AT_SCHEDULE_DETAIL_DELETE)
            }else if sender.tag == 2 {
                delegate.tapButton(state: AT_SCHEDULE_DETAIL_VIEW)
            }
            break
            
        case AT_SCHEDULE_DETAIL_CONFIRM:
            if sender.tag == 0 {
                delegate.tapButton(state: AT_SCHEDULE_DETAIL_CONFIRM_OK)
            }else if sender.tag == 1 {
                delegate.tapButton(state: AT_SCHEDULE_DETAIL_EDIT)
            }
            break
            
        default:
            break
        }
    }
    
    func updateButtonView(stateView: Int, isActiveConfirmBT: Bool){
        if self.stateView != stateView {
            self.stateView = stateView
            switch stateView {
            case AT_SCHEDULE_DETAIL_VIEW:
                self.btOne.isHidden = false
                self.btOne.customBgColor = UIColor.orange
                self.btOne.customTitleColor = AT_COLOR_WHITE
                self.btOne.setTitle("編集", for: .normal)
                
                self.btTwo.isHidden = true
                self.btThree.isHidden = true
                break
            case AT_SCHEDULE_DETAIL_EDIT:
                self.btOne.isHidden = false
                self.btOne.customBgColor = UIColor.orange
                self.btOne.customTitleColor = AT_COLOR_WHITE
                self.btOne.setTitle("確定", for: .normal)
                
                self.btTwo.isHidden = false
                self.btTwo.customTitleColor = AT_COLOR_BLACK
                self.btTwo.customBgColor = UIColor.red
                self.btTwo.setTitle("削除", for: .normal)
                
                self.btThree.isHidden = false
                self.btThree.customTitleColor = AT_COLOR_BLACK
                self.btThree.customBgColor = AT_COLOR_TITLE_INPUT_PERFORMACE
                self.btThree.setTitle("戻る", for: .normal)
                
                break
            case AT_SCHEDULE_DETAIL_CONFIRM:
                self.btOne.isHidden = false
                self.btOne.customBgColor = AT_COLOR_GREEN
                self.btOne.customTitleColor = AT_COLOR_BLUE
                self.btOne.setTitle("送信", for: .normal)
                
                self.btTwo.isHidden = false
                self.btTwo.customTitleColor = AT_COLOR_BLACK
                self.btTwo.customBgColor = AT_COLOR_TITLE_INPUT_PERFORMACE
                self.btTwo.setTitle("戻る", for: .normal)
                
                self.btThree.isHidden = true
                
                break
            default:
                break
            }
        }
        
        if stateView == AT_SCHEDULE_DETAIL_EDIT && self.btOne.isUserInteractionEnabled != isActiveConfirmBT{
            self.btOne.isUserInteractionEnabled = isActiveConfirmBT
            if isActiveConfirmBT {
                self.btOne.customTitleColor = AT_COLOR_WHITE
                self.btOne.customBgColor = UIColor.orange
            }else {
                self.btOne.customTitleColor = AT_COLOR_BLACK
                self.btOne.customBgColor = AT_COLOR_TITLE_INPUT_PERFORMACE
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        self.stateView = AT_SCHEDULE_DETAIL_VIEW
//        self.updateButtonView()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
