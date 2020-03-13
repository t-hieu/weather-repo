//
//  LWBaseViewController.swift
//  LiftWork
//
//  Created by TrungND on 5/10/18.
//  Copyright © 2018 Trente. All rights reserved.
//

import UIKit
import TrenteCoreSwift
import ObjectMapper
import SwiftMessages
class LWBaseViewController: UIViewController  {
    
    var window: UIWindow!

    override func viewDidLoad() {
        super.viewDidLoad()

        window = UIApplication.shared.delegate?.window!
        self.navigationController?.navigationBar.barTintColor = LW_LOGIN_BUTTON_COLOR
        self.view.backgroundColor = LW_COLOR_WHITE
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func showAlert(title: String, message: String){
        let callActionHandler = { (action:UIAlertAction!) -> Void in
            self.actionAfterShowAlert()
        }
        let alertController = UIAlertController(title:title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: callActionHandler)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
    func actionAfterShowAlert(){}
    
     func showNackBarWithSuccess(message:String?){
        if let msg = message{
            SwiftMessages.show {
                let view = MessageView.viewFromNib(layout: MessageView.Layout.statusLine)
                view.configureTheme(.success)
                view.configureDropShadow()
                view.configureContent(title: "", body: msg )
                view.tapHandler = { _ in SwiftMessages.hide() }
                return view
            }
        }
    }
}
