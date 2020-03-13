//
//  ATBasicViewController.swift
//  AtworkCore
//
//  Created by CuongNV on 10/31/18.
//  Copyright © 2018 Atwork. All rights reserved.
//

import UIKit

public class ATBasicViewController: UIViewController {

    @IBOutlet weak var CompanyView: UIView!
    @IBOutlet weak var NameCompanyView: UIView!
    @IBOutlet weak var Company: LWLabel!
    @IBOutlet weak var NameCompany: UILabel!
    @IBOutlet weak var TableView: UITableView!
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.CompanyView.backgroundColor =  AT_COLOR_TITLE_INPUT_PERFORMACE
        self.Company.text = "会社名"
        self.CompanyView.layer.borderWidth = 0.5
        self.CompanyView.layer.borderColor = AT_COLOR_BORDER.cgColor
        self.NameCompanyView.layer.borderWidth = 0.5
        self.NameCompanyView.layer.borderColor = AT_COLOR_BORDER.cgColor
        self.navigationController?.navigationBar.barTintColor = UIColor.orange
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.isTranslucent = false 
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        TableView.register(UINib.init(nibName: "ViewFullLabelCell", bundle: Bundle.init(for: LWCellOneLabel.self)), forCellReuseIdentifier: "ViewFullLabelCell")
        NameCompany.text = ATUserDefaults.getCompanyName()
        TableView.delegate = self
        TableView.dataSource = self
        TableView.isScrollEnabled = false
        TableView.tableFooterView = UIView()
        self.navigationItem.title = "　基本情報設定"
    }


   
 let data = ["担当者設定","揚重品目設定","予約申請一覧"]
}
// MARK: - Table View

extension ATBasicViewController : UITableViewDelegate , UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell1 = TableView.dequeueReusableCell(withIdentifier: "ViewFullLabelCell") as? ViewFullLabelCell
        if (cell1 == nil) {
            cell1 = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "ViewFullLabelCell") as? ViewFullLabelCell
        }
        cell1?.label.text = self.data[indexPath.row]
        cell1?.arrowRight.isHidden = false
        return cell1!
    }
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        switch indexPath.row {
            
        case 0:
            let vc = ATPersionInChargeSetting.init(nibName: ATPersionInChargeSetting.className, bundle: Bundle.init(for: ATPersionInChargeSetting.self))
            self.navigationController?.pushViewController(vc, animated: false)
            break
        case 1:
            let vc = ATSettingLiftmaterialController.init(nibName: ATSettingLiftmaterialController.className, bundle: Bundle.init(for: ATSettingLiftmaterialController.self))
            self.navigationController?.pushViewController(vc, animated: false)
            break
        case 2:
            let vc = ATReservationListViewController.init(nibName: ATReservationListViewController.className, bundle: Bundle.init(for: ATReservationListViewController.self))
            self.navigationController?.pushViewController(vc, animated: false)
            break
        default:
            break
        
        }
    }
    
}
