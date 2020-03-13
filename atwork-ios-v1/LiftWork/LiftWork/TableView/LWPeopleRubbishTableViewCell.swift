//
//  LWPeopleRubbishTableViewCell.swift
//  LiftWork
//
//  Created by CuongNV on 5/14/18.
//  Copyright © 2018 Trente. All rights reserved.
//

import UIKit
protocol LWPeopleRubbishCellDelegate {
    func updateStatePeopleRubbish(state: String)
}
class LWPeopleRubbishTableViewCell: UITableViewCell{
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var switchAble: UISwitch!
    
    @IBOutlet weak var pepleLabel: UILabel!
    @IBOutlet weak var peopleChoice: UIButton!
    
    @IBOutlet weak var rubbishLabel: UILabel!
    
    @IBOutlet weak var rubbishChoice: UIButton!
    
    var delegate: LWPeopleRubbishCellDelegate?
    @IBAction func switchTap(_ sender: Any) {
        if(self.switchAble.isOn){
            self.delegate?.updateStatePeopleRubbish(state: LW_PEOPLE_RUBBISH_STATE_HUMAN)
            self.setContentAlpha(alpha: 1)
            self.peopleChoice.setImage(UIImage(named: "ic_radio_on"), for: .normal)
            self.rubbishChoice.setImage(UIImage(named: "ic_radio_off"), for: .normal)
        }else {
            self.delegate?.updateStatePeopleRubbish(state: LW_PEOPLE_RUBBISH_STATE_GOOD)
            self.setContentAlpha(alpha: 0.5)
            self.peopleChoice.setImage(UIImage(named: "ic_radio_off"), for: .normal)
            self.rubbishChoice.setImage(UIImage(named: "ic_radio_off"), for: .normal)
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
    
    func whenTapPeople(){
        
        self.peopleChoice.setImage(UIImage(named: "ic_radio_on"), for: .normal)
        self.rubbishChoice.setImage(UIImage(named: "ic_radio_off"), for: .normal)
    }
    
    func whenTapRubbish(){
        
        self.peopleChoice.setImage(UIImage(named: "ic_radio_off"), for: .normal)
        self.rubbishChoice.setImage(UIImage(named: "ic_radio_on"), for: .normal)
    }
    
    func setContentAlpha(alpha: CGFloat){
        self.pepleLabel.alpha = alpha
        self.peopleChoice.alpha = alpha
        self.rubbishLabel.alpha = alpha
        self.rubbishChoice.alpha = alpha
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.backgroundColor = LW_COLOR_TITLE_INPUT_PERFORMACE
        titleLabel.layer.borderWidth = 1
        titleLabel.text = NSLocalizedString("lw_character_people_rubbish", comment: "")
        titleLabel.font = UIFont.systemFont(ofSize: LW_FONT_SIZE_NORMAL)
        
        pepleLabel.backgroundColor = LW_COLOR_TITLE_INPUT_PERFORMACE
        pepleLabel.layer.borderWidth = 1
        pepleLabel.text = NSLocalizedString("lw_character_people", comment: "")
        pepleLabel.font = UIFont.systemFont(ofSize: LW_FONT_SIZE_NORMAL)
        
        rubbishLabel.backgroundColor = LW_COLOR_TITLE_INPUT_PERFORMACE
        rubbishLabel.layer.borderWidth = 1
        rubbishLabel.text = NSLocalizedString("lw_character_rubbish", comment: "")
        rubbishLabel.font = UIFont.systemFont(ofSize: LW_FONT_SIZE_NORMAL)
        
        self.layer.borderWidth = 1
        
        self.switchAble.onTintColor = LW_BUTTON_COLOR
        self.switchAble.isOn = false
        self.peopleChoice.setImage(UIImage(named: "ic_radio_off"), for: .normal)
        self.rubbishChoice.setImage(UIImage(named: "ic_radio_off"), for: .normal)
        self.setContentAlpha(alpha: 0.5)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
