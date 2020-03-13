//
//  CategoryViewCell.swift
//  AtworkCore
//
//  Created by CuongNV on 10/8/18.
//  Copyright © 2018 Atwork. All rights reserved.
//

import UIKit
protocol CateGoryCellDelegate {
    func doneChoseCategoryCel(indexChose: Int)
}
class CategoryViewCell: UITableViewCell {
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var check1: UIImageView!
    @IBOutlet weak var check2: UIImageView!
    @IBOutlet weak var check3: UIImageView!
    @IBOutlet weak var check4: UIImageView!
    var checkItem: Int! = -1
    var delegate: CateGoryCellDelegate!
    var isActive: Bool!
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var viewLine1: UIView!
    
    @IBOutlet weak var viewLine2: UIView!
    @IBOutlet weak var viewLine3: UIView!
    @IBAction func tapCheck(_ sender: UIButton) {
        if !isActive {return}
        checkItem = sender.tag
        delegate.doneChoseCategoryCel(indexChose: sender.tag + 1)
        updateRadioState()
        
    }
    func updateRadioState(){
        check1.image = getMyImage(imageName: "ic_radio_off")
        check2.image = getMyImage(imageName: "ic_radio_off")
        check3.image = getMyImage(imageName: "ic_radio_off")
        check4.image = getMyImage(imageName: "ic_radio_off")
    
    
        switch self.checkItem {
        case 0:
        check1.image = getMyImage(imageName: "ic_radio_on")
        break
        case 1:
        check2.image = getMyImage(imageName: "ic_radio_on")
        break
        case 2:
        check3.image = getMyImage(imageName: "ic_radio_on")
        break
        case 3:
        check4.image = getMyImage(imageName: "ic_radio_on")
        break
        default:
        break
        }
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
        // Initialization code
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
    
    func setCheckItem(indexCheck: Int!){
        if indexCheck == nil {
            self.checkItem = -1
        }else {
            self.checkItem = indexCheck - 1
        }
        self.updateRadioState()
    }
    
    func updateData(checkItem: Int, isActive: Bool, delegate: CateGoryCellDelegate){
        self.setActive(isActive: isActive)
        self.setCheckItem(indexCheck: checkItem)
        if(isActive && self.checkItem == -1) {
            self.viewContent.backgroundColor = AT_FILL_IN_TEXTFIELD_ADD_NEW_schedule
            self.viewContent.layer.borderColor = UIColor.orange.cgColor
            self.viewLine1.backgroundColor = UIColor.orange
            self.viewLine2.backgroundColor = UIColor.orange
            self.viewLine3.backgroundColor = UIColor.orange
        }
        else {
            self.viewContent.backgroundColor = AT_COLOR_WHITE
            self.viewContent.layer.borderColor = AT_COLOR_BORDER.cgColor
            self.viewLine1.backgroundColor = AT_COLOR_BORDER
            self.viewLine2.backgroundColor = AT_COLOR_BORDER
            self.viewLine3.backgroundColor = AT_COLOR_BORDER
        }
        self.delegate = delegate
        
    }
    
   
}
