//
//  LWLabel.swift
//  LiftWork
//
//  Created by VietND on 6/7/18.
//  Copyright © 2018 Trente. All rights reserved.
//

import UIKit
import TrenteCoreSwift

public class LWLabel: TRLabel {
//    public override func commonInit() {
//        super.commonInit()
//    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
//    public required init(frame: CGRect) {
//        super.init(frame: frame)
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
    
}

public class LWNormalRegularLabel:LWLabel{
    override public func awakeFromNib() {
        super.awakeFromNib()
        self.customFont = UIFont.regularFont(size: AT_FONT_SIZE_NORMAL)
    }
}

public class LWBlueNormalLabel:LWLabel{
    override public func awakeFromNib() {
        super.awakeFromNib()
        self.customFont = UIFont.regularFont(size: AT_FONT_SIZE_NORMAL)
        self.customTextColor = UIColor.blue
        
    }
}

public class LWnormalBoldLabel:LWLabel{
    override public func awakeFromNib() {
        super.awakeFromNib()
        self.customFont = UIFont.boldFont(size: AT_FONT_SIZE_NORMAL)
        
    }
}

class LWBlueNormalBoldLabel:LWnormalBoldLabel{
    override func awakeFromNib() {
        super.awakeFromNib()
        self.customTextColor = AT_COLOR_BLUE_LIGHT
        
    }
}

public class LWBlackNormalRegularLabel:UILabel{
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.textColor = AT_COLOR_BLACK
        self.font = UIFont.regularFont(size: AT_FONT_SIZE_NORMAL)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.textColor = AT_COLOR_BLACK
        self.font = UIFont.regularFont(size: AT_FONT_SIZE_NORMAL)
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        self.textColor = AT_COLOR_BLACK
        self.font = UIFont.regularFont(size: AT_FONT_SIZE_NORMAL)
    }
    
}

public class LWBlackNormalRegularCenterLabel:UILabel{
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.textColor = AT_COLOR_BLACK
        self.font = UIFont.regularFont(size: AT_FONT_SIZE_NORMAL)
        self.textAlignment = .center
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.textColor = AT_COLOR_BLACK
        self.font = UIFont.regularFont(size: AT_FONT_SIZE_NORMAL)
        self.textAlignment = .center
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        self.textColor = AT_COLOR_BLACK
        self.font = UIFont.regularFont(size: AT_FONT_SIZE_NORMAL)
        self.textAlignment = .center
    }
    
}

public class LWBlackNormalBoldLabel:UILabel{
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.textColor = AT_COLOR_BLACK
        self.font = UIFont.boldFont(size: AT_FONT_SIZE_NORMAL)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.textColor = AT_COLOR_BLACK
        self.font = UIFont.boldFont(size: AT_FONT_SIZE_NORMAL)
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        self.textColor = AT_COLOR_BLACK
        self.font = UIFont.boldFont(size: AT_FONT_SIZE_NORMAL)
    }
}


public class LWBigBoldLabel:LWLabel{
    override public func awakeFromNib() {
        super.awakeFromNib()
        self.customFont = UIFont.boldFont(size: AT_FONT_SIZE_BIG)
    }
}

public class ATScheduleLabel: UILabel{
    public var isDraw: Bool! = false
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.font = UIFont.systemFont(ofSize: SCHEDULE_FONT_SIZE, weight: UIFont.Weight.regular)
        self.textAlignment = NSTextAlignment.center
        self.lineBreakMode = NSLineBreakMode.byWordWrapping
        self.numberOfLines = 0
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.black.cgColor
        
    }
    
    public func initDataShedule(idSchedule: Int, labelTitle: String, titleColor: UIColor, bgColor: UIColor, isDrawLine: Bool){
        self.text = labelTitle
        self.textColor = titleColor
        self.backgroundColor = bgColor
        self.tag = idSchedule
        self.isDraw = isDrawLine
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        if isDraw{
            let context = UIGraphicsGetCurrentContext()
            context!.setLineWidth(0.5)
            context!.setStrokeColor(self.textColor.cgColor)
//            context?.addLines(between: [CGPoint.init(x: 0, y: 0), CGPoint.init(x: 100, y: 100)])
            
            var pointXBegins = [CGFloat]()
            var pointYBegins = [CGFloat]()
            var pointXEnds = [CGFloat]()
            var pointYEnds = [CGFloat]()
            (pointXBegins, pointYBegins, pointXEnds, pointYEnds) = getPointsDrawLineInLabel(xEnd: frame.width, yEnd: frame.height)
            for index in 0..<pointXBegins.count {
                context?.addLines(between: [CGPoint(x: pointXBegins[index], y: pointYBegins[index]), CGPoint(x: pointXEnds[index], y: pointYEnds[index])])
            }
            context!.strokePath()
        }
    }
    
    func getPointsDrawLineInLabel(xEnd: CGFloat, yEnd: CGFloat) -> (pointXBegins: [CGFloat], pointYBegins: [CGFloat], pointXEnds: [CGFloat], pointYEnds: [CGFloat]){
        
        var pointXBegins = [CGFloat]()
        var pointYBegins = [CGFloat]()
        var pointXEnds = [CGFloat]()
        var pointYEnds = [CGFloat]()
        
        var pointBeginX: CGFloat = 0
        var pointBeginY: CGFloat = 0
        var pointEndX: CGFloat = 0
        var pointEndY: CGFloat = 0
        
        repeat {
            pointXBegins.append(pointBeginX)
            pointYBegins.append(pointBeginY)
            pointXEnds.append(pointEndX)
            pointYEnds.append(pointEndY)
            if pointBeginY == yEnd {
                pointBeginX += 30
            }else {
                if pointBeginY + 30 < yEnd {
                    pointBeginY = pointBeginY + 30
                }else {
                    pointBeginX += pointBeginY + 30 - yEnd
                    pointBeginY = yEnd
                }
            }
            
            if pointEndX == xEnd {
                pointEndY += 30
            }else {
                if pointEndX + 30 < xEnd {
                    pointEndX = pointEndX + 30
                }else {
                    pointEndY += pointEndX + 30 - xEnd
                    pointEndX = xEnd
                }
            }
            
        } while pointBeginX <= xEnd && pointEndY <= yEnd
        
        return (pointXBegins, pointYBegins, pointXEnds, pointYEnds)
    }
    
}

