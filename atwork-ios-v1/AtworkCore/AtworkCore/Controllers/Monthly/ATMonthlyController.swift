//
//  ATMonthlyController.swift
//  AtworkCore
//
//  Created by CuongNV on 10/18/18.
//  Copyright © 2018 Atwork. All rights reserved.
//

import UIKit
import TrenteCoreSwift

public protocol ATMonthlyControllerDelegate {
    func changeTapToDaily()
}
public class ATMonthlyController: UIViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource, ATMonthlyPartControllerDelegate, LWChoseConstructionViewDelegate {

    @IBOutlet weak var dayTitleView: UIView!
    
    @IBOutlet weak var dayTitleLabel: UILabel!
    @IBOutlet weak var dayConstructionView: UIView!
    @IBOutlet weak var dayStatusView: UIView!
    @IBOutlet weak var dayReservationView: UIView!
    @IBOutlet weak var dayInfoConstruction: UIView!
  
    @IBOutlet weak var constructionLabel: LWBlackNormalRegularLabel!
    
    @IBOutlet weak var statusLabel: LWBlackNormalRegularLabel!
    @IBOutlet weak var reservationLabel: LWBlackNormalRegularLabel!
    
    @IBAction func tapChangeConstruction(_ sender: Any) {
        let vc = ChoseConstructionController.init(nibName: ChoseConstructionController.className, bundle: Bundle.init(for: ChoseConstructionController.self))
        vc.delegate = self
        if self.construction != nil {
            vc.construction = self.construction
        }
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    @IBAction func tapConstructiondetail(_ sender: Any) {
        if self.construction != nil {
            let vc = ATConstructionDetailController.init(nibName: ATConstructionDetailController.className, bundle: Bundle.init(for: ATConstructionDetailController.self))
            vc.construction = self.construction
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }
    @IBOutlet weak var monthlyView: UIView!
    var cellWidth: CGFloat!
    var cellHeight: CGFloat!
    var construction: ATConstructionModel!
//    var dayModelChose: ATDailyModel!
    var pageViewController :UIPageViewController!;
    var myViewControllers = [ATMonthlyPartController]()
//    var monthIndex: Int!
//    var yearIndex: Int!
    var dayChose: Date!
    public var delegate: ATMonthlyControllerDelegate!
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        statusLabel.center.y = self.view.center.y
        self.navigationController?.navigationBar.barTintColor = UIColor.orange
        self.navigationController?.navigationBar.isTranslucent = false 
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        self.navigationController?.navigationBar.isTranslucent = false 
        let rightBarButton = UIBarButtonItem(title: "日別", style: .plain, target: self, action: #selector(self.tapRightBarButton))
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
        
        
        
        if(pageViewController == nil){
            self.pageViewController = UIPageViewController.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        }
        self.addChildViewController(self.pageViewController)
        self.monthlyView.addSubview(self.pageViewController.view)
        self.pageViewController.delegate = self
        self.pageViewController.dataSource = self
        self.pageViewController.didMove(toParentViewController: self)
        
    }

    public override func viewDidAppear(_ animated: Bool) {
        self.cellWidth = self.monthlyView.frame.width/7
        self.cellHeight = (self.monthlyView.frame.height - 30)/6
        self.addFirstSchedule(animated: animated)
        
    }
    func addFirstSchedule(animated: Bool){
        let currentLocalDate = Calendar.current.date(byAdding: .hour, value: -HOUR_ADD, to: Date())
//        print(TRFormatUtil.formatDateCustom(date: self.dayChose, format: "yyyy/MM/dd hh:mm:ss"))
        let monthIndex: Int = Int(TRFormatUtil.formatDateCustom(date: currentLocalDate, format: "MM"))!
        let yearIndex: Int = Int(TRFormatUtil.formatDateCustom(date: currentLocalDate, format: "yyyy"))!
        self.navigationItem.title = String(yearIndex) + "年" + String(monthIndex) + "月"
        self.myViewControllers.removeAll()
        
        let firstViewController = ATMonthlyPartController.init(nibName: ATMonthlyPartController.className, bundle: Bundle.init(for: ATMonthlyPartController.self))
        firstViewController.cellHeight = self.cellHeight
        firstViewController.cellWidth = self.cellWidth
        firstViewController.delegate = self
        firstViewController.dayChose = nil
        firstViewController.didChangeMonth(monthIndex: monthIndex, year: yearIndex)
        self.myViewControllers.removeAll()
        
        self.myViewControllers.append(firstViewController)
        self.pageViewController.setViewControllers(self.myViewControllers, direction: .forward, animated: false, completion: nil)
//        self.monthlyView.isUserInteractionEnabled = false
    }
    override public func viewWillAppear(_ animated: Bool) {
        if ATUserDefaults.getConstructionId().isEmpty {
            let vc = SelectContructionController.init(nibName: SelectContructionController.className, bundle: Bundle.init(for: SelectContructionController.self))
            vc.index = 0
            self.navigationController?.pushViewController(vc, animated: false)
        }else {
            self.navigationController?.isNavigationBarHidden = false
        }
        
    }
    override public func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.pageViewController.view.frame = CGRect.init(x: 0, y: 0, width: self.monthlyView.frame.width, height: self.monthlyView.frame.height);
        self.view.layoutIfNeeded()
    }
    
    @objc func tapRightBarButton(){
        ATUserDefaults.setDayForDaily(val: TRFormatUtil.formatDateCustom(date: self.dayChose, format: "yyyy/MM/dd"))
        self.delegate.changeTapToDaily()
        
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = self.myViewControllers.firstIndex(of: viewController as! ATMonthlyPartController) else {
            return nil
        }
        if viewControllerIndex == NSNotFound {
            return nil
        }else {
            let vc : ATMonthlyPartController = self.viewControllerAtIndex(index: viewControllerIndex - 1) as! ATMonthlyPartController
            let currentVC : ATMonthlyPartController = viewController as! ATMonthlyPartController
            var yearIndex = currentVC.currentYear
            var monthIndex = currentVC.currentMonthIndex
                
            monthIndex -= 1
            if monthIndex < 1 {
                monthIndex = 12
                yearIndex -= 1
            }
            vc.cellHeight = self.cellHeight
            vc.cellWidth = self.cellWidth
            vc.delegate = self
            vc.dayChose = self.dayChose
            vc.didChangeMonth(monthIndex: monthIndex, year: yearIndex)
            return vc
        }

    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = self.myViewControllers.firstIndex(of: viewController as! ATMonthlyPartController) else {
            return nil
        }
        if viewControllerIndex == NSNotFound {
            return nil
        }else {
            
            let vc : ATMonthlyPartController = self.viewControllerAtIndex(index: viewControllerIndex + 1) as! ATMonthlyPartController
            let currentVC : ATMonthlyPartController = viewController as! ATMonthlyPartController
            var yearIndex = currentVC.currentYear
            var monthIndex = currentVC.currentMonthIndex
            monthIndex += 1
            if monthIndex > 12 {
                monthIndex = 1
                yearIndex += 1
            }
            vc.cellHeight = self.cellHeight
            vc.cellWidth = self.cellWidth
            vc.delegate = self
            vc.dayChose = self.dayChose
            vc.didChangeMonth(monthIndex: monthIndex, year: yearIndex)
            return vc
        }
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            if let vc = pageViewController.viewControllers![0] as? ATMonthlyPartController {
                self.navigationItem.title = String(vc.currentYear) + "年" + String(vc.currentMonthIndex) + "月"
            }
        }
        
    }
    
