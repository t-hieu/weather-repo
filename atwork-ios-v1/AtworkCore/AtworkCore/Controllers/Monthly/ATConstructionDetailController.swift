//
//  ATConstructionDetailController.swift
//  AtworkCore
//
//  Created by CuongNV on 10/19/18.
//  Copyright © 2018 Atwork. All rights reserved.
//

import UIKit

class ATConstructionDetailController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    var construction: ATConstructionModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barTintColor = UIColor.orange
        self.navigationController?.navigationBar.isTranslucent = false 
        let leftBarButton = UIBarButtonItem(title: "＜戻る", style: .plain, target: self, action: #selector(self.tapLeftBarButton))
        leftBarButton.titleTextAttributes(for: .normal)
        leftBarButton.setTitleTextAttributes([NSAttributedStringKey.font: UIFont.boldFont(size: AT_FONT_SIZE_NORMAL)], for: .normal)
        leftBarButton.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItem = leftBarButton
        
        self.navigationItem.title = "現場情報"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        // Do any additional setup after loading the view.
        self.tableView.register(UINib.init(nibName: "ViewFullLabelCell", bundle: Bundle.init(for: ViewFullLabelCell.self)), forCellReuseIdentifier: "ViewFullLabelCell")
        self.tableView.tableFooterView = UIView()
        self.tableView.separatorStyle = .none
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = UITableViewAutomaticDimension
    }
    @objc func tapLeftBarButton(){
        self.navigationController?.popViewController(animated: true)
        
    }
    //tableview
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return self.cellHeight
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "ViewFullLabelCell") as? ViewFullLabelCell
        if (cell == nil) {
            cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "ViewFullLabelCell") as? ViewFullLabelCell
        }
        cell?.label.font = UIFont.systemFont(ofSize: 15)
        switch indexPath.section {
        case 0:
            cell?.label.text = self.construction.constructionName
            break
        case 1:
            cell?.label.text = ""
            if self.construction.reservationSetting != nil {
                cell?.label.text = self.construction.reservationSetting.workingStartTime + " - " + self.construction.reservationSetting.workingEndTime
            }
            break
        case 2:
            cell?.label.text = ""
            if self.construction.reservationSetting != nil {
                cell?.label.text = self.construction.reservationSetting.isNoneWorkingEnable == false ?"可":"不可"
            }
            break
        case 3:
            
            cell?.label.numberOfLines = 0
            var stringBreakTime = ""
            if self.construction.siteBreakTimes.count > 0 {
                for siteBreakTime in self.construction.siteBreakTimes {
                    stringBreakTime += siteBreakTime.breakStartTime + " - " + siteBreakTime.breakEndTime + ", "
                }
                
                stringBreakTime.removeLast()
                stringBreakTime.removeLast()
            }else {
                stringBreakTime = "  "
            }
            
            cell?.label.text = stringBreakTime
            break
        case 4:
            
            cell?.label.text = ""
            if self.construction.reservationSetting != nil {
                cell?.label.text = self.construction.reservationSetting.isBreakTimeEnable == false ?"可":"不可"
            }
            break
        case 5:
            cell?.label.numberOfLines = 0
            cell?.label.text = self.construction.constructionNote
            break
        default:
            break
        }
//        cell?.fillData(dailies: self.dailies, week: indexPath.row, delegate: self)
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       
            let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 16))
            headerView.backgroundColor = AT_COLOR_TITLE_INPUT_PERFORMACE
            let label = UILabel()
            label.frame = CGRect.init(x: 15, y: 5, width: headerView.frame.width-10, height: headerView.frame.height)
            label.font = UIFont.boldFont(size: AT_FONT_SIZE_NORMAL)
            switch section {
            case 0:
                label.text =  "現場名"
            case 1:
                label.text =  "稼働時間"
            case 2:
                label.text =  "稼働時間外予約申請"
            case 3:
                label.text =  "休憩時間"
            case 4:
                label.text =  "休憩時間予約申請"
            case 5:
                label.text =  "目安情報"
            default:
                label.text =  ""
            }
            headerView.addSubview(label)
            
            return headerView
    }
   

}

