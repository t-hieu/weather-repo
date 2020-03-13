//
//  TRAPI.swift
//  TrenteCoreSwift
//
//  Created by HtHoan on 1/23/18.
//  Copyright © 2018 Trente. All rights reserved.
//

import UIKit
//public let BASE_URL = "http://192.168.1.3:9000"
//public let BASE_URL = "http://192.168.1.16:9000"
//public let BASE_URL = "http://54.250.241.68:9000"  //AWS Dev - phase2
//public let BASE_URL = "http://52.194.230.100:9000"  //Test server
//public let BASE_URL = "http://18.179.142.113:9000" //AWS Dev
//public let BASE_URL = "https://app-atwork.com"    //AWS prod
public let BASE_URL = "http://localhost:9000"  //a doan server

let WF_URL_SIGN_OUT = "\(BASE_URL)/api/account/signout"
let WF_URL_DEVICE_CLEAR = "\(BASE_URL)/api/device/clear";

let WF_URL_REQUEST_FORM = "\(BASE_URL)/api/account/info/request/form"
let WF_URL_REQUEST_UPDATE = "\(BASE_URL)/api/account/info/request/update"

// SERVICE OF TERMS
let WF_URL_SERVICE_OF_TERMS = "\(BASE_URL)/setting/term"
let WF_URL_PRIVACY_POLICY = "\(BASE_URL)/setting/policy"


