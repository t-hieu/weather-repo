//
//  NumberPadView.swift
//  LiftWork
//
//  Created by CuongNV on 6/14/18.
//  Copyright © 2018 Trente. All rights reserved.
//

import UIKit
protocol KeyboardDelegate: class {
    func changeTextKeyBoard(text: String)
    func doneEditing()
}

class NumberPadView: UIView {
    @IBOutlet var contentView: UIView!
    
    var delegate: KeyboardDelegate?
    var numberString: String? = ""
    var maxCharacter: Int? = 2
    
    public init(){
        super.init(frame: CGRect.init())
        self.initialization()
    }
    
    public override init(frame: CGRect){
        super.init(frame: frame)
        self.initialization()
    }
    public required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        self.initialization()
    }
    
    func initialization() {
        Bundle.main.loadNibNamed("NumberPadView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        self.backgroundColor = LW_COLOR_TITLE_INPUT_PERFORMACE
    }
    
    
    public func hide() {
        self.removeFromSuperview()
    }
    
    @IBAction func keyTapped(sender: UIButton) {
//        self.delegate?.keyWasTapped(character: sender.titleLabel!.text!) // could alternatively send a
        let lenght = self.numberString?.count
        if( lenght! < self.maxCharacter!){
            self.numberString?.append((sender.titleLabel?.text)!)
            self.delegate?.changeTextKeyBoard(text: self.numberString!)
        }
    }
    
    @IBAction func deleteTapped(_ sender: Any) {
        if(!(self.numberString?.isEmpty)!){
            self.numberString?.removeLast()
        }
        self.delegate?.changeTextKeyBoard(text: self.numberString!)
    }
    
//    @IBAction func NorTapped(_ sender: Any) {
//        if(!(self.numberString?.isEmpty)! && (self.numberString?.starts(with: "-"))!){
//            self.numberString?.removeFirst()
//        }else {
//            let addString = self.numberString
//           self.numberString = "-"
//            self.numberString?.append(addString!)
////            self.numberString?.insert("-", at: (self.numberString?.startIndex)!)
//        }
//        self.delegate?.changeTextKeyBoard(text: self.numberString!)
//    }
    
    @IBAction func doneTap(_ sender: Any) {
        self.delegate?.doneEditing()
    }
}

