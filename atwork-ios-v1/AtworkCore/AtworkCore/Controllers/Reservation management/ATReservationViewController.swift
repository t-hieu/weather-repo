//
//  ATReservationViewController.swift
//  AtworkCore
//
//  Created by CuongNV on 11/13/18.
//  Copyright © 2018 Atwork. All rights reserved.
//

import UIKit
import ObjectMapper
public class ATReservationViewController: UIViewController {

    @IBOutlet weak var CompanyView: UIView!
    @IBOutlet weak var NameCompanyView: UIView!
    @IBOutlet weak var Company: LWLabel!
    @IBOutlet weak var NameCompany: UILabel!
    @IBOutlet weak var TableView: UITableView!
    var contruction:ATConstructionModel?
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.CompanyView.backgroundColor =  AT_COLOR_TITLE_INPUT_PERFORMACE
        self.Company.text = "現場名"
        self.CompanyView.layer.borderWidth = 0.5
        self.CompanyView.layer.borderColor = AT_COLOR_BORDER.cgColor
        self.NameCompanyView.layer.borderWidth = 0.5
        self.NameCompanyView.layer.borderColor = AT_COLOR_BORDER.cgColor
        self.navigationController?.navigationBar.barTintColor = UIColor.orange
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.isTranslucent = false 
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        TableView.register(UINib.init(nibName: "ViewFullLabelCell", bundle: Bundle.init(for: LWCellOneLabel.self)), forCellReuseIdentifier: "ViewFullLabelCell")
        
        TableView.delegate = self
        TableView.dataSource = self
        TableView.isScrollEnabled = false
        TableView.tableFooterView = UIView()
        self.navigationItem.title = "予約管理"
        
    }
    
    var workingStartTime = "8:00"
    var  workingEndTime = "17:30"
    var isBreakTimeEnable: Bool?
    let data = ["予約申請対象期間設定","予約申請締め切り設定","稼働時間設定","休憩時間設定"]
    public override func viewWillAppear(_ animated: Bool) {
        NameCompany.text = ATUserDefaults.getConstructionName()
    }
}
// MARK: - Table View

extension ATReservationViewController : UITableViewDelegate , UITableViewDataSource {
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
        cell1?.arrowRight.isHidden = false
        cell1?.label.text = data[indexPath.row]
        return cell1!
    }
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        switch indexPath.row {
        case 0:
            let vc = SettingPeriodRegularRequestTargetViewController.init(nibName: SettingPeriodRegularRequestTargetViewController.className, bundle: Bundle.init(for: SettingPeriodRegularRequestTargetViewController.self))

            self.navigationController?.pushViewController(vc, animated: false)
            break
        case 1:
            let vc = ReservationRequestDeadlineSettingViewController.init(nibName: ReservationRequestDeadlineSettingViewController.className, bundle: Bundle.init(for: ReservationRequestDeadlineSettingViewController.self))

            self.navigationController?.pushViewController(vc, animated: false)
            break
        case 2:
            let vc = OperationTimeSettingViewController.init(nibName: OperationTimeSettingViewController.className, bundle: Bundle.init(for: OperationTimeSettingViewController.self))

            self.navigationController?.pushViewController(vc, animated: false)
            break
        case 3:
            let vc = BreakTimeSettingViewController.init(nibName: BreakTimeSettingViewController.className, bundle: Bundle.init(for: BreakTimeSettingViewController.self))
           
            self.navigationController?.pushViewController(vc, animated: false)
            break
        default:
            break
        }
    }
    
    
}
