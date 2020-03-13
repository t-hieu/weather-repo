//
//  PrInfoTopViewerCell.swift
//  AtworkCore
//
//  Created by CuongNV on 11/19/18.
//  Copyright © 2018 Atwork. All rights reserved.
//

import UIKit

class PrInfoTopViewerCell: UITableViewCell {

    @IBOutlet weak var constructionName: LWBlackNormalRegularLabel!
    @IBOutlet weak var companyName: LWBlackNormalRegularLabel!
    @IBOutlet weak var persionName: LWBlueNormalLabel!
    @IBOutlet weak var persionNameText: LWBlackNormalRegularLabel!
    
    @IBOutlet weak var underLine: UIView!
    @IBOutlet weak var switchChose: UISwitch!
    
    @IBOutlet weak var btShowDetailCreater: UIButton!
    var switchOn: Bool!
    var delegate: InfoTopViewCellDelegate!
    //    @IBOutlet weak var viewContent: UIView!
    @IBAction func tapSwitch(_ sender: UISwitch) {
        self.switchChose.setOn(self.switchOn, animated: false)
        delegate.tapSwitch(state: self.switchOn)
    }
    
    @IBAction func tapDetailCreater(_ sender: UIButton) {
        delegate.tapTopViewCreaterInfo()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.contentView.backgroundColor = AT_COLOR_TITLE_INPUT_PERFORMACE
        
        self.selectionStyle = UITableViewCellSelectionStyle.none;
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setSwichOn(isOn: Bool){
        self.switchOn = isOn
        self.switchChose.setOn(isOn, animated: false)
    }
    
    func setActive(isActive: Bool){
        switchChose.isUserInteractionEnabled = isActive
        
    }
}
