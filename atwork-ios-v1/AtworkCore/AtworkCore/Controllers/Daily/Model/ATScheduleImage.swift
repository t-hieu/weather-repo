//
//  ATScheduleImage.swift
//  AtworkCore
//
//  Created by CuongNV on 10/17/18.
//  Copyright © 2018 Atwork. All rights reserved.
//

import UIKit

protocol ATScheduleImageDelegate {
    func tapATScheduleImage(idSchedule: Int)
}
class ATScheduleImage {
    var label: UILabel!
    var delegate: ATScheduleImageDelegate!
//    override init() {
//        super.init()
//    }
    
    func fillData(delegate: ATScheduleImageDelegate, idSchedule: Int,target: Any?, frame: CGRect, labelTitle: String, color: UIColor){
        self.delegate = delegate
        label = UILabel.init(frame: frame);
        label.font = UIFont.systemFont(ofSize: SCHEDULE_FONT_SIZE, weight: UIFont.Weight.regular)
        label.textAlignment = NSTextAlignment.center
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.numberOfLines = 0
        label.text = labelTitle
        label.isUserInteractionEnabled = false
        label.layer.borderWidth = 0.5
        label.layer.borderColor = UIColor.black.cgColor
        label.backgroundColor = color
        label.tag = idSchedule
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapFunction(sender:)))
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(tap)
        //        view.addSubview(label)
//        return label
    }
    
    @objc func tapFunction(sender:UITapGestureRecognizer) {
        self.delegate.tapATScheduleImage(idSchedule: self.label.tag)
    }

}
