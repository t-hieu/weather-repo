//
//  ForkliftViewCell.swift
//  AtworkCore
//
//  Created by CuongNV on 10/8/18.
//  Copyright © 2018 Atwork. All rights reserved.
//

import UIKit

protocol ForkliftCellDelegate {
    func changeStageForklift(state: Int)
}
class ForkliftViewCell: UITableViewCell {
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var viewContent: UIView!
    
    @IBOutlet weak var viewLine: UIView!
    @IBOutlet weak var check0: UIImageView!
    @IBOutlet weak var check1: UIImageView!
    
    @IBAction func tapRadio(_ sender: UIButton) {
        //Hieu
        //isActive = true
        if !isActive {return}
        checkItem = sender.tag
//        if checkItem == 0 {
//            delegate.changeStageForklift(state: 0)
//        }else {
        delegate.changeStageForklift(state: self.checkItem)
//        }
        updateRadioState()
    }
    
    var checkItem: Int! = -1
    var delegate: ForkliftCellDelegate!
    var isActive: Bool!
    
    func updateRadioState(){
        check0.image = getMyImage(imageName: "ic_radio_off")
        check1.image = getMyImage(imageName: "ic_radio_off")
        
        
        switch self.checkItem {
        case 1:
            check0.image = getMyImage(imageName: "ic_radio_on")
            
            break
        case 0:
            check1.image = getMyImage(imageName: "ic_radio_on")
            
            break
        default:
            break
        }
    }
    
    func updateState(state: Int){
//        if(state == nil){ self.checkItem = -1 }
//        else if state {
//            self.checkItem = 0
//        }else {
        self.checkItem = state
//        }
        self.updateRadioState()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleView.backgroundColor = AT_COLOR_TITLE_INPUT_PERFORMACE
        self.titleView.layer.borderWidth = 1
        self.titleView.layer.borderColor = AT_COLOR_BORDER.cgColor
        
        self.viewContent.layer.borderWidth = 1
        self.viewContent.layer.borderColor = AT_COLOR_BORDER.cgColor
        updateRadioState()
        self.selectionStyle = UITableViewCellSelectionStyle.none;
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func getMyImage(imageName: String) -> UIImage? {
        let bundle = Bundle(for: type(of: self))
        return UIImage(named: imageName, in: bundle, compatibleWith: nil)
    }
    func setActive(isActive: Bool){
        self.isActive = isActive
        
    }
    
    func updateData(state: Int, isActive: Bool, delegate: ForkliftCellDelegate, isForce: Bool){
        self.setActive(isActive: isActive)
        self.updateState(state: state)
        if(isActive && isForce && self.checkItem == -1) {
            self.viewContent.backgroundColor = AT_FILL_IN_TEXTFIELD_ADD_NEW_schedule
            self.viewContent.layer.borderColor = UIColor.orange.cgColor
            self.viewLine.backgroundColor = UIColor.orange
        }
        else {
            self.viewContent.backgroundColor = AT_COLOR_WHITE
            self.viewContent.layer.borderColor = AT_COLOR_BORDER.cgColor
            self.viewLine.backgroundColor = AT_COLOR_BORDER
        }
        self.delegate = delegate
        
    }
}
