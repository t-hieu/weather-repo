//
//  WFApiObjectModel.swift
//  TrenteCoreSwift
//
//  Created by HtHoan on 1/24/18.
//  Copyright © 2018 Trente. All rights reserved.
//

import UIKit
class WFApiObjectModel: NSObject {
    
    var key: String?
    var value: String?
    
    override init() {
        super.init()
    }
    
    public init(response: [String : Any]) {
        super.init()
        
        self.key = response["key"] as? String
        self.value = response["value"] as? String
    }
}