    func viewControllerAtIndex(index: Int) -> UIViewController? {
        if index == -1 {
            let vc = ATMonthlyPartController.init(nibName: ATMonthlyPartController.className, bundle: Bundle.init(for: ATMonthlyPartController.self))
            self.myViewControllers.insert(vc, at: 0)
            return vc
        }else if index >= self.myViewControllers.count {
            let vc = ATMonthlyPartController.init(nibName: ATMonthlyPartController.className, bundle: Bundle.init(for: ATMonthlyPartController.self))
            self.myViewControllers.append(vc)
//            vc.delegate = self
            return vc
        }else {
            return self.myViewControllers[index]
        }
    }
    
    //delegate
    func tapDayView(dayModel: ATDailyModel) {
//        self.dayModelChose = dayModel
        self.constructionLabel.text = ATUserDefaults.getConstructionName()
        self.statusLabel.text = dayModel.statusName
        self.reservationLabel.text = String(dayModel.progress) + "%"
        var result =  TRFormatUtil.formatDateCustom(date: dayModel.date, format: "yyyy年M月d日")
        switch dayModel.date?.weekday {
        case 1:
            result  = result + "(日)"
            break
        case 2 :
            result  = result + "(月)"
            break
        case 3 :
            result  = result + "(火)"
            break
        case 4 :
            result  = result + "(水)"
            break
        case 5 :
            result  = result + "(木)"
            break
        case 6 :
            result  = result + "(金)"
            break
        case 7 :
            result  = result + "(土)"
            break
        default:
            result = result + ""
        }
        self.dayTitleLabel.text = result
        self.dayChose = dayModel.date
        ATUserDefaults.setDayForDaily(val: TRFormatUtil.formatDateCustom(date: self.dayChose, format: "yyyy/MM/dd"))
    }
    func doneLoadData(construction: ATConstructionModel) {
//        self.monthIndex = month
//        self.yearIndex = year
        self.construction = construction
//        self.monthlyView.isUserInteractionEnabled = true
//        self.navigationItem.title = String(year) + "年" + String(month) + "月"
    }
    
    func tapChoseConstructionView(construction: ATConstructionModel) {
        ATUserDefaults.setConstructionId(val: (construction.key?.description)!)
        ATUserDefaults.setConstructionName(val: construction.constructionName!)
        
    }

}
