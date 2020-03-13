//
//  SettingViewController.swift
//  LiftWork
//
//  Created by CuongNV on 5/7/18.
//  Copyright © 2018 Trente. All rights reserved.
//

import UIKit
import TrenteCoreSwift

class LWSettingViewController: LWBaseViewController, UITableViewDataSource, UITableViewDelegate,MainStoryboard {
    
    @IBOutlet weak var titleRow: LWViewOneLabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Setting"
        self.titleRow.labTitle.text = NSLocalizedString("lw_setting", comment: "")
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib.init(nibName: LWSectionView.className, bundle: nil), forHeaderFooterViewReuseIdentifier: LWSectionView.className)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //tableview
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0){
            return 1
        }
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        
        if let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: LWSectionView.className) as? LWSectionView{
            switch section{
            case 0:
                header.setTextLabel(text: NSLocalizedString("lw_character_account_information", comment: ""))
                break
            case 1:
                header.setTextLabel(text: NSLocalizedString("lw_character_about_app", comment: ""))
                break
            default:
                break
            }
            return header
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        if (cell == nil) {
            cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
        }
        cell?.accessoryView = UIImageView.init(image: UIImage.init(named: "ic_arrow_right"))
//        cell?.accessoryView?.alpha = 0.1
        cell?.textLabel?.font = UIFont.regularFont(size: LW_FONT_SIZE_NORMAL)
        if(indexPath.section == 0){
            cell?.textLabel?.text = NSLocalizedString("lw_character_account_information", comment: "")
        }else {
            switch indexPath.row {
            case 0:
                cell?.textLabel?.text = NSLocalizedString("lw_character_about_app", comment: "")
                break
            case 1:
                cell?.textLabel?.text = NSLocalizedString("lw_character_contact_us", comment: "")
                break
            case 2:
                cell?.textLabel?.text = NSLocalizedString("lw_character_term_of_service", comment: "")
                break
            case 3:
                cell?.textLabel?.text = NSLocalizedString("lw_character_privacy_policy", comment: "")
                break
            case 4:
                cell?.textLabel?.text = NSLocalizedString("lw_character_logout", comment: "")
                break
            default:
                cell?.textLabel?.text = ""
            }
        }
//        cell?.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        if(indexPath.section == 0){
            let accountInformation = self.storyboard?.instantiateViewController(withIdentifier: "LWAccountInformationController")
            self.navigationController?.pushViewController(accountInformation!, animated: true)
        }else {
            switch indexPath.row {
            case 0://about app
                let aboutVC = self.storyboard?.instantiateViewController(withIdentifier: "AWVersionViewController")
                self.navigationController?.pushViewController(aboutVC!, animated: true)
                break
            case 1://contact us
                let aboutVC = self.storyboard?.instantiateViewController(withIdentifier: "AWContactUsViewController")
                self.navigationController?.pushViewController(aboutVC!, animated: true)
                break
            case 2://Terms of service
                let webView = self.storyboard?.instantiateViewController(withIdentifier: "LWWebViewController") as! LWWebViewController
                webView.urlString = LW_URL_SYSTEM_TERM
                self.navigationController?.pushViewController(webView, animated: true)
                break
            case 3://PrivacyPolicies
                let webView = self.storyboard?.instantiateViewController(withIdentifier: "LWWebViewController") as! LWWebViewController
                webView.urlString = LW_URL_SYSTEM_POLICY
                self.navigationController?.pushViewController(webView, animated: true)
                break
                
            default:// logout
                self.confirmSignout()
                break
            }
        }
    }
    
    
    func confirmSignout(){
        let signOut = { (action:UIAlertAction!) -> Void in
            self.signout()
        }
        let alertController = UIAlertController(title: "", message: NSLocalizedString("lw_logout_confirm", comment: ""), preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: NSLocalizedString("ACTION_CANCEL", comment: ""), style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        let okAction = UIAlertAction(title: NSLocalizedString("ACTION_SIGNOUT", comment: ""), style: .default, handler:signOut)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func signout(){
        APP_DELEGATE?.clearAll()
        let params = LWParamUtil.initParamsLW()
        AlamofireManager.shared.request(APIRouter.post(url: API.LW_URL_SIGN_OUT, params: params, identifier: nil)) { (response) in
            if response != nil{
                //nothing
            }
        }
        
    }

}
