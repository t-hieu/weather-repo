//
//  LWBasicInfomationView.swift
//  LiftWork
//
//  Created by CuongNV on 5/15/18.
//  Copyright © 2018 Trente. All rights reserved.
//

import UIKit
protocol LWBasicInformationViewDelegate {
    func tapConstruction()
}
class LWBasicInformationView: UIView {
    @IBOutlet var view: UIView!
    @IBOutlet weak var labBasicInfomation: UILabel!
    @IBOutlet weak var labConstruction: UILabel!
    @IBOutlet weak var labDate: UILabel!
    @IBOutlet weak var labTime: UILabel!
    
    @IBAction func tapConstruction(_ sender: Any) {
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
        
        Bundle.main.loadNibNamed("LWBasicInfomationView", owner: self, options: nil)
        addSubview(view)
        view.frame = bounds
        view.layer.borderWidth = 1
        
        labConstruction.text = ""
       
        view.backgroundColor = LW_COLOR_BLUE
        
        labBasicInfomation.font = UIFont.boldSystemFont(ofSize: LW_FONT_SIZE_BIG)
        labBasicInfomation.text = NSLocalizedString("lw_character_basic_information", comment: "")
        labConstruction.font = UIFont.boldSystemFont(ofSize: LW_FONT_SIZE_BIG)
        labDate.font = UIFont.systemFont(ofSize: LW_FONT_SIZE_NORMAL)
        labTime.font = UIFont.systemFont(ofSize: LW_FONT_SIZE_NORMAL)
        
    }

}
