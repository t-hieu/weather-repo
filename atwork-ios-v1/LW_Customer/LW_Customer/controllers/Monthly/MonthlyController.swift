//
//  MonthlyController.swift
//  LW_Customer
//
//  Created by CuongNV on 9/12/18.
//  Copyright © 2018 Trente. All rights reserved.
//

import UIKit
import TrenteCoreSwift
import AtworkCore

class MonthlyController: UIViewController, MainStoryboard {
    @IBOutlet weak var dayTitleView: UIView!
    
    @IBOutlet weak var dayTitleLabel: UILabel!
    @IBOutlet weak var dayConstructionView: UIView!
    @IBOutlet weak var dayStatusView: UIView!
    @IBOutlet weak var dayReservationView: UIView!
    @IBOutlet weak var dayInfoConstruction: UIView!
    
    @IBOutlet weak var monthlyView: MonthlyView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = UIColor.orange
        
        let leftBarButton = UIBarButtonItem(title: "<", style: .plain, target: self, action: #selector(self.tapLeftBarButton))
        leftBarButton.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItem = leftBarButton
        
        self.navigationItem.title = "8/2018"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        
        let rightBarButton = UIBarButtonItem(title: "Daily", style: .plain, target: self, action: #selector(self.tapRightBarButton))
        rightBarButton.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        
        dayTitleView.layer.borderWidth = 1
        dayTitleView.layer.borderColor = UIColor.init(hex:"D8D8D8").cgColor
        dayConstructionView.layer.borderWidth = 1
        dayConstructionView.layer.borderColor = UIColor.init(hex:"D8D8D8").cgColor
        dayStatusView.layer.borderWidth = 1
        dayStatusView.layer.borderColor = UIColor.init(hex:"D8D8D8").cgColor
        dayReservationView.layer.borderWidth = 1
        dayReservationView.layer.borderColor = UIColor.init(hex:"D8D8D8").cgColor
        dayInfoConstruction.layer.borderWidth = 1
        dayInfoConstruction.layer.borderColor = UIColor.init(hex:"D8D8D8").cgColor

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if LWUserDefaults.getConstructionId().isEmpty {
            let vc = SelectContructionController.init(nibName: SelectContructionController.className, bundle: Bundle.init(for: SelectContructionController.self))
            vc.index = 0
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }
    
    var month: Int? = 2
    @objc func tapLeftBarButton(){
        month = month! - 1
        self.navigationItem.title = "\(month! + 1)/2018"
        monthlyView.weeksInMonth(month: month!, year: 2018)
        
    }
    
    @objc func tapRightBarButton(){
//        month = month + 1
        month = month! + 1
        self.navigationItem.title = "\(month! + 1 )/2018"
        monthlyView.weeksInMonth(month: month!, year: 2018)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
}
