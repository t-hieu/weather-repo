//
//  DailyController.swift
//  LW_Customer
//
//  Created by CuongNV on 9/12/18.
//  Copyright © 2018 Trente. All rights reserved.
//

import UIKit
import TrenteCoreSwift
import AtworkCore


class DailyController: UIViewController, MainStoryboard, UIScrollViewDelegate {

    @IBOutlet weak var timeViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var timeView: LCTimeView!
    @IBOutlet weak var dailyPartView: LCDailyPartView!
    @IBOutlet weak var dailyPartViewHeightContraint: NSLayoutConstraint!
    @IBOutlet weak var timeScrollView: UIScrollView!
    @IBOutlet weak var dailyPartScrollView: UIScrollView!
    var pageViewController :UIPageViewController!;
    
    var timerTests = [TimerTestModel]()
    
//    @IBOutlet weak var dailyContent: LCDailyContentView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.timeViewHeightConstraint.constant = 24 * SCHEDULE_HEIGHT
        self.dailyPartViewHeightContraint.constant = self.timeViewHeightConstraint.constant
        
        self.dailyPartScrollView.delegate = self
        self.timeScrollView.delegate = self
        

    }
    
    override func viewDidAppear(_ animated: Bool) {
    
        
        let test1 = TimerTestModel.init()
        test1.setDefault(startimeH: 5, starttimeM: 25, endtimeH: 7, endtimeM: 35, title: "test1")
        self.timerTests.append(test1)
        let test2 = TimerTestModel.init()
        test2.setDefault(startimeH: 4, starttimeM: 25, endtimeH: 6, endtimeM: 35, title: "test2")
        self.timerTests.append(test2)
        let test3 = TimerTestModel.init()
        test3.setDefault(startimeH: 6, starttimeM: 25, endtimeH: 8, endtimeM: 35, title: "test3")
        self.timerTests.append(test3)
        let test4 = TimerTestModel.init()
        test4.setDefault(startimeH: 2, starttimeM: 25, endtimeH: 9, endtimeM: 35, title: "test4")
        self.timerTests.append(test4)
        
        let test5 = TimerTestModel.init()
        test5.setDefault(startimeH: 1, starttimeM: 25, endtimeH: 2, endtimeM: 25, title: "test5")
        self.timerTests.append(test5)
        
        
        self.updateLocalListTimer()
        
//        for test in self.timerTests {
//            self.dailyPartView.addPerformance(timerTest: test)
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if LWUserDefaults.getConstructionId().isEmpty {
            let vc = SelectContructionController.init(nibName: SelectContructionController.className, bundle: Bundle.init(for: SelectContructionController.self))
            vc.index = 1
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    Pageview
    
    //delegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollContentSizeHeight = scrollView.contentSize.height;
        let scrollEndOfScreen = scrollView.contentOffset.y +  scrollView.frame.size.height;
        
        if(scrollView.isDragging || scrollView.contentOffset.y < 0 || ( scrollContentSizeHeight != 0 && ( scrollEndOfScreen > scrollContentSizeHeight))){
            if self.dailyPartScrollView.tag == 1{
                self.timeScrollView.setContentOffset(CGPoint.init(x: 0, y:  scrollView.contentOffset.y), animated: false)
            }else if self.timeScrollView.tag == 1{
                self.dailyPartScrollView.setContentOffset(CGPoint.init(x: 0, y:  scrollView.contentOffset.y), animated: false)
            }

        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollView.tag = 0
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        scrollView.tag = 1
    }
    
    func updateLocalListTimer(){
        for index in 0 ..< self.timerTests.count {
            let timer = self.timerTests[index]
            if timer.numberSameCurrentTime == 0{
                var timers = [TimerTestModel]()
                timers.append(timer)
                var startTime = timer.startTimeHour * 60 + timer.startTimeMin
                var endTime = timer.endTimeHour * 60 + timer.endTimeMin
                for index1 in index + 1 ..< self.timerTests.count {
                    let timer1 = self.timerTests[index1]
                    let startTime1 = timer1.startTimeHour * 60 + timer1.startTimeMin
                    let endTime1 = timer1.endTimeHour * 60 + timer1.endTimeMin
                    if(timer1.numberSameCurrentTime == 0 && self.isContainTime(start1: startTime, end1: endTime, start2: startTime1, end2: endTime1)){
                        startTime = self.getMin(int1: startTime, int2: startTime1)
                        endTime = self.getMax(int1: endTime, int2: endTime1)
                        timers.append(timer1)
                    }
                }
                
                for timer2 in timers {
                    timer2.numberSameCurrentTime = timers.count
                    timer2.currentIndex = timers.firstIndex(of: timer2)
                }
 
            }
        }
    }
    
    func isContainTime(start1: Int, end1: Int, start2: Int, end2: Int) -> Bool {
        if(start1 <= start2 && start2 <= end1)||(start1 <= end2 && end2 <= end1) || (start1 >= start2 && end1 <= end2){
            return true
        }
        return false
    }
    
    func getMin(int1: Int, int2: Int) -> Int {
        if(int1 < int2){ return int1}
        return int2
    }
    
    func getMax(int1: Int, int2: Int) -> Int {
        if(int1 > int2) {return int1}
        return int2
    }

}
