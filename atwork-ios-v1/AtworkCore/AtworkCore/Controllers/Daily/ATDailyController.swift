//
//  ATDailyController.swift
//  AtworkCore
//
//  Created by CuongNV on 10/5/18.
//  Copyright © 2018 Atwork. All rights reserved.
//

import UIKit
import TrenteCoreSwift
import ObjectMapper


public class ATDailyController: UIViewController, MainStoryboard, UIScrollViewDelegate, UIPageViewControllerDelegate, UIPageViewControllerDataSource, ATDailyPartControllerDelegate {
    
    @IBOutlet weak var timeLabel: LWBlackNormalRegularLabel!
    @IBOutlet weak var timeViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var timeView: LCTimeView!
    @IBOutlet weak var dailyPartView: UIView!
    @IBOutlet weak var timeScrollView: UIScrollView!
    @IBOutlet weak var byELV: ATTabBarGrayButtonItem!
    @IBOutlet weak var byList: ATTabBarGrayButtonItem!
    

    
    var pageViewController :UIPageViewController!;
    var myViewControllers = [ATDailyPartController]()
    public var currentDate: Date! = Date()
    
    var lifts = [ATLiftModel]()
    var divNumber: Int! = 3
    var maxPage: Int!
    var currentPageIndex = 0
    var currentVC: ATDailyPartController!
    
    @IBAction func tapELV(_ sender: Any) {
        self.divNumber = (sender as AnyObject).tag
        self.focusTab()
//        if(self.selectELV == 0){
//            divNumber = 1
//
//        }else {
//            divNumber = 3
//        }
        self.currentPageIndex = 0
        addFirstSchedule()
    }
    
    @IBAction func tapPreviousDay(_ sender: UIButton) {
        let tomorrow = Calendar.current.date(byAdding: .day, value: -1, to: self.currentDate)
        self.currentDate = tomorrow
//        loadScheduleDetail()
        self.currentPageIndex = 0
        addFirstSchedule()
    }
    
    @IBAction func tapToDay(_ sender: UIButton) {
        self.currentDate = Date()
//        loadScheduleDetail()
        self.currentPageIndex = 0
        addFirstSchedule()
    }
    
    @IBAction func tapNextDay(_ sender: Any) {
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: self.currentDate)
        self.currentDate = tomorrow
//        loadScheduleDetail()
        self.currentPageIndex = 0
        addFirstSchedule()
    }
    
    func focusTab(){
        self.byELV.changeSelected(isSelected: false)
        self.byList.changeSelected(isSelected:false)
        switch self.divNumber {
        case 1:
            self.byELV.changeSelected(isSelected:true)
            break
        default:
            self.byList.changeSelected(isSelected:true)
            break
        
        }
    }
    
//    var selectELV: Int! = 1
    
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        self.timeLabel.layer.borderWidth = 0.5
        self.timeLabel.layer.borderColor = AT_COLOR_BORDER.cgColor
        self.timeLabel.backgroundColor = AT_COLOR_TITLE_INPUT_PERFORMACE
        
        self.navigationController?.navigationBar.barTintColor = UIColor.orange
        self.navigationController?.navigationBar.isTranslucent = false 
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        
        let rightBarButton = UIBarButtonItem(title: "申請追加", style: .plain, target: self, action: #selector(self.tapRightBarButton))
        rightBarButton.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        
        self.currentDate = Calendar.current.date(byAdding: .hour, value: -HOUR_ADD, to: Date())
        self.currentPageIndex = 0
        self.timeViewHeightConstraint.constant = 24 * SCHEDULE_HEIGHT
       
        self.timeScrollView.delegate = self
        
        self.focusTab()
        
        if(pageViewController == nil){
            self.pageViewController = UIPageViewController.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        }
        self.addChildViewController(self.pageViewController)
        self.dailyPartView.addSubview(self.pageViewController.view)
        self.pageViewController.delegate = self
        self.pageViewController.dataSource = self
        self.pageViewController.didMove(toParentViewController: self)
        
    }
    
    func addFirstSchedule(){
        let firstViewController = ATDailyPartController.init(nibName: ATDailyPartController.className, bundle: Bundle.init(for: ATDailyPartController.self))
        firstViewController.delegate = self
        
        firstViewController.pageIndex = self.currentPageIndex
        firstViewController.divNumber = self.divNumber
        firstViewController.currentDate = self.currentDate
        self.myViewControllers.removeAll()
    
        self.myViewControllers.append(firstViewController)
        self.pageViewController.setViewControllers(self.myViewControllers, direction: .forward, animated: false, completion: nil)
        
    }
    
    
