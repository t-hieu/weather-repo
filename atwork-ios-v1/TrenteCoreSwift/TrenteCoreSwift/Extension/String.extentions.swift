//
//  String.extentions.swift
//  B1029
//
//  Created by Nguyen Duc Viet on 10/2/17.
//  Copyright © 2017 Portalbeanz. All rights reserved.
//

import Foundation
import  MobileCoreServices

extension String{
    func dateFromString(format:String,locale:Locale?) -> Date?{
        let dateFormatter = DateFormatter.shared
        dateFormatter.dateFormat = format
        dateFormatter.locale = locale ?? Locale.current
        return dateFormatter.date(from:self)
    }
}
