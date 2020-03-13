//
//  LWLiftMaterialRowView.swift
//  LiftWork
//
//  Created by CuongNV on 6/1/18.
//  Copyright © 2018 Trente. All rights reserved.
//

import UIKit

protocol LWLiftMaterialRowviewDelegate {
    func updateStateFree(state: String)
    func tapLiftMaterialCellDelegate()
}

class LWLiftMaterialRowView: UIView {
    
    var stateFree: String?

    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var arrowImage: UIImageView!
    @IBOutlet weak var unitTitle: UILabel!
    
    @IBOutlet weak var unitNumber: UITextField!
    
    @IBOutlet weak var btContent: UIButton!
    
    @IBAction func tapContent2(_ sender: Any) {
        delegate?.tapLiftMaterialCellDelegate()
    }
    
    var delegate: LWLiftMaterialRowviewDelegate?
    var isAbleTap: Bool?
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSubview()
    }
    @IBOutlet weak var nonFreeTitle: UILabel!
    
    @IBOutlet weak var nonFreeTap: UIButton!
    @IBAction func nonFreeAction(_ sender: Any) {
        self.setNonFree()
        self.delegate?.updateStateFree(state: "1")
    }
    
    @IBOutlet weak var freeTitle: UILabel!
    
    @IBOutlet weak var freeTap: UIButton!
    @IBAction func freeAction(_ sender: Any) {
        self.setFree()
        self.delegate?.updateStateFree(state: "0")
    }
    
    
    func initSubview() {
        Bundle.main.loadNibNamed("LWLiftMaterialRow", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        
        titleLabel.text = NSLocalizedString("lw_character_lifting_material", comment: "")
        titleLabel.backgroundColor = LW_COLOR_TITLE_INPUT_PERFORMACE
        titleLabel.layer.borderWidth = 1
        titleLabel.layer.borderColor = LW_COLOR_BORDER.cgColor
        titleLabel.font = UIFont.systemFont(ofSize: LW_FONT_SIZE_NORMAL)
        //        contentTextView.layer.borderWidth = 0.5
        
        unitTitle.backgroundColor = LW_COLOR_TITLE_INPUT_PERFORMACE
        unitTitle.layer.borderWidth = 1
        unitTitle.layer.borderColor = LW_COLOR_BORDER.cgColor
        unitTitle.font = UIFont.systemFont(ofSize: LW_FONT_SIZE_NORMAL)
        unitTitle.text = NSLocalizedString("lw_character_unit", comment: "")
        
        unitNumber.layer.borderWidth = 1
        unitNumber.layer.borderColor = LW_COLOR_BORDER.cgColor
        unitNumber.font = UIFont.systemFont(ofSize: LW_FONT_SIZE_NORMAL)
        
        freeTitle.backgroundColor = LW_COLOR_TITLE_INPUT_PERFORMACE
        freeTitle.layer.borderWidth = 1
        freeTitle.layer.borderColor = LW_COLOR_BORDER.cgColor
        freeTitle.font = UIFont.systemFont(ofSize: LW_FONT_SIZE_NORMAL)
        freeTitle.text = NSLocalizedString("lw_free_title", comment: "")
        
        nonFreeTitle.backgroundColor = LW_COLOR_TITLE_INPUT_PERFORMACE
        nonFreeTitle.layer.borderWidth = 1
        nonFreeTitle.layer.borderColor = LW_COLOR_BORDER.cgColor
        nonFreeTitle.font = UIFont.systemFont(ofSize: LW_FONT_SIZE_NORMAL)
        nonFreeTitle.text = NSLocalizedString("lw_non_free_title", comment: "")
        
        freeTap.layer.borderWidth = 1
        freeTap.layer.borderColor = LW_COLOR_BORDER.cgColor
        
        btContent.layer.borderWidth = 1
        btContent.layer.borderColor = LW_COLOR_BORDER.cgColor
        
        nonFreeTap.layer.borderWidth = 1
        nonFreeTap.layer.borderColor = LW_COLOR_BORDER.cgColor
        
        contentLabel.font = UIFont.systemFont(ofSize: LW_FONT_SIZE_NORMAL)
        self.layer.borderWidth = 1
        self.layer.borderColor = LW_COLOR_BORDER.cgColor
//        setDefaultFree()
    }
    
    func setTitleBackgoundColor(color: UIColor){
        self.titleLabel.backgroundColor = color
        self.unitTitle.backgroundColor = color
        self.freeTitle.backgroundColor = color
        self.nonFreeTitle.backgroundColor = color
        
    }
    
    func setAlpha(alphaView: CGFloat){
        if(self.isAbleTap)!{
            self.alpha = alphaView
        }
    }
    
    func setFree(){
        self.stateFree = "0"
        self.freeTap.setImage(UIImage(named: "ic_radio_on"), for: .normal)
        self.nonFreeTap.setImage(UIImage(named: "ic_radio_off"), for: .normal)
    }
    
    func setNonFree(){
        self.stateFree = "1"
        self.nonFreeTap.setImage(UIImage(named: "ic_radio_on"), for: .normal)
        self.freeTap.setImage(UIImage(named: "ic_radio_off"), for: .normal)
    }
    
    func setDefaultFree(){
        self.stateFree = "-1"
        self.freeTap.setImage(UIImage(named: "ic_radio_off"), for: .normal)
        self.nonFreeTap.setImage(UIImage(named: "ic_radio_off"), for: .normal)
    }
    
    func getStateFree() -> String {
        return self.stateFree!
    }
    
    func updateFreeState (status: String){
        switch status {
        case "-1":
            self.setDefaultFree()
            break
        case "0":
            self.setFree()
            break
        case "1":
            self.setNonFree()
            break
        default:
            break
        }
    }
    
    func setAbleTap(isAble: Bool){
        self.unitNumber.isUserInteractionEnabled = isAble
        self.freeTap.isUserInteractionEnabled = isAble
        self.nonFreeTap.isUserInteractionEnabled = isAble
    }
}
