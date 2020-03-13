//
//  UIFont+extensions.swift
//  TrenteCoreSwift
//
//  Created by VietND on 6/6/18.
//  Copyright © 2018 Trente. All rights reserved.
//

import Foundation

extension UIFont{
    open class func regularFont(size:CGFloat)->UIFont{
        if let font = UIFont.init(name: "SFProDisplay-Regular", size: size){
            return font
        }
        
        return UIFont.systemFont(ofSize: size, weight: .regular)
    }
    open class func boldFont(size:CGFloat)->UIFont{
        if let font = UIFont.init(name: "SFProDisplay-Bold", size: size){
            return font
        }
        
        return UIFont.systemFont(ofSize: size, weight: .bold)
    }
    
    open class func italicFont(size:CGFloat)->UIFont{
        if let font = UIFont.init(name: "SFProDisplay-RegularItalic", size: size){
            return font
        }
        
        return UIFont.italicSystemFont(ofSize: size)
        
    }
    
    
}

