//
//  WFBaseViewController.swift
//  TrenteCoreSwift
//
//  Created by HtHoan on 1/24/18.
//  Copyright © 2018 Trente. All rights reserved.
//

import UIKit

open class WFBaseViewController: UIViewController {
    public var baseColor: UIColor!
    public var backgroundColor: UIColor!
    public var titleString: String!
    public var titleNavigationString: String!
    public var imageApp: UIImage!
    override open  func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func setBackButton(){
        let backButton = UIButton()
        let image = UIImage(named: "wf_back_white")
        backButton.setImage(image, for: UIControlState.normal)
        let customBarItem = UIBarButtonItem(image: image, style: UIBarButtonItemStyle.plain, target: self, action: #selector(performBack(sender:)))
        self.navigationItem.leftBarButtonItem = customBarItem
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.white
    }
    @objc func performBack(sender:UIBarButtonItem){
        self.navigationController?.popViewController(animated: true)
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
}
