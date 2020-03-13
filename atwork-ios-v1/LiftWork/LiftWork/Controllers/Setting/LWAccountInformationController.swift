//
//  LWAccountInformationController.swift
//  LiftWork
//
//  Created by CuongNV on 6/7/18.
//  Copyright © 2018 Trente. All rights reserved.
//

import UIKit
import TrenteCoreSwift
import ObjectMapper


class LWAccountInformationController: LWBaseViewController, LWViewOneLabelDelegate {
    
    @IBOutlet weak var titleRow: LWViewOneLabel!
    @IBOutlet weak var userNameRow: LWViewBase!
    @IBOutlet weak var informationRow: LWViewBase!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.titleRow.labTitle.text = NSLocalizedString("lw_button_back", comment: "")
        self.titleRow.delegate = self
        
        self.userNameRow.isHideArrow(isHide: true)
        self.userNameRow.labTitle.text = NSLocalizedString("lw_user_name", comment: "")
        self.informationRow.isHideArrow(isHide: true)
        self.informationRow.labTitle.text = NSLocalizedString("lw_information", comment: "")
        
        self.view.activityIndicatorView.startAnimating()
        self.loadAccountInformation()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    //delegate
    func tapViewOneLabelInTime(view: LWViewOneLabel) {
        
    }
    
    func tapViewOneLabelInTitle(view: LWViewOneLabel) {
        self.navigationController?.popViewController(animated: true)
    }
   
    func loadAccountInformation(){
        let params = LWParamUtil.initParamsLW()
        AlamofireManager.shared.request(APIRouter.get(url: API.LW_URL_ACCOUNT_DETAIL, params: params, identifier: nil)) { (response) in
            self.view.activityIndicatorView.stopAnimating()
            if response != nil{
                //data
                guard let data = response!["myself"] as? [String:Any],
                    let mySelf:LWUserModel = Mapper<LWUserModel>().map(JSON: data)
                    else{
                        return
                }
                self.userNameRow.labContent.text = mySelf.userName
                if mySelf.systemAdmin != 0{
                    self.informationRow.labContent.text = NSLocalizedString("ADMIN", comment: "")
                }else if mySelf.companyAdmin != 0{
                    self.informationRow.labContent.text = NSLocalizedString("ADMIN", comment: "")
                }else{
                     self.informationRow.labContent.text = NSLocalizedString("MEMBER", comment: "")
                }
                
            }
        }
        
    }

}
