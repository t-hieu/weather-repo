//
//  LWCarryInType.swift
//  LiftWork
//
//  Created by Trần Tiến Anh on 10/23/18.
//  Copyright © 2018 Trente. All rights reserved.
//

import UIKit

class LWCarryInTypeView: UIView {
  
//    var CarryInTypeIsEnable:[Bool]=[true,false,false,false]
    var SwapIsActive : Bool!
    var TypeAIsActive : Bool!
    var TypeBIsActive : Bool!
    var numChoice: Int!

    
    @IBOutlet var ContentView: UIView!
    
    @IBOutlet weak var CarryInNomalLable: UILabel!
    @IBOutlet weak var CarryInNomalChoice: UIButton!

    
    @IBOutlet weak var CarryInSwapLable: UILabel!
    
    @IBOutlet weak var CarryInSwapChoice: UIButton!
    
    
    
    @IBOutlet weak var CarryInALable: UILabel!
    @IBOutlet weak var CarryInAChoice: UIButton!
    
    @IBOutlet weak var CarryInBLable: UILabel!
    @IBOutlet weak var CarryInBChoice: UIButton!

    
    
    @IBAction func tapChoice(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            CarryInNomalChoice.setImage(UIImage(named: "ic_radio_on"), for:.normal )
            self.numChoice = sender.tag
            CarryInSwapChoice.setImage(UIImage(named: "ic_radio_off"), for:.normal )
            CarryInAChoice.setImage(UIImage(named: "ic_radio_off"), for:.normal )
            CarryInBChoice.setImage(UIImage(named: "ic_radio_off"), for:.normal )
            break
        case 1:
            if self.SwapIsActive {
                CarryInSwapChoice.setImage(UIImage(named: "ic_radio_on"), for:.normal )
                self.numChoice = sender.tag
                CarryInNomalChoice.setImage(UIImage(named: "ic_radio_off"), for:.normal )
                CarryInAChoice.setImage(UIImage(named: "ic_radio_off"), for:.normal )
                CarryInBChoice.setImage(UIImage(named: "ic_radio_off"), for:.normal )
            }
            break
        case 2:
            if self.TypeAIsActive {
                CarryInAChoice.setImage(UIImage(named: "ic_radio_on"), for:.normal )
                self.numChoice = sender.tag
                CarryInNomalChoice.setImage(UIImage(named: "ic_radio_off"), for:.normal )
                CarryInSwapChoice.setImage(UIImage(named: "ic_radio_off"), for:.normal )
                CarryInBChoice.setImage(UIImage(named: "ic_radio_off"), for:.normal )
            }
            break
        case 3:
            if self.TypeBIsActive {
                CarryInBChoice.setImage(UIImage(named: "ic_radio_on"), for:.normal )
                self.numChoice = sender.tag
                CarryInNomalChoice.setImage(UIImage(named: "ic_radio_off"), for:.normal )
                CarryInSwapChoice.setImage(UIImage(named: "ic_radio_off"), for:.normal )
                CarryInAChoice.setImage(UIImage(named: "ic_radio_off"), for:.normal )
            }
            break
        default:
            break
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSubview()
    }
    
    
    
    func initSubview() {
        
        Bundle.main.loadNibNamed("LWCarryInType", owner: self, options: nil)
        addSubview(ContentView)
        ContentView.frame = bounds
        self.layer.borderWidth = 1
        self.layer.borderColor = LW_COLOR_BORDER.cgColor
    }
    
    func updateActiveChoice(SwapIsActive: Bool,TypeAIsActive: Bool,TypeBIsActive: Bool){
        self.SwapIsActive = SwapIsActive
        self.TypeAIsActive = TypeAIsActive
        self.TypeBIsActive = TypeBIsActive
        
        if TypeAIsActive {
            self.CarryInALable.alpha = 1
        }else {
            self.CarryInALable.alpha = 0.3
        }
        if SwapIsActive {
            CarryInSwapLable.alpha = 1
        }else {
            CarryInSwapLable.alpha = 0.3
        }
        if TypeBIsActive {
            CarryInBLable.alpha = 1
        }else {
            CarryInBLable.alpha = 0.3
        }
    }
    
    func getLabelChoice() -> String {
        switch self.numChoice {
        case 1:
            return "盛替"
        case 2:
            return "搬入A"
        case 3:
            return "搬入B"
        default:
            return ""
        }
    }
    
    func updateChoice(labelText: String) {
//        self.numChoice = numChoice
        switch labelText {
        case "盛替":
            self.numChoice = 1
            CarryInSwapChoice.setImage(UIImage(named: "ic_radio_on"), for:.normal )
            CarryInNomalChoice.setImage(UIImage(named: "ic_radio_off"), for:.normal )
            CarryInAChoice.setImage(UIImage(named: "ic_radio_off"), for:.normal )
            CarryInBChoice.setImage(UIImage(named: "ic_radio_off"), for:.normal )
            break
        case "搬入A":
            self.numChoice = 2
            CarryInAChoice.setImage(UIImage(named: "ic_radio_on"), for:.normal )
            CarryInNomalChoice.setImage(UIImage(named: "ic_radio_off"), for:.normal )
            CarryInSwapChoice.setImage(UIImage(named: "ic_radio_off"), for:.normal )
            CarryInBChoice.setImage(UIImage(named: "ic_radio_off"), for:.normal )
            break
        case "搬入B":
            self.numChoice = 3
            CarryInBChoice.setImage(UIImage(named: "ic_radio_on"), for:.normal )
            CarryInNomalChoice.setImage(UIImage(named: "ic_radio_off"), for:.normal )
            CarryInSwapChoice.setImage(UIImage(named: "ic_radio_off"), for:.normal )
            CarryInAChoice.setImage(UIImage(named: "ic_radio_off"), for:.normal )
            break
        default:
            self.numChoice = 0
            CarryInNomalChoice.setImage(UIImage(named: "ic_radio_on"), for:.normal )
            CarryInSwapChoice.setImage(UIImage(named: "ic_radio_off"), for:.normal )
            CarryInAChoice.setImage(UIImage(named: "ic_radio_off"), for:.normal )
            CarryInBChoice.setImage(UIImage(named: "ic_radio_off"), for:.normal )
            break
        }
    }
}

