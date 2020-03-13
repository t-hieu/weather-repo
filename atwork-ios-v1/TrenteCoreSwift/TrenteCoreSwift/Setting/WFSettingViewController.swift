//
//  WFSettingViewController.swift
//  TrenteCoreSwift
//
//  Created by HtHoan on 12/6/17.
//  Copyright © 2017 Trente. All rights reserved.
//

import UIKit

open  class WFSettingViewController: WFBaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    override open func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = super.titleString
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.backgroundColor = super.baseColor
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        self.view.backgroundColor = super.baseColor
    }
    
    // MARK: - TableView
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0){
            return 1
        }else{
            return 5
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        if (cell == nil) {
            cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
        }
        if(indexPath.section == 0){
            if(indexPath.row == 0){
                cell?.textLabel?.text = NSLocalizedString("ol_setting_account_info", comment: "")
            }
        }else{
            switch indexPath.row {
            case 0:
                cell?.textLabel?.text = NSLocalizedString("ol_setting_about_app", comment: "")
                break
            case 1:
                cell?.textLabel?.text = NSLocalizedString("ol_setting_contact_us", comment: "")
                break
            case 2:
                cell?.textLabel?.text = NSLocalizedString("ol_setting_term_of_service", comment: "")
                break
            case 3:
                cell?.textLabel?.text = NSLocalizedString("ol_setting_privacy_policy", comment: "")
                break
            case 4:
                cell?.textLabel?.text = NSLocalizedString("ol_setting_sign_out", comment: "")
                break
            default:
                cell?.textLabel?.text = ""
            }
        }
        cell?.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        return cell!
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(section == 0) {
            return 40
        }
        return tableView.sectionHeaderHeight
    }
    
    public  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(section == 0){
            return NSLocalizedString("ol_setting_header_account_info", comment: "")
        }else{
            return NSLocalizedString("ol_setting_header_about_app", comment: "")
        }
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        if(indexPath.section == 0 && indexPath.row == 0){
            let aboutInfoVC = self.storyboard?.instantiateViewController(withIdentifier: "WFOAccountInformationViewController")
            self.navigationController?.pushViewController(aboutInfoVC!, animated: true)
        }else if(indexPath.section == 1){
            switch indexPath.row {
            case 0:
                let bundle = Bundle.init(for: WFAboutAppViewController.self)
                let aboutVC = WFAboutAppViewController.init(nibName: "WFAboutAppViewController", bundle: bundle) as WFAboutAppViewController
                aboutVC.baseColor = baseColor
                aboutVC.imageApp = imageApp
                aboutVC.backgroundColor = backgroundColor
                self.navigationController?.pushViewController(aboutVC, animated: true)
                break
            case 1:
                let bundle = Bundle.init(for: WFContactUsViewController.self)
                let contactVC = WFContactUsViewController.init(nibName: "WFContactUsViewController", bundle: bundle) as WFContactUsViewController
                contactVC.baseColor = baseColor
                contactVC.imageApp = imageApp
                contactVC.backgroundColor = backgroundColor
                self.navigationController?.pushViewController(contactVC, animated: true)
                break
            case 2:
                let language = Bundle.main.preferredLocalizations[0]
                let urlString = String(format: "%@/%@",WF_URL_SERVICE_OF_TERMS, language)
                if !urlString.isEmpty{
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(URL.init(string: urlString)!, options: [:], completionHandler: nil)
                    } else {
                        // Fallback on earlier versions
                    }
                }
                break
            case 3:
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(URL.init(string: WF_URL_PRIVACY_POLICY)!, options:[:], completionHandler: nil)
                } else {
                    // Fallback on earlier versions
                }
                break
            case 4:
                self.confirmSignout()
                break
            default:
                break
            }
        }else{
        }
    }
    
    public func confirmSignout(){
        let signOut = { (action:UIAlertAction!) -> Void in
            self.signout()
        }
        let alertController = UIAlertController(title: "", message: NSLocalizedString("ol_setting_signout_confirm", comment: ""), preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: NSLocalizedString("tr_common_action_cancel", comment: ""), style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        let okAction = UIAlertAction(title: NSLocalizedString("tr_common_action_ok", comment: ""), style: .default, handler:signOut)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
     func signout(){
        let params = TRParamsUtil.initParamsOL()
        HTTPRequestManager.getInstance().asyncPOST(url: WF_URL_SIGN_OUT, params: params as [String : AnyObject], isLoading: true, success: {(response) -> Void in
            self.afterSignOut()
        })
    }
    open func afterSignOut(){
    }
    public func removeRegistration(refreshedToken:String){
        var params = TRParamsUtil.initParamsOL()
        params["deviceRegister"] = refreshedToken
        HTTPRequestManager.getInstance().asyncPOST(url: WF_URL_DEVICE_CLEAR, params: params as [String : AnyObject], isLoading: true, success: {(response) -> Void in

        })
        print("removeRegistration")
    }
}
