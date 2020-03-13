//
//  LWFilterByCharacterView.swift
//  LiftWork
//
//  Created by VietND on 7/3/18.
//  Copyright © 2018 Trente. All rights reserved.
//

import UIKit
protocol LWFilterByCharacterViewDelegate:NSObjectProtocol {
    func didChangeFilter(filterView:LWFilterByCharacterView,selected:String?)
}
class LWFilterByCharacterView: UIView {
    
    private var beforeSelected:FilterByCharacterButton?
    var delegate:LWFilterByCharacterViewDelegate?
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSubview()
    }
    
    func initSubview() {
        fromNib()
    }
    
    @IBAction func rowTapped(_ sender: FilterByCharacterButton) {
        sender.isSelected = !sender.isSelected
        if self.beforeSelected != nil,self.beforeSelected != sender{
            self.beforeSelected?.isSelected = false
            self.beforeSelected = sender
        }else if sender.isSelected {
            self.beforeSelected = sender
        }else{
            self.beforeSelected = nil
        }
        
        if sender.isSelected{
            self.delegate?.didChangeFilter(filterView: self, selected: rows[sender.tag])
        }else{
            self.delegate?.didChangeFilter(filterView: self, selected: nil)
        }
    }
    
}
