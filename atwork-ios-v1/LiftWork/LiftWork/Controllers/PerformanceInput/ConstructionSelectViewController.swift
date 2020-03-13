//
//  ConstructionSelectViewController.swift
//  LiftWork
//
//  Created by CuongNV on 5/15/18.
//  Copyright © 2018 Trente. All rights reserved.
//

import UIKit
import TrenteCoreSwift
protocol LWConstructionSelectViewControllerDelegate:NSObjectProtocol {
    func selectConstruction(vc:ConstructionSelectViewController,didSelectedConstructionID id:Int?)
}
class ConstructionSelectViewController: LWBaseViewController, LWViewBaseDelegate, LWChoseConstructionViewDelegate,MainStoryboard {
   
    var index:Int = 0
    
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var viewConstruction: LWViewBase!
    @IBOutlet weak var btSelect: LWRoundedBlueDarkButton!
    
    var construction: LWConstructionModel?
    
    var delegate:LWConstructionSelectViewControllerDelegate?
    
    @IBAction func tapBTSelect(_ sender: Any) {
        LWUserDefaults.setConstructionId(val: (self.construction?.key != nil ? "\((self.construction?.key)!)" : ""))
        LWUserDefaults.setConstructionName(val: self.construction?.constructionName ?? "")
        APP_DELEGATE?.initRootViewController(index: self.index)
        self.navigationController?.popViewController(animated: false)
        
        if (self.delegate != nil){
            self.delegate?.selectConstruction(vc: self, didSelectedConstructionID: self.construction?.key)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewConstruction.labTitle.text = NSLocalizedString("lw_construction_name", comment: "")
        viewConstruction.labTitle.font = UIFont.systemFont(ofSize: LW_FONT_SIZE_NORMAL)
        
//        btSelect.initilization(title: NSLocalizedString("lw_button_select_title", comment: ""), color: LW_COLOR_BLUE, radius: LW_CORNER_RADIUS_BUTTON, textFields: nil)
        btSelect.setTitle(NSLocalizedString("lw_button_select_title", comment: ""), for: .normal)
        btSelect.isEnabled = false
        
        self.viewConstruction.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        if(self.construction == nil){
            self.btSelect.isEnabled = false
            let constructionName = LWUserDefaults.getConstructionName()
            if(constructionName != ""){
                btSelect.isEnabled = true
                self.viewConstruction.labContent.text = LWUserDefaults.getConstructionName()
                self.construction = LWConstructionModel.init()
                self.construction?.constructionName = constructionName
                self.construction?.key = Int(LWUserDefaults.getConstructionId())
            }
        }else {
            btSelect.isEnabled = true
        }
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func actionClickLabContent() {
            let choseConstruction = self.storyboard?.instantiateViewController(withIdentifier: "LWChoseConstructionViewController") as! LWChoseConstructionViewController
            choseConstruction.construction = self.construction
            choseConstruction.delegate = self
            self.navigationController?.pushViewController(choseConstruction, animated: true)
    }
    
    // delegate
    func tapChoseConstructionView(construction: LWConstructionModel) {
        self.construction = construction
        self.viewConstruction.labContent.text = self.construction?.constructionName
        self.btSelect.isEnabled = true
    }

}
