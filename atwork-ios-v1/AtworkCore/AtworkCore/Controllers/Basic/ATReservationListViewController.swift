//
//  ATReservationListViewController.swift
//  AtworkCore
//
//  Created by Trần Tiến Anh on 11/5/18.
//  Copyright © 2018 Atwork. All rights reserved.
//

import UIKit
import TrenteCoreSwift

class ATReservationListViewController: UIViewController , UIPageViewControllerDelegate ,UIPageViewControllerDataSource{
    @IBOutlet weak var ReservationListView: UIView!
    var pageViewController :UIPageViewController!
    @IBOutlet weak var headerVIew: UIView!
     var dayChose: Date!
     var myViewControllers = [ATReservationListPartController]()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.barTintColor = UIColor.orange
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.isTranslucent = false 
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        let leftBarButton = UIBarButtonItem(title: "＜戻る", style: .plain, target: self, action: #selector(self.tapLeftBarButton))
        leftBarButton.titleTextAttributes(for: .normal)
        leftBarButton.setTitleTextAttributes([NSAttributedStringKey.font: UIFont.boldFont(size: AT_FONT_SIZE_NORMAL)], for: .normal)
        leftBarButton.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItem = leftBarButton
        self.headerVIew.layer.borderWidth = 0.5
        self.headerVIew.layer.borderColor = AT_COLOR_BORDER.cgColor
        self.headerVIew.backgroundColor = AT_COLOR_TITLE_INPUT_PERFORMACE
       
        if(pageViewController == nil){
            self.pageViewController = UIPageViewController.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        }
        self.dayChose = Calendar.current.date(byAdding: .hour, value: -HOUR_ADD, to: Date())
        self.addChildViewController(self.pageViewController)
        self.ReservationListView.addSubview(self.pageViewController.view)
        self.pageViewController.delegate = self
        self.pageViewController.dataSource = self
        self.pageViewController.didMove(toParentViewController: self)
        
        self.addFirstSchedule()
      
    }
    
    override public func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.pageViewController.view.frame = CGRect.init(x: 0, y: 0, width: self.ReservationListView.frame.width, height: self.ReservationListView.frame.height);
        self.view.layoutIfNeeded()
    }
    
    @objc func tapLeftBarButton(){
        self.navigationController?.popViewController(animated: true)
    }
    func addFirstSchedule(){
        
        let monthIndex: Int = Int(TRFormatUtil.formatDateCustom(date: dayChose, format: "MM"))!
        let yearIndex: Int = Int(TRFormatUtil.formatDateCustom(date: dayChose, format: "yyyy"))!
        self.navigationItem.title = "予約申請一覧 " + String(yearIndex) + "年" + String(monthIndex) + "月"
        self.myViewControllers.removeAll()
        
        let firstViewController = ATReservationListPartController.init(nibName: ATReservationListPartController.className, bundle: Bundle.init(for: ATReservationListPartController.self))
        firstViewController.currentYear = yearIndex
        firstViewController.currentMonth = monthIndex
        
        self.myViewControllers.removeAll()
        self.myViewControllers.append(firstViewController)
        self.pageViewController.setViewControllers(self.myViewControllers, direction: .forward, animated: false, completion: nil)
    }
    func viewControllerAtIndex(index: Int) -> UIViewController? {
        if index == -1 {
            let vc = ATReservationListPartController.init(nibName: ATReservationListPartController.className, bundle: Bundle.init(for: ATReservationListPartController.self))
            self.myViewControllers.insert(vc, at: 0)
            return vc
        }else if index >= self.myViewControllers.count {
            let vc = ATReservationListPartController.init(nibName: ATReservationListPartController.className, bundle: Bundle.init(for: ATReservationListPartController.self))
            self.myViewControllers.append(vc)
            //            vc.delegate = self
            return vc
        }else {
            return self.myViewControllers[index]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = self.myViewControllers.firstIndex(of: viewController as! ATReservationListPartController) else {
            return nil
        }
        if viewControllerIndex == NSNotFound {
            return nil
        }else {
            let currentVC : ATReservationListPartController = viewController as! ATReservationListPartController
            let vc : ATReservationListPartController = self.viewControllerAtIndex(index: viewControllerIndex - 1) as! ATReservationListPartController
            
            var monthIndex = currentVC.currentMonth
            var yearIndex = currentVC.currentYear
            monthIndex -= 1
            if monthIndex < 1 {
                monthIndex = 12
                yearIndex -= 1
            }
            
            vc.currentYear = yearIndex
            vc.currentMonth = monthIndex
            return vc
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = self.myViewControllers.firstIndex(of: viewController as! ATReservationListPartController) else {
            return nil
        }
        if viewControllerIndex == NSNotFound {
            return nil
        }else {
            let currentVC : ATReservationListPartController = viewController as! ATReservationListPartController
            let vc : ATReservationListPartController = self.viewControllerAtIndex(index: viewControllerIndex + 1) as! ATReservationListPartController
            var monthIndex = currentVC.currentMonth
            var yearIndex = currentVC.currentYear
            monthIndex += 1
            if monthIndex > 12 {
                monthIndex = 1
                yearIndex += 1
            }
            
            vc.currentYear = yearIndex
            vc.currentMonth = monthIndex
            return vc
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if (completed) {
            let currentVc : ATReservationListPartController = (self.pageViewController.viewControllers![0] as? ATReservationListPartController)!
            let monthIndex = currentVc.currentMonth
            let yearIndex = currentVc.currentYear
            self.navigationItem.title = "予約申請一覧 " + String(yearIndex) + "年" + String(monthIndex) + "月"
            
        }
    }
    
}

