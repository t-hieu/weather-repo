//
//  LWChoseManyFloorViewController.swift
//  LiftWork
//
//  Created by dangquang-hieu on 2020/01/24.
//  Copyright © 2020 Trente. All rights reserved.
//

import UIKit

protocol LWChoseManyFloorDelegate {
    func doneChoseManyFloor(floor: String, tag: String)
}

class LWChoseManyFloorViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backLabel: UILabel!
    
    @IBOutlet weak var titleView: UIView!
    @IBAction func tapBackButton(_ sender: Any) {
        let selectedIndexPaths = tableView.indexPathsForSelectedRows
        let count = selectedIndexPaths != nil ? selectedIndexPaths!.count : 0
        if count < 1 || count > 3{
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            
            let message = NSLocalizedString("SELECTED_ALERT", comment: "")
            
            let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
            /*
            let attributedText = NSMutableAttributedString(string: message)
            let range = NSRange(location: 0, length: attributedText.length)
            //attributedText.addAttribute(NSAttributedStringKey.font, value: UIFont(name: "aaa", size: 22)!, range: range)
            //attributedText.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: 99), range: range)
            let messageFont = UIFont.systemFont(ofSize: 33)
            //let messageAttrString = NSMutableAttributedString(string: message, attributes: messageFont)
            let messageAttrString = NSMutableAttributedString(string: message)
            messageAttrString.addAttributes([NSAttributedString.Key.font: messageFont], range: NSMakeRange(0, message.utf8.count))
            alert.setValue(messageAttrString, forKey: "messageAttrString")
            */
            /*
            // height constraint
            let constraintHeight = NSLayoutConstraint(
               item: alert.view!, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute:
               NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 100)
            alert.view.addConstraint(constraintHeight)

            // width constraint
            let constraintWidth = NSLayoutConstraint(
               item: alert.view!, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute:
               NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 300)
            alert.view.addConstraint(constraintWidth)
            */
            alert.addAction(action)
            
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        var arrival : String = ""
        for i in 0..<count{
            if i != (count - 1){
                arrival += floors[selectedIndexPaths![i].row] + FLOOR_MARK
            }else{
                arrival += floors[selectedIndexPaths![i].row]
            }
        }
        
        delegate?.doneChoseManyFloor(floor: arrival, tag: self.tag!)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    var floors = [String]()
    var delegate: LWChoseManyFloorDelegate?
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
    
    
}

