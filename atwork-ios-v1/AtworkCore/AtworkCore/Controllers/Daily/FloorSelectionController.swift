//
//  FloorSelectionController.swift
//  AtworkCore
//
//  Created by CuongNV on 10/10/18.
//  Copyright © 2018 Atwork. All rights reserved.
//

import UIKit
import TrenteCoreSwift

protocol  FloorSelectionControllerDelegate {
    func doneFloorSelectionControllerDelegate(floor: String, tag: Int)
}

class FloorSelectionController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    var floors = [String]()
    var floorChosed : String!
    //var floorChosed = [String]()
    //var index: Int!
    var tag: Int!
    var delegate: FloorSelectionControllerDelegate!
    var currentDate: Date!
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
        
       
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.register(UINib.init(nibName: "choseFloorCell", bundle: Bundle.init(for: choseFloorCell.self)), forCellReuseIdentifier: "choseFloorCell")
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = Title
    }
    
    @objc func tapLeftBarButton(){
        self.navigationController?.popViewController(animated: true)
        
    }
    
    //tableview
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.floors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell1 = tableView.dequeueReusableCell(withIdentifier: "choseFloorCell") as? choseFloorCell
        if (cell1 == nil) {
            cell1 = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "choseFloorCell") as? choseFloorCell
        }
        cell1?.label.text = self.floors[indexPath.row]
        
        if(self.floorChosed != nil && self.floorChosed.elementsEqual(self.floors[indexPath.row])){
            cell1?.backgroundColor = AT_COLOR_TITLE_INPUT_PERFORMACE
        }else{
            cell1?.backgroundColor = UIColor.clear
        }
        
        
        return cell1!
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.delegate.doneFloorSelectionControllerDelegate(floor: self.floors[indexPath.row], tag: self.tag)
        
        comeback()
    }
    
    func comeback(){
        self.navigationController?.popViewController(animated: true)
    }

}
