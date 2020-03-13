//
//  ATCreaterViewerController.swift
//  AtworkCore
//
//  Created by CuongNV on 11/19/18.
//  Copyright © 2018 Atwork. All rights reserved.
//

import UIKit

class ATCreaterViewerController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    
    @IBOutlet weak var tableView: UITableView!
    var createrSchedule: ATUserModel!
    var isactive = true
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = UIColor.orange
        self.navigationController?.navigationBar.isTranslucent = false 
        let leftBarButton = UIBarButtonItem(title: "＜戻る", style: .plain, target: self, action: #selector(self.tapLeftBarButton))
        leftBarButton.titleTextAttributes(for: .normal)
        leftBarButton.setTitleTextAttributes([NSAttributedStringKey.font: UIFont.boldFont(size: AT_FONT_SIZE_NORMAL)], for: .normal)
        leftBarButton.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItem = leftBarButton
        
        self.navigationItem.title = "担当者連絡先"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        // Do any additional setup after loading the view.
        self.tableView.register(UINib.init(nibName: "ViewFullLabelCell", bundle: Bundle.init(for: ViewFullLabelCell.self)), forCellReuseIdentifier: "ViewFullLabelCell")
        self.tableView.register(UINib.init(nibName: "PhoneNumberCell", bundle: Bundle.init(for: PhoneNumberCell.self)), forCellReuseIdentifier: "PhoneNumberCell")
        
        self.tableView.tableFooterView = UIView()
        self.tableView.separatorStyle = .none
    }
    @objc func tapLeftBarButton(){
        self.navigationController?.popViewController(animated: true)
        
    }
    //tableview
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 45
        }
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
        headerView.backgroundColor = UIColor(red: 231/255, green: 231/255, blue: 231/255, alpha: 1)
        let label = UILabel()
        label.frame = CGRect.init(x: 15, y: -10, width: headerView.frame.width-10, height: headerView.frame.height)
        label.font = UIFont.boldFont(size: 17)
        
        switch section {
        case 0:
            label.text =  "担当者名"
        case 1:
            label.text =  "よみ"
        case 2:
            label.text =  "E-mail"
        case 3:
            label.text =  "Mob"
        
        default:
            label.text =  ""
        }
        headerView.addSubview(label)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         var cell = tableView.dequeueReusableCell(withIdentifier: "ViewFullLabelCell") as? ViewFullLabelCell
        if indexPath.section != 3 {
           
            if (cell == nil) {
                cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "ViewFullLabelCell") as? ViewFullLabelCell
            }
            switch indexPath.section {
            case 0:
                if self.createrSchedule != nil && self.createrSchedule.userName != nil {
                    cell?.label.text = self.createrSchedule.userName
                }else {
                    cell?.label.text = ""
                }
                break
            case 1:
                if self.createrSchedule != nil && self.createrSchedule.userNameKana != nil {
                    cell?.label.text = self.createrSchedule.userNameKana
                }else {
                    cell?.label.text = ""
                }
                //            cell?.label.text = self.createrSchedule.userNameKana
                break
            case 2:
                if self.createrSchedule != nil && self.createrSchedule.userEmail != nil {
                    cell?.label.text = self.createrSchedule.userEmail
                }else {
                    cell?.label.text = ""
                }
                //            cell?.label.text = self.createrSchedule.userEmail
                break
            default:
                break
        }
            
        }
        if indexPath.section == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PhoneNumberCell") as? PhoneNumberCell
            if self.createrSchedule != nil && self.createrSchedule.userPhone != nil {
                cell?.label.text = self.createrSchedule.userPhone
            }else {
                cell?.label.text = ""
            }
            //            cell?.label.text = self.createrSchedule.userPhone
            cell?.label.textColor = UIColor.blue
            return  cell!
        }
        return cell!
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 3 && self.createrSchedule != nil && self.createrSchedule.userPhone != nil && self.createrSchedule.userPhone != "" {
            
            makePhoneCall(phoneNumber: self.createrSchedule.userPhone)
            _ = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.update), userInfo: nil, repeats: false)
        }
    }
    
    @objc func update() {
        isactive = true
    }
    func makePhoneCall(phoneNumber:String?){
        if isactive {
        if  let phone = phoneNumber{
            if let url = URL(string: "tel://\(phone)"), UIApplication.shared.canOpenURL(url) {
                if #available(iOS 10, *) {
                    UIApplication.shared.open(url)
                } else {
                    UIApplication.shared.openURL(url)
                }
                self.isactive = false
            }else{
                let alert = UIAlertController.init(title:"", message: "Device is not support phone call.", preferredStyle: .alert)
                let okAction:UIAlertAction = UIAlertAction.init(title: "OK", style: .default) { (action) in
                    
                }
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
                
//                self.present(alertController, animated: true, completion: nil)
            }
        }
        }
        else {
            return
        }
    }
}
