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
    @IBOutlet var contentView: UIView!
    
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
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "LWFilterByCharacterView", bundle: bundle)
        self.contentView = nib.instantiate(withOwner: self, options: nil).first as? UIView
        addSubview(contentView)
        //        Bundle.main.loadNibNamed("LWRowCharacter", owner: self, options: nil)
        //        addSubview(contentView)
        contentView.frame = bounds
    }
    
    @IBAction func rowTapped(_ sender: FilterByCharacterButton) {
        sender.updateButtonView(isSelected: !sender.isSelectedButton)
        if self.beforeSelected != nil,self.beforeSelected != sender{
            self.beforeSelected?.updateButtonView(isSelected: false)
            self.beforeSelected = sender
        }else if sender.isSelectedButton {
            self.beforeSelected = sender
        }else{
            self.beforeSelected = nil
        }
        
        if sender.isSelectedButton{
            self.delegate?.didChangeFilter(filterView: self, selected: rows[sender.tag])
        }else{
            self.delegate?.didChangeFilter(filterView: self, selected: nil)
        }
    }
    
}
