//
//  LWBasicInfomationView.swift
//  LiftWork
//
//  Created by CuongNV on 5/15/18.
//  Copyright © 2018 Trente. All rights reserved.
//

import UIKit
protocol LWBasicInformationViewDelegate {
    func tapConstructionLWBasicInformation()
}
class LWBasicInformationView: UIView {
    @IBOutlet var view: UIView!
    @IBOutlet weak var labBasicInfomation: UILabel!
    @IBOutlet weak var labConstruction: UILabel!
    @IBOutlet weak var labDate: UILabel!
    @IBOutlet weak var labTime: UILabel!
    @IBOutlet weak var arrowImage: UIImageView!
    
    
    @IBAction func tapConstruction(_ sender: Any) {
        self.delegate?.tapConstructionLWBasicInformation()
    }
    
    var delegate: LWBasicInformationViewDelegate?
    var isAbleTap: Bool?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSubview()
    }
    
    func initSubview() {
        
        Bundle.main.loadNibNamed("LWBasicInformationView", owner: self, options: nil)
        addSubview(view)
        view.frame = bounds
//        view.layer.borderWidth = 1
        
        labConstruction.text = ""
       
        view.backgroundColor = LW_COLOR_BLUE
        
        labBasicInfomation.font = UIFont.boldSystemFont(ofSize: LW_FONT_SIZE_BIG)
        labBasicInfomation.text = NSLocalizedString("lw_character_basic_information", comment: "")
        labConstruction.font = UIFont.boldSystemFont(ofSize: LW_FONT_SIZE_BIG)
        labDate.font = UIFont.systemFont(ofSize: LW_FONT_SIZE_NORMAL)
        labTime.font = UIFont.systemFont(ofSize: LW_FONT_SIZE_NORMAL)
        
    }
    
    func setBackgoundColor(color: UIColor){
        self.view.backgroundColor = color
    }
    
    func isHidenDateTime(isHide: Bool) {
        self.labDate.isHidden = isHide
        self.labTime.isHidden = isHide
    }

}
