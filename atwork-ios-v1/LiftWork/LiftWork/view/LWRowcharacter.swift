//
//  LWRowcharacter.swift
//  LiftWork
//
//  Created by CuongNV on 5/16/18.
//  Copyright © 2018 Trente. All rights reserved.
//

import UIKit

protocol TapLabelDelegate{
    func tapLabel(label: UILabel)
    
}

class LWRowcharacter: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var lab1: UILabel!
    @IBOutlet weak var lab2: UILabel!
    @IBOutlet weak var lab3: UILabel!
    @IBOutlet weak var lab4: UILabel!
    @IBOutlet weak var lab5: UILabel!

    var tapLabelControl: TapLabelDelegate?
  
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSubview()
    }
    
    func initSubview() {
        
        Bundle.main.loadNibNamed("LWRowCharacter", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
//        contentView.layer.borderWidth =
        
        lab1.layer.borderWidth = 1
        lab1.layer.borderColor = LW_COLOR_BORDER.cgColor
        lab2.layer.borderWidth = 1
        lab2.layer.borderColor = LW_COLOR_BORDER.cgColor
        lab3.layer.borderWidth = 1
        lab3.layer.borderColor = LW_COLOR_BORDER.cgColor
        lab4.layer.borderWidth = 1
        lab4.layer.borderColor = LW_COLOR_BORDER.cgColor
        lab5.layer.borderWidth = 1
        lab5.layer.borderColor = LW_COLOR_BORDER.cgColor
    
        lab1.font = UIFont.systemFont(ofSize: LW_FONT_SIZE_NORMAL)
        lab2.font = UIFont.systemFont(ofSize: LW_FONT_SIZE_NORMAL)
        lab3.font = UIFont.systemFont(ofSize: LW_FONT_SIZE_NORMAL)
        lab4.font = UIFont.systemFont(ofSize: LW_FONT_SIZE_NORMAL)
        lab5.font = UIFont.systemFont(ofSize: LW_FONT_SIZE_NORMAL)
       
        
    }
    
    
    
    
    @IBAction func tap1(_ sender: Any) {
        self.tapLabelControl?.tapLabel(label: lab1)
       
    }
    @IBAction func tap2(_ sender: Any) {
        self.tapLabelControl?.tapLabel(label: lab2)
        
    }
    
    @IBAction func tap3(_ sender: Any) {
        self.tapLabelControl?.tapLabel(label: lab3)
    }
    
    @IBAction func tap4(_ sender: Any) {
        self.tapLabelControl?.tapLabel(label: lab4)
    }
    
    @IBAction func tap5(_ sender: Any) {
        self.tapLabelControl?.tapLabel(label: lab5)
    }
    
    
}
