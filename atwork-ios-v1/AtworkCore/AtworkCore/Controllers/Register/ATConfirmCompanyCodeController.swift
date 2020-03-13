//
//  ATConfirmCompanyCodeController.swift
//  AtworkCore
//
//  Created by CuongNV on 11/6/18.
//  Copyright © 2018 Atwork. All rights reserved.
//

import UIKit

class ATConfirmCompanyCodeController: UIViewController {

    @IBOutlet weak var companyName: UILabel!
    
    @IBAction func tapYes(_ sender: Any) {
        let vc = ATInputAccountController.init(nibName: ATInputAccountController.className, bundle: Bundle.init(for: ATInputAccountController.self))
        vc.account = self.account
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func tapNo(_ sender: Any) {
        //        self.navigationController?.popToRootViewController(animated: true)
        self.navigationController?.popViewController(animated: true)
    }
    
    var account: ATAccountModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.barTintColor = UIColor.orange
        self.navigationController?.navigationBar.isTranslucent = false 
        
        
        let leftBarButton = UIBarButtonItem(title: "＜戻る", style: .plain, target: self, action: #selector(self.tapLeftBarButton))
        leftBarButton.titleTextAttributes(for: .normal)
        leftBarButton.setTitleTextAttributes([NSAttributedStringKey.font: UIFont.boldFont(size: AT_FONT_SIZE_NORMAL)], for: .normal)
        leftBarButton.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItem = leftBarButton
        
        self.navigationItem.title = "所属会社確認"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        
    }
    
    
    @objc func tapLeftBarButton(){
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
         self.companyName.text = self.account.companyName    
    }
    
}
