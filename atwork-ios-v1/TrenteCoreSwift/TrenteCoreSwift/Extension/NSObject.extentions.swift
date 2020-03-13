//
//  NSObject.extentions.swift
//  B1029
//
//  Created by Nguyen Duc Viet on 10/2/17.
//  Copyright © 2017 Portalbeanz. All rights reserved.
//

import Foundation
extension NSObject {
    public var className: String {
        return NSStringFromClass(type(of: self))
    }
    public class var className: String {
        return String(describing: self)
    }
    
}

extension NSArray{
    func toString()->String{
        if self.count == 0 {
            return ""
        }
        return self.componentsJoined(by: ",")
    
    }
}
