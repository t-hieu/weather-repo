//
//  ATDailyPartController.swift
//  AtworkCore
//
//  Created by CuongNV on 10/5/18.
//  Copyright © 2018 Atwork. All rights reserved.
//

import UIKit
import TrenteCoreSwift
import ObjectMapper

protocol ATDailyPartControllerDelegate {
    func scrollWithPosition(position: CGPoint)
    func doneLoadData(date: Date, maxPage: Int)
//    func getScrollPosition() -> CGPoint
    
}
class ATDailyPartController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var dailyPartView: UIView!
    @IBOutlet weak var dailyPartViewHeightContraint: NSLayoutConstraint!
    @IBOutlet weak var dailyPartScrollView: UIScrollView!
//    @IBOutlet weak var labelTitle: LWBlackNormalRegularLabel!
    @IBOutlet weak var viewTitle: UIView!
    
//    var scheduleTimes = [ATScheduleDrawModel]()
    var delegate: ATDailyPartControllerDelegate!
//    var beginPosition: CGPoint!
    var lifts = [ATLiftModel]()
    var schedules = [ATScheduleModel]()
    var breakTimes = [SiteBreakTime]()
    var divNumber: Int!
    var pageIndex: Int!
    var maxPage: Int!
    var widthOfLift: CGFloat! = 0
    var currentDate: Date!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dailyPartScrollView.delegate = self
        
        self.viewTitle.layer.borderWidth = 0.5
        self.viewTitle.layer.borderColor = AT_COLOR_BORDER.cgColor
        self.viewTitle.backgroundColor = AT_COLOR_TITLE_INPUT_PERFORMACE
        
        self.view.layer.borderWidth = 0.5
        self.view.layer.borderColor = AT_COLOR_BORDER.cgColor
        
