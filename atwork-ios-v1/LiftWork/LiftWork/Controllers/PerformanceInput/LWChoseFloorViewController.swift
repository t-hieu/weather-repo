//
//  LWChoseFloorViewController.swift
//  LiftWork
//
//  Created by CuongNV on 9/13/18.
//  Copyright © 2018 Trente. All rights reserved.
//

import UIKit
protocol LWChoseFloorDelegate {
    func doneChoseFloor(floor: String, tag: String)
}
class LWChoseFloorViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backLabel: UILabel!
    
    @IBOutlet weak var titleView: UIView!
    @IBAction func tapBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    var floors = [String]()
    var delegate: LWChoseFloorDelegate?
    var tag: String?
    var selectIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleView.backgroundColor = LW_COLOR_BLUE_LIGHT
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: LW_FONT_SIZE_BIG)
        self.backLabel.font = UIFont.boldSystemFont(ofSize: LW_FONT_SIZE_BIG)
        
        tableView.dataSource = self
        tableView.delegate = self
        self.tableView.register(UINib.init(nibName: "LWLabelCenterTableViewCell", bundle: Bundle.init(for: LWLabelCenterTableViewCell.self)), forCellReuseIdentifier: "LWLabelCenterTableViewCell")
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //table view
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.floors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "LWLabelCenterTableViewCell") as? LWLabelCenterTableViewCell
        if (cell == nil) {
            cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "LWLabelCenterTableViewCell") as? LWLabelCenterTableViewCell
        }
        cell?.label.text = self.floors[indexPath.row]
        if indexPath.row == self.selectIndex {
            cell?.backgroundColor = LW_COLOR_TITLE_INPUT_PERFORMACE
        }else{
            cell?.backgroundColor = UIColor.clear
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.doneChoseFloor(floor: self.floors[indexPath.row], tag: self.tag!)
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
