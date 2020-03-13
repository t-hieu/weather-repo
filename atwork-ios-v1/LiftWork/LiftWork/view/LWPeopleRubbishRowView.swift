//
//  LWPeopleRubbishRowView.swift
//  LiftWork
//
//  Created by CuongNV on 6/1/18.
//  Copyright © 2018 Trente. All rights reserved.
//

import UIKit

protocol LWPeopleRubbishRowDelegate {
    func updateStatePeopleRubbish(state: String)
}

class LWPeopleRubbishRowView: UIView {

    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var switchAble: UISwitch!
    
    @IBOutlet weak var peopleLabel: UILabel!
    @IBOutlet weak var peopleChoice: UIButton!
    
    @IBOutlet weak var rubbishLabel: UILabel!
    
    @IBOutlet weak var rubbishChoice: UIButton!
    
    @IBAction func switchTap(_ sender: Any) {
        if(self.switchAble.isOn){
            self.delegate?.updateStatePeopleRubbish(state: LW_PEOPLE_RUBBISH_STATE_HUMAN)
            self.setContentAlpha(alpha: 1)
            self.peopleChoice.setImage(UIImage(named: "ic_radio_on"), for: .normal)
            self.rubbishChoice.setImage(UIImage(named: "ic_radio_off"), for: .normal)
        }else {
            self.delegate?.updateStatePeopleRubbish(state: LW_PEOPLE_RUBBISH_STATE_GOOD)
            whenOffSwitch()
        }
    }
    
    @IBAction func peopleTap(_ sender: Any) {
        if(self.switchAble.isOn){
            whenTapPeople()
            self.delegate?.updateStatePeopleRubbish(state: LW_PEOPLE_RUBBISH_STATE_HUMAN)
        }
    }
    
    @IBAction func rubbishTap(_ sender: Any) {
        if(self.switchAble.isOn){
            whenTapRubbish()
            self.delegate?.updateStatePeopleRubbish(state: LW_PEOPLE_RUBBISH_STATE_RUBBISH)
        }
    }
    func whenOffSwitch(){
        self.setContentAlpha(alpha: 0.5)
        self.peopleChoice.setImage(UIImage(named: "ic_radio_off"), for: .normal)
        self.rubbishChoice.setImage(UIImage(named: "ic_radio_off"), for: .normal)
    }
    
    func whenTapPeople(){
        
        self.peopleChoice.setImage(UIImage(named: "ic_radio_on"), for: .normal)
        self.rubbishChoice.setImage(UIImage(named: "ic_radio_off"), for: .normal)
    }
    
    func whenTapRubbish(){
        
        self.peopleChoice.setImage(UIImage(named: "ic_radio_off"), for: .normal)
        self.rubbishChoice.setImage(UIImage(named: "ic_radio_on"), for: .normal)
    }
    
    func setContentAlpha(alpha: CGFloat){
        self.peopleLabel.alpha = alpha
        self.peopleChoice.alpha = alpha
        self.rubbishLabel.alpha = alpha
        self.rubbishChoice.alpha = alpha
    }
    
    var delegate: LWPeopleRubbishRowDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSubview()
    }
    
    func initSubview() {
        
        Bundle.main.loadNibNamed("LWPeopleRubbishRow", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        
        titleLabel.backgroundColor = LW_COLOR_TITLE_INPUT_PERFORMACE
        titleLabel.layer.borderWidth = 1
        titleLabel.layer.borderColor = LW_COLOR_BORDER.cgColor
        titleLabel.text = NSLocalizedString("lw_character_people_rubbish", comment: "")
        titleLabel.font = UIFont.systemFont(ofSize: LW_FONT_SIZE_NORMAL)
        
        peopleLabel.backgroundColor = LW_COLOR_TITLE_INPUT_PERFORMACE
        peopleLabel.layer.borderWidth = 1
        peopleLabel.layer.borderColor = LW_COLOR_BORDER.cgColor
        peopleLabel.text = NSLocalizedString("lw_character_people", comment: "")
        peopleLabel.font = UIFont.systemFont(ofSize: LW_FONT_SIZE_NORMAL)
        
        rubbishLabel.backgroundColor = LW_COLOR_TITLE_INPUT_PERFORMACE
        rubbishLabel.layer.borderWidth = 1
        rubbishLabel.layer.borderColor = LW_COLOR_BORDER.cgColor
        rubbishLabel.text = NSLocalizedString("lw_character_rubbish", comment: "")
        rubbishLabel.font = UIFont.systemFont(ofSize: LW_FONT_SIZE_NORMAL)
        
        self.layer.borderWidth = 1
        self.layer.borderColor = LW_COLOR_BORDER.cgColor
        self.switchAble.onTintColor = LW_BUTTON_COLOR
        self.switchAble.isOn = false
        self.peopleChoice.setImage(UIImage(named: "ic_radio_off"), for: .normal)
        self.rubbishChoice.setImage(UIImage(named: "ic_radio_off"), for: .normal)
        self.setContentAlpha(alpha: 0.5)
    }
    
    func setTitleBackgoundColor(color: UIColor){
        self.titleLabel.backgroundColor = color
        self.peopleLabel.backgroundColor = color
        self.rubbishLabel.backgroundColor = color
    }
    
    func setActive(isActive: Bool){
        self.switchAble.isUserInteractionEnabled = isActive
        self.peopleChoice.isUserInteractionEnabled = isActive
        self.rubbishChoice.isUserInteractionEnabled = isActive
    }
    
}