//        self.scrollWithPosition(position: dailyScrollOffset)
        self.dailyPartScrollView.contentOffset = CGPoint.init(x: 0, y: 200)
    }
    
    func loadScheduleDetail(){
        var params = LWParams.initParamsLW()
        //        params["tableId"] = self.tableId?.description
        params["siteId"] = ATUserDefaults.getConstructionId()
        params["startTime"] = TRFormatUtil.formatDateCustom(date: self.currentDate, format: "yyyy/MM/dd") + " 00:00"
        params["endTime"] = TRFormatUtil.formatDateCustom(date: self.currentDate, format: "yyyy/MM/dd") + " 23:59"
        if ATUserDefaults.getCustomerUserFlag().elementsEqual("1"){
            params["customerId"] = ATUserDefaults.getCustomerId()
        }else {
            params["customerId"] = "1"
        }
        params["currentDate"] = TRFormatUtil.formatDateCustom(date: Date(), format: "MM/dd/yyyy HH:mm")
        self.view.activityIndicatorView.startAnimating()
        AlamofireManager.shared.request(APIRouter.get(url: API.LW_URL_LIFTING_LIST_SCHEDULE, params: params, identifier: nil)) { (response) in
            if response != nil{
                self.view.activityIndicatorView.stopAnimating()
                guard let construction : ATConstructionModel = Mapper<ATConstructionModel>().map(JSONObject: response!["constructionSite"] ),let lifts: [ATLiftModel] = Mapper<ATLiftModel>().mapArray(JSONObject: response!["lifts"] ),
                    let dailies: [ATDailyModel] = Mapper<ATDailyModel>().mapArray(JSONObject: response!["dailies"] )
                    else{
                        return
                }
                
                
                self.breakTimes = construction.siteBreakTimes
                
                if(dailies.count > 0){
                    self.schedules = dailies[0].schedules
                }
                
                let liftsTotal = self.updateScheduleInLifts(lifts: lifts)
                self.maxPage = liftsTotal.count / self.divNumber
                if(liftsTotal.count % self.divNumber > 0){
                    self.maxPage += 1
                }
                
                if self.pageIndex >= self.maxPage {
                    self.pageIndex = 0
                }
                self.lifts = self.getLiftsWithNum(liftsTotal: liftsTotal, index: self.pageIndex, number: self.divNumber)
//                self.buildLayout()
                self.delegate.doneLoadData(date: self.currentDate, maxPage: self.maxPage)
//                self.addFirstSchedule()
                self.widthOfLift = self.view.frame.size.width / CGFloat(self.divNumber)
                self.removeAllSubViewInPartView()
                self.drawLineAll()
                self.drawSchedule()
//                self.removeAllSubViewInPartView()
            }
        }
    }
    
    func updateScheduleInLifts(lifts: [ATLiftModel]) -> [ATLiftModel]{
        var liftsResult = [ATLiftModel]()
        for lift in lifts {
            for schedule in self.schedules{
                if(schedule.liftIds.contains(lift.liftId!)){
                    lift.schedules.append(schedule)
                }
            }
        }
        
        let liftEvent = ATLiftModel.init()
        liftEvent.liftName = "行事"
        liftEvent.liftId = -1
        for schedule in self.schedules {
            if schedule.scheduleType == 2 {
                //                let scheduleCopy: ATScheduleModel = ATScheduleModel.init()
                //                scheduleCopy.copySchedule(scheduleModel: schedule)
                schedule.scheduleTextColor = "#ffffff"
                schedule.scheduleBGColor = "#000000"
                liftEvent.schedules.append(schedule)
            }
        }
        liftsResult.append(contentsOf: lifts)
        liftsResult.append(liftEvent)
        
//        self.maxPage = self.lifts.count / self.divNumber
//        if(self.lifts.count % self.divNumber > 0){
//            self.maxPage += 1
//        }
        return liftsResult
    }
    
    public func getLiftsWithNum(liftsTotal: [ATLiftModel],index: Int, number: Int) -> [ATLiftModel] {
        var lifts = [ATLiftModel]()
        if index * number >= liftsTotal.count {
            return lifts
        }
        for temp in 0..<number{
            if index*number + temp < liftsTotal.count {
                lifts.append(liftsTotal[index*number + temp])
            }
        }
        return lifts
    }
    
    func drawLineAll(){
        for index in 0..<48 {
            let timeView = self.addLine(frame: CGRect.init(x: -20, y: CGFloat(index) * SCHEDULE_HEIGHT/2, width: self.view.frame.size.width + 200, height: SCHEDULE_HEIGHT/2), timeLabel: "\(index)")
            self.dailyPartView.addSubview(timeView)
        }
        
        for index in 0..<self.divNumber {
            let line = self.addLine(frame: CGRect.init(x: widthOfLift * CGFloat(index + 1), y: -20, width: 1, height: self.view.frame.height + 40), timeLabel: "")
            self.view.addSubview(line)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.scrollWithPosition(position: dailyScrollOffset)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        loadScheduleDetail()
    }
    
    public func drawSchedule(){
        for index in 0..<lifts.count{
            var scheduleTimes = [ATScheduleDrawModel]()
            for schedule in lifts[index].schedules {
                let scheduletime = ATScheduleDrawModel.init()
                scheduletime.setSchedule(schedule: schedule)
                scheduleTimes.append(scheduletime)
            }
//            scheduleTimes = scheduleTimes.sorted(by: { ($0.startTimeHour * 60 + $0.startTimeMin) < ($1.startTimeHour * 60 + $1.startTimeMin) })
            self.updateLocalListSchedule(scheduleTimes: scheduleTimes)
            let xbegin = CGFloat(index) * widthOfLift
            
            drawBreakTimes(xbegin: xbegin)
//            print(self.widthOfLift)
            let label = self.getTitleLabel(frame: CGRect.init(x: xbegin + 10, y: 0, width: self.widthOfLift - 20, height: self.viewTitle.frame.height), labelTitle: lifts[index].liftName!)
            self.viewTitle.addSubview(label)
            label.textAlignment = .center
            
            for schedule in scheduleTimes {
                self.addPerformance(scheduleTime: schedule, xbegin: xbegin)
            }
        }
        
        self.scrollWithPosition(position: dailyScrollOffset)

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        removeAllSubViewInPartView()
    }
    
    func removeAllSubViewInPartView(){
        for view in self.dailyPartView.subviews {
            view.removeFromSuperview()
        }
        
        for view in self.viewTitle.subviews {
            view.removeFromSuperview()
        }
    }
    
    override public func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.dailyPartViewHeightContraint.constant = 24 * SCHEDULE_HEIGHT
        self.view.layoutIfNeeded()
    }
    
    public func scrollWithPosition(position: CGPoint){
        self.dailyPartScrollView.contentOffset = position
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollContentSizeHeight = scrollView.contentSize.height;
        let scrollEndOfScreen = scrollView.contentOffset.y +  scrollView.frame.size.height;

        if(scrollView.isDragging || scrollView.contentOffset.y < 0 || ( scrollContentSizeHeight != 0 && ( scrollEndOfScreen > scrollContentSizeHeight))){
            
            if self.dailyPartScrollView.tag == 1{
                dailyScrollOffset = CGPoint.init(x: 0, y:  scrollView.contentOffset.y)
                self.delegate.scrollWithPosition(position: dailyScrollOffset)
            }
        }
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollView.tag = 0
    }

    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        scrollView.tag = 1
    }
    
    func updateLocalListSchedule(scheduleTimes: [ATScheduleDrawModel]){
        var scheduleTimeSort = scheduleTimes.sorted(by: { ($0.startTimeHour < $1.startTimeHour || ($0.startTimeHour == $1.startTimeHour && $0.startTimeMin < $1.startTimeMin)) })
//        var groupSchedule = [ATScheduleDrawGroupModel]()
        for index in 0 ..< scheduleTimeSort.count {
            let schedule = scheduleTimeSort[index]
            if schedule.numberSameCurrentTime == 0{
                var timers = [ATScheduleDrawModel]()
                timers.append(schedule)
                var startTime = schedule.startTimeHour * 60 + schedule.startTimeMin
                var endTime = schedule.endTimeHour * 60 + schedule.endTimeMin
                for index1 in index + 1 ..< scheduleTimeSort.count {
                    let timer1 = scheduleTimeSort[index1]
                    if(timer1.numberSameCurrentTime == 0){
                        
                        let startTime1 = timer1.startTimeHour * 60 + timer1.startTimeMin
                        let endTime1 = timer1.endTimeHour * 60 + timer1.endTimeMin
                        if(self.isContainTime(start1: startTime, end1: endTime, start2: startTime1, end2: endTime1)){
                            startTime = self.getMin(int1: startTime, int2: startTime1)
                            endTime = self.getMax(int1: endTime, int2: endTime1)
                            timers.append(timer1)
                        }
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
        if(start1 <= start2 && start2 < end1)||(start1 < end2 && end2 <= end1) || (start1 >= start2 && end1 <= end2){
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
    
    func addLine(frame: CGRect, timeLabel: String) -> UIView {
        let view = UIView.init(frame: frame);
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.init(hex:"D8D8D8").cgColor
        return view
    }
    
    func addPerformanceView(idSchedule: Int, frame: CGRect, labelTitle: String, titleColor: UIColor, color: UIColor, isDrawLine: Bool) -> ATScheduleLabel{
        let label = ATScheduleLabel.init(frame: frame);
        label.initDataShedule(idSchedule: idSchedule, labelTitle: labelTitle, titleColor: titleColor, bgColor: color, isDrawLine: isDrawLine)
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapFunction(sender:)))
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(tap)
        
        return label
    }
    
    func addBreakTimeView(frame: CGRect, color: UIColor) -> UILabel{
        let label = UILabel.init(frame: frame);
        label.font = UIFont.systemFont(ofSize: SCHEDULE_FONT_SIZE, weight: UIFont.Weight.regular)
        label.layer.borderWidth = 0
        label.backgroundColor = color
        return label
    }
    
    func getTitleLabel(frame: CGRect, labelTitle: String) -> UILabel{
        let label = UILabel.init(frame: frame);
        label.font = UIFont.systemFont(ofSize: SCHEDULE_FONT_SIZE, weight: UIFont.Weight.regular)
        label.numberOfLines = 1
        label.text = labelTitle
        label.isUserInteractionEnabled = false
        label.textAlignment = NSTextAlignment.center
        return label
    }
    
    @objc func tapFunction(sender:UITapGestureRecognizer) {
        
        let searchlbl:UILabel = (sender.view as! UILabel) // Type cast it with the class for which you have added gesture
        if searchlbl.tag > 0 {
            let vc = ATRequestEditController.init(nibName: ATRequestEditController.className, bundle: Bundle.init(for: ATRequestEditController.self))
            vc.tableId = searchlbl.tag
            vc.currentDate = self.currentDate
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }
    
    func drawBreakTimes(xbegin: CGFloat){
        for breaktime in self.breakTimes {
            let width = self.widthOfLift
            let start = breaktime.breakStartTime.components(separatedBy: ":")
            var startTimeHour = 0
            var startTimeMin = 0
            var endTimeHour = 0
            var endTimeMin = 0
            
            if(start.count > 1){
                startTimeHour = Int(start[0])! - HOUR_ADD
                startTimeMin = Int(start[1])!
            }
            
            let end = breaktime.breakEndTime.components(separatedBy: ":")
            if(end.count > 1){
                endTimeHour = Int(end[0])! - HOUR_ADD
                endTimeMin = Int(end[1])!
            }
            let y = CGFloat(startTimeHour * 60 + startTimeMin)/60 * SCHEDULE_HEIGHT
            let height = CGFloat((endTimeHour - startTimeHour) * 60 +  endTimeMin - startTimeMin ) / 60 * SCHEDULE_HEIGHT
            let text = addBreakTimeView(frame: CGRect.init(x: xbegin, y: y, width: width!, height: height), color: TRColorUtil.getColor4Hexa(hexString: "#E7E7E7"))
            self.dailyPartView.addSubview(text)
        }
    }
    
    func addPerformance(scheduleTime: ATScheduleDrawModel, xbegin: CGFloat){
        let width: CGFloat = self.widthOfLift / CGFloat(scheduleTime.numberSameCurrentTime)
        let x: CGFloat = CGFloat(scheduleTime.currentIndex) * width + xbegin + 0.3
        let y: CGFloat = CGFloat(scheduleTime.startTimeHour * 60 + scheduleTime.startTimeMin)/60 * SCHEDULE_HEIGHT + 0.3
        let height: CGFloat = CGFloat((scheduleTime.endTimeHour - scheduleTime.startTimeHour) * 60 +  scheduleTime.endTimeMin - scheduleTime.startTimeMin ) / 60 * SCHEDULE_HEIGHT - 0.6
        var isDrawLine = false
        if scheduleTime.schedule.status < 2 {
            isDrawLine = true
        }
        let text = addPerformanceView(idSchedule: scheduleTime.schedule.tableId, frame: CGRect.init(x: x, y: y, width: width - 0.6, height: height), labelTitle: scheduleTime.schedule.customer.customerName!, titleColor: TRColorUtil.getColor4Hexa(hexString: scheduleTime.schedule.scheduleTextColor), color: TRColorUtil.getColor4Hexa(hexString: scheduleTime.schedule.scheduleBGColor), isDrawLine: isDrawLine)
        self.dailyPartView.addSubview(text)
    }

}
