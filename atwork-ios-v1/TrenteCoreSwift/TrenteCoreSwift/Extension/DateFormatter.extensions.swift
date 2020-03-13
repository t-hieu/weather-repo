//
//  DateFormatter.extensions.swift
//  TrenteCoreSwift
//
//  Created by VietND on 7/17/18.
//  Copyright © 2018 Trente. All rights reserved.
//

import Foundation
extension DateFormatter{
     static var shared: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar.init(identifier: .gregorian)
        return dateFormatter
    }()

}
