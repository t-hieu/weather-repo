//
//  LWView.swift
//  AtworkCore
//
//  Created by CuongNV on 11/9/18.
//  Copyright © 2018 Atwork. All rights reserved.
//

import UIKit

//class BaseView:UIView{
//    func startAnimating(){
//        if nvActivityIndicatorView == nil{
//            nvActivityIndicatorView = NVActivityIndicatorView.init(frame: (KEY_WINDOW?.frame)!)
//        }
//        nvActivityIndicatorView?.startAnimating()
//    }
//    func stopAnimating(){
//        if nvActivityIndicatorView != nil, nvActivityIndicatorView!.isAnimating {
//            nvActivityIndicatorView?.stopAnimating()
//        }
//    }
//}
class DarkBlueView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    fileprivate func commonInit() {
        self.backgroundColor = AT_COLOR_BLUE_DARK
    }
    
}

class BorderView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    fileprivate func commonInit() {
        self.layer.borderColor = AT_COLOR_BORDER.cgColor
        self.layer.borderWidth = 0.5
    }
    
}

class ATDarkBorderView: BorderView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    fileprivate override func commonInit() {
        super.commonInit()
        self.backgroundColor = AT_COLOR_TITLE_INPUT_PERFORMACE
    }
    
}

class ATViewLine: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    fileprivate func commonInit() {
        self.backgroundColor = AT_COLOR_BORDER
        
    }
    
}