//    func buildLayout(){
    func doneLoadData(date: Date, maxPage: Int){
        self.currentDate = date
        self.maxPage = maxPage
        upDateTitle()
    }
    func doneLoadData1(date: Date, pageIndex: Int) {
        self.currentDate = date
        self.currentPageIndex = pageIndex
        upDateTitle()
    }
    func upDateTitle(){
        var result =  TRFormatUtil.formatDateCustom(date: self.currentDate, format: "yyyy年M月d日")
        switch currentDate.weekday {
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
                break
            }
            self.navigationItem.title = result
    }
    
    @objc func tapRightBarButton(){
        verifyPushViewController()
        

    }
    
    func verifyPushViewController() {
        var params = LWParams.initParamsLW()
        params["siteId"] = ATUserDefaults.getConstructionId()
        params["startDate"] = TRFormatUtil.formatDateCustom(date: self.currentDate, format: "yyyy/MM/dd")
        
        AlamofireManager.shared.request(APIRouter.get(url: API.AT_URL_SCHEDULE_WARNING, params: params, identifier: nil)) { (response) in
            //            self.view.activityIndicatorView.stopAnimating()
            if response != nil{
                if let result : String = response?["status"] as? String{
                    if result.elementsEqual("OK"){
                        if let resultCode : Bool = response?["hasReturnCode"] as? Bool{
                            if resultCode {
                                if var messages: String = response?["messages"] as? String{
                                    messages = messages.replacingOccurrences(of: "<br>", with: "\n")
                                    if !(ATUserDefaults.getCustomerUserFlag().elementsEqual("1")){
                                        self.confirmMessages(messages: messages, funcOK: self.gotoScheduleNew)
                                    }else {
                                        self.showMessage(messages: messages)
                                    }
                                }else {
                                    self.gotoScheduleNew()
                                }
                            }else {
                                self.gotoScheduleNew()
                            }
                        }else{
                            if var messages: String = response?["messages"] as? String{
                                messages = messages.replacingOccurrences(of: "<br>", with: "\n")
                                self.showMessage(messages: messages)
                            }
                        }
                    }
                }
            }
        }
    }
    
    public func gotoScheduleNew(){
        let vc = ATRequestEditController.init(nibName: ATRequestEditController.className, bundle: Bundle.init(for: ATRequestEditController.self))
        vc.currentDate = self.currentDate
        self.navigationController?.pushViewController(vc, animated: false)
    }
    override public func viewDidAppear(_ animated: Bool) {
        self.timeScrollView.contentOffset = dailyScrollOffset
        
    }
    
    override public func viewWillAppear(_ animated: Bool) {
            self.navigationController?.isNavigationBarHidden = false
            let dateString = ATUserDefaults.getDayForDaily()
            if dateString.count > 0 {
                self.currentDate = TRDateUtil.makeDateCustom(date: dateString, format: "yyyy/MM/dd")
                ATUserDefaults.setDayForDaily(val: "")
            }
        dailyScrollOffset.y =  2*SCHEDULE_HEIGHT
        self.timeScrollView.setContentOffset(dailyScrollOffset, animated: false)
        addFirstSchedule()
        
    }
    
    func updateScrollViewOfset(point: CGPoint){
        
        self.timeScrollView.setContentOffset(point, animated: false)
    }
    
    override public func viewDidLayoutSubviews() {                                                                           
        super.viewDidLayoutSubviews()
        self.pageViewController.view.frame = CGRect.init(x: 0, y: 0, width: self.dailyPartView.frame.width, height: self.dailyPartView.frame.height);
        self.view.layoutIfNeeded()
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //    Pageview
    
    //delegate
    
    func scrollWithPosition(position: CGPoint) {
        self.timeScrollView.setContentOffset(position, animated: false)
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollContentSizeHeight = scrollView.contentSize.height;
        let scrollEndOfScreen = scrollView.contentOffset.y +  scrollView.frame.size.height;
        
        if(scrollView.isDragging || scrollView.contentOffset.y < 0 || ( scrollContentSizeHeight != 0 && ( scrollEndOfScreen > scrollContentSizeHeight))){
            if self.timeScrollView.tag == 1{
                dailyScrollOffset = CGPoint.init(x: 0, y:  scrollView.contentOffset.y)
                let vc : ATDailyPartController = self.pageViewController.viewControllers?[0] as! ATDailyPartController
                vc.scrollWithPosition(position: dailyScrollOffset)
            }
        }
    }

    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollView.tag = 0
    }
    
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        scrollView.tag = 1
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = self.myViewControllers.firstIndex(of: viewController as! ATDailyPartController) else {
            return nil
        }
        if viewControllerIndex == NSNotFound {
            return nil
        }
        if(self.currentPageIndex - 1 < 0){
            return nil
        }
        let vc: ATDailyPartController = self.getViewControllerAtIndex(index: viewControllerIndex - 1)
