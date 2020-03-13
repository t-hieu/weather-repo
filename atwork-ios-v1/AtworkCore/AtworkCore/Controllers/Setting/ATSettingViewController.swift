//
//  ATSettingViewController.swift
//  AtworkCore
//
//  Created by CuongNV on 11/1/18.
//  Copyright © 2018 Atwork. All rights reserved.
//

import UIKit
import TrenteCoreSwift

public class ATSettingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = UIColor.orange
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.isTranslucent = false 
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        
        self.navigationItem.title = "設定"
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib.init(nibName: "ViewFullLabelCell", bundle: Bundle.init(for: ViewFullLabelCell.self)), forCellReuseIdentifier: "ViewFullLabelCell")
        self.tableView.tableFooterView = UIView()
    }


    //tableview
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0){
            return 1
        }
        return 5
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 40))
        headerView.backgroundColor = UIColor(red: 231/255, green: 231/255, blue: 231/255, alpha: 1)
        let label = UILabel()
        label.frame = CGRect.init(x: 15, y: 0, width: headerView.frame.width-10, height: headerView.frame.height)
        if section == 1 {
            label.text =  "アプリについて"
        }
        if section == 0 {
            label.text = "アカウント情報"
        }
        headerView.addSubview(label)
        
        return headerView
    }
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 35
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "ViewFullLabelCell") as? ViewFullLabelCell
        if (cell == nil) {
            cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "ViewFullLabelCell") as? ViewFullLabelCell
        }
        cell?.arrowRight.isHidden = false
        cell?.label.text = ""
        if(indexPath.section == 0){
            cell?.textLabel?.text = NSLocalizedString("アカウント情報", comment: "")
        }else {
            switch indexPath.row {
            case 0:
                cell?.textLabel?.text = NSLocalizedString("アプリについて", comment: "")
                break
            case 1:
                cell?.textLabel?.text = NSLocalizedString("お問い合わせ", comment: "")
                break
            case 2:
                cell?.textLabel?.text = NSLocalizedString("利用規約", comment: "")
                break
            case 3:
                cell?.textLabel?.text = NSLocalizedString("プライバシーポリシー", comment: "")
                break
            case 4:
                cell?.textLabel?.text = NSLocalizedString("ログアウト", comment: "")
                break
            default:
                cell?.textLabel?.text = ""
            }
        }
        return cell!
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        if(indexPath.section == 0){
            let info = ATAccountInformationController.init(nibName: ATAccountInformationController.className, bundle: Bundle.init(for: ATAccountInformationController.self))
            self.navigationController?.pushViewController(info, animated: true)
        }else {
            switch indexPath.row {
            case 0://about app
                let aboutVC = ATVersionViewController.init(nibName: ATVersionViewController.className, bundle: Bundle.init(for: ATVersionViewController.self))
                self.navigationController?.pushViewController(aboutVC, animated: true)
                break
            case 1://contact us
                let aboutVC = ATContactUsViewController.init(nibName: ATContactUsViewController.className, bundle: Bundle.init(for: ATContactUsViewController.self))
                self.navigationController?.pushViewController(aboutVC, animated: true)
                break
            case 2://Terms of service
                UIApplication.shared.openURL(URL(string: LW_URL_SYSTEM_TERM)!)
                break
            case 3://PrivacyPolicies
                UIApplication.shared.openURL(URL(string: LW_URL_SYSTEM_POLICY)!)
                break
                
            default:// logout
                self.confirmSignout()
                break
            }
        }
    }
    
    func confirmSignout(){
        confirmMessages(messages: NSLocalizedString("confirm_logout", comment: ""), funcOK: self.signout)
    }
    
    func signout(){
        
        let params = LWParams.initParamsLW()
        AlamofireManager.shared.request(APIRouter.post(url: API.LW_URL_SIGN_OUT, params: params, identifier: nil)) { (response) in
            if response != nil{
                //nothing
                APP_DELEGATE?.clearAll()
            }
        }
        
    }

}
