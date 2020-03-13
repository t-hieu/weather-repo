//
//  PackingViewCell.swift
//  AtworkCore
//
//  Created by CuongNV on 10/8/18.
//  Copyright © 2018 Atwork. All rights reserved.
//

import UIKit

protocol PackingCellDelegate {
    func changeStatePacking(state:[Int])
}
class PackingViewCell: UITableViewCell {
    @IBOutlet weak var check0: UIImageView!
    @IBOutlet weak var check1: UIImageView!
    @IBOutlet weak var check2: UIImageView!
    @IBOutlet weak var check3: UIImageView!
    @IBOutlet weak var check4: UIImageView!
    @IBOutlet weak var check5: UIImageView!
    
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var viewTitle: UIView!
    var isActive: Bool!
    
    var delegate: PackingCellDelegate!
    @IBAction func tapCheckBox(_ sender: UIButton) {
        if !isActive {return}
        switch sender.tag {
        case 0:
            if(check0.tag == 0){
                check0.tag = 1
            }else{
              check0.tag = 0
            }
            updateCheckBoxState(imageView: check0, tag: check0.tag)
            
            break
            
        case 1:
            if(check1.tag == 0){
                check1.tag = 1
            }else{
                check1.tag = 0
            }
            updateCheckBoxState(imageView: check1, tag: check1.tag)
            
            break
        case 2:
            if(check2.tag == 0){
                check2.tag = 1
            }else{
                check2.tag = 0
            }
            updateCheckBoxState(imageView: check2, tag: check2.tag)
            
            break
            
        case 3:
            if(check3.tag == 0){
                check3.tag = 1
            }else{
                check3.tag = 0
            }
            updateCheckBoxState(imageView: check3, tag: check3.tag)
            
            break
            
        case 4:
            if(check4.tag == 0){
                check4.tag = 1
            }else{
                check4.tag = 0
            }
            updateCheckBoxState(imageView: check4, tag: check4.tag)
            
            break
            
        case 5:
            if(check5.tag == 0){
                check5.tag = 1
            }else{
                check5.tag = 0
            }
            updateCheckBoxState(imageView: check5, tag: check5.tag)
            
            break
        default:
            break
        }
        self.delegate.changeStatePacking(state: getListCheck())
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewTitle.backgroundColor = AT_COLOR_TITLE_INPUT_PERFORMACE
        self.viewTitle.layer.borderWidth = 1
        self.viewTitle.layer.borderColor = AT_COLOR_BORDER.cgColor
        
        self.viewContent.layer.borderWidth = 1
        self.viewContent.layer.borderColor = AT_COLOR_BORDER.cgColor
//        fillData(state1: 0, state2: 0, state3: 0, state4: 0, state5: 0, state6: 1)
        self.selectionStyle = UITableViewCellSelectionStyle.none;
        
    }
    
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fillData(state1: Int, state2: Int, state3: Int, state4: Int, state5: Int, state6: Int){
        updateCheckBoxState(imageView: self.check0, tag: state1)
        updateCheckBoxState(imageView: self.check1, tag: state2)
        updateCheckBoxState(imageView: self.check2, tag: state3)
        updateCheckBoxState(imageView: self.check3, tag: state4)
        updateCheckBoxState(imageView: self.check4, tag: state5)
        updateCheckBoxState(imageView: self.check5, tag: state6)
    }
    func updateCheckBoxState(){
        updateCheckBoxState(imageView: check0, tag: check0.tag)
        updateCheckBoxState(imageView: check1, tag: check1.tag)
        updateCheckBoxState(imageView: check2, tag: check2.tag)
        updateCheckBoxState(imageView: check3, tag: check3.tag)
        updateCheckBoxState(imageView: check4, tag: check4.tag)
        updateCheckBoxState(imageView: check5, tag: check5.tag)
        
    }
    
    func updateCheckBoxState(imageView: UIImageView, tag: Int){
        imageView.tag = tag
        if tag == 0 {
            imageView.image = getMyImage(imageName: "cs_box_check_off")
        }else {
            imageView.image = getMyImage(imageName: "cs_box_check_on")
        }
    }
    
    func getMyImage(imageName: String) -> UIImage? {
        let bundle = Bundle(for: type(of: self))
        return UIImage(named: imageName, in: bundle, compatibleWith: nil)
    }
    
    func getListCheck() -> [Int] {
        var list = [Int] ()
        if check0.tag == 1 {list.append(1)}
        if check1.tag == 1 {list.append(2)}
        if check2.tag == 1 {list.append(3)}
        if check3.tag == 1 {list.append(4)}
        if check4.tag == 1 {list.append(5)}
        if check5.tag == 1 {list.append(6)}
        return list
    }
    
    func updateStateCheck(list: [Int]) {
        check0.tag = 0
        check1.tag = 0
        check2.tag = 0
        check3.tag = 0
        check4.tag = 0
        check5.tag = 0
        if list.contains(1){check0.tag = 1}
        if list.contains(2){check1.tag = 1}
        if list.contains(3){check2.tag = 1}
        if list.contains(4){check3.tag = 1}
        if list.contains(5){check4.tag = 1}
        if list.contains(6){check5.tag = 1}
        updateCheckBoxState()
    }
    
    func setActive(isActive: Bool){
        self.isActive = isActive
        
    }
    
    func updateData(packings: [Int], isActive: Bool, delegate: PackingCellDelegate, isForce: Bool){
        self.setActive(isActive: isActive)
        self.delegate = delegate
        self.updateStateCheck(list: packings)
        if(isActive && isForce && packings.isEmpty) {
            self.viewContent.backgroundColor = AT_FILL_IN_TEXTFIELD_ADD_NEW_schedule
            self.viewContent.layer.borderColor = UIColor.orange.cgColor
        }
        else {
            self.viewContent.backgroundColor = AT_COLOR_WHITE
            self.viewContent.layer.borderColor = AT_COLOR_BORDER.cgColor
        }
    }
}