//        vc = self.myViewControllers[viewControllerIndex - 1]
        vc.pageIndex = self.currentPageIndex - 1
        vc.divNumber = self.divNumber
        vc.currentDate = self.currentDate
        return vc
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = self.myViewControllers.firstIndex(of: viewController as! ATDailyPartController) else {
            return nil
        }
        if viewControllerIndex == NSNotFound {
            return nil
        }
        if(self.currentPageIndex + 1 >= self.maxPage){
            return nil
        }
        let vc: ATDailyPartController = self.getViewControllerAtIndex(index: viewControllerIndex + 1)
//            if viewControllerIndex + 1 >= myViewControllers.count{
//                vc = ATDailyPartController.init(nibName: ATDailyPartController.className, bundle: Bundle.init(for: ATDailyPartController.self))
//                self.myViewControllers.append(vc)
//                vc.delegate = self
//
//            }else {
//                vc = self.myViewControllers[viewControllerIndex + 1]
//            }
        vc.pageIndex = currentPageIndex + 1
        vc.divNumber = self.divNumber
        vc.currentDate = self.currentDate
        return vc
        
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            if let vc = pageViewController.viewControllers![0] as? ATDailyPartController {
                vc.scrollWithPosition(position: dailyScrollOffset)
                
                 self.doneLoadData1(date: vc.currentDate, pageIndex: vc.pageIndex)
            }
        }
        
    }
    
    
    func getViewControllerAtIndex(index: Int) -> ATDailyPartController {
        if(index < 0){
            let vc = ATDailyPartController.init(nibName: ATDailyPartController.className, bundle: Bundle.init(for: ATDailyPartController.self))
            self.myViewControllers.insert(vc, at: 0)
            vc.delegate = self
            return vc
        }else if index >= self.myViewControllers.count {
            let vc = ATDailyPartController.init(nibName: ATDailyPartController.className, bundle: Bundle.init(for: ATDailyPartController.self))
            self.myViewControllers.append(vc)
            vc.delegate = self
            return vc
        }else {
            let vc: ATDailyPartController = self.myViewControllers[index]
            return vc
        }
    }
}
