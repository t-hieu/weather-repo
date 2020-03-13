//
//  ELVSelectionController.swift
//  AtworkCore
//
//  Created by CuongNV on 10/9/18.
//  Copyright © 2018 Atwork. All rights reserved.
//

import UIKit
import TrenteCoreSwift

protocol ELVSelectionControlerDelegate {
    func doneELVSelection(liftIds: [Int])
}
class ELVSelectionController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var headerVIew: UIView!
    @IBAction func DecisionTap(_ sender: Any) {
        self.delegate.doneELVSelection(liftIds: self.elvIdChose)
        self.navigationController?.popViewController(animated: true)
    }
    @IBOutlet weak var tableView: UITableView!
    var elvList = [ATLiftModel]()
    var isEventMode = true
    var elvIdChose = [Int]()
    var currentDate: Date!
    var delegate: ELVSelectionControlerDelegate!
    var Title:String?
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.barTintColor = UIColor.orange
        self.navigationController?.navigationBar.isTranslucent = false 
        let leftBarButton = UIBarButtonItem(title: "＜戻る", style: .plain, target: self, action: #selector(self.tapLeftBarButton))
        leftBarButton.titleTextAttributes(for: .normal)
        leftBarButton.setTitleTextAttributes([NSAttributedStringKey.font: UIFont.boldFont(size: AT_FONT_SIZE_NORMAL)], for: .normal)
        leftBarButton.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItem = leftBarButton
        
        self.navigationItem.title = "Construction select"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        self.headerVIew.layer.borderWidth = 0.5
        self.headerVIew.layer.borderColor = AT_COLOR_BORDER.cgColor
        self.headerVIew.backgroundColor = AT_COLOR_TITLE_INPUT_PERFORMACE
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
        
        self.tableView.register(UINib.init(nibName: "LWCellOneLabel", bundle: Bundle.init(for: LWCellOneLabel.self)), forCellReuseIdentifier: "LWCellOneLabel")
        
    }

    @objc func tapLeftBarButton(){
        
         self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = Title
    }

    //tableview
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.elvList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell1 = tableView.dequeueReusableCell(withIdentifier: "LWCellOneLabel") as? LWCellOneLabel
        if (cell1 == nil) {
            cell1 = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "LWCellOneLabel") as? LWCellOneLabel
        }
        cell1?.label.text = self.elvList[indexPath.row].liftName
        if self.elvIdChose.contains(self.elvList[indexPath.row].liftId!) {
            cell1?.imgCheck.isHidden = false
        }else{
            cell1?.imgCheck.isHidden = true
        }
        return cell1!
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        self.delegate.doneELVSelection(lift: self.elvList[indexPath.row])
//        comeback()
        if self.isEventMode {
            let index = self.elvIdChose.firstIndex(of: self.elvList[indexPath.row].liftId!)
            if index ?? -1 >= 0 {
                self.elvIdChose.remove(at: index!)
            }else{
                self.elvIdChose.append(self.elvList[indexPath.row].liftId!)
            }
        }else {
            self.elvIdChose.removeAll()
            self.elvIdChose.append(self.elvList[indexPath.row].liftId!)
        }
        tableView.reloadData()
    }
    
    func comeback(){
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
