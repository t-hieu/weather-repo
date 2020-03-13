//
//  ATRegisterSuccessController.swift
//  AtworkCore
//
//  Created by CuongNV on 11/6/18.
//  Copyright © 2018 Atwork. All rights reserved.
//

import UIKit

class ATRegisterSuccessController: UIViewController {
    var account: ATAccountModel!
    @IBAction func tapOk(_ sender: Any) {
//        self.navigationController?.popToRootViewController(animated: true)
        let vc = ATSignInViewController.init(nibName: ATSignInViewController.className, bundle: Bundle.init(for: ATSignInViewController.self))
        vc.account = self.account
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.barTintColor = UIColor.orange
        self.navigationController?.navigationBar.isTranslucent = false 
        
        let leftBarButton = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(self.tapLeftBarButton))
//        leftBarButton.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItem = leftBarButton
        
        self.navigationItem.title = "完了"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        
    }
    
    @objc func tapLeftBarButton(){
//        self.navigationController?.popViewController(animated: true)
    }
    
}
