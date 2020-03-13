//
//  DataModel.swift
//  TrenteCoreSwift
//
//  Created by TrungND on 5/15/17.
//  Copyright © 2017 Trente. All rights reserved.
//

import UIKit

public class DataModel: NSObject {

    var data: Data?
    var fileName: String?
    var name: String?
    
    public init(data: Data, fileName: String, name: String) {
        self.data = data
        self.fileName = fileName
        self.name = name
    }

}
