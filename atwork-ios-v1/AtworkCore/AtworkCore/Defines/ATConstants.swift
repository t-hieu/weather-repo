//
//  ATConstants.swift
//  AtworkCore
//
//  Created by CuongNV on 10/4/18.
//  Copyright © 2018 Atwork. All rights reserved.
//

import UIKit
import TrenteCoreSwift

let APP_DELEGATE = UIApplication.shared.delegate as? ATAppDelegate

let SCHEDULE_HEIGHT = CGFloat(80)
let SCHEDULE_FONT_SIZE = CGFloat(14)

//COLORS
let AT_COLOR_BLACK = UIColor.init(hex:"000000")
let AT_COLOR_WHITE = UIColor.init(hex:"ffffff")
public let AT_COLOR_GRAY = UIColor.init(hex:"f0f0f0")
let AT_COLOR_BLUE_LIGHT = UIColor.init(hex:"2c9dd3")
let AT_COLOR_BLUE_DARK = UIColor.init(hex:"096b9d")
let AT_COLOR_GREEN = UIColor.init(hex:"c0f75e")
let AT_COLOR_PINK = UIColor.init(hex:"fef4f4")
let AT_COLOR_RED = UIColor.init(hex:"802826")
let AT_COLOR_BORDER = UIColor.init(hex:"D8D8D8")
let AT_COLOR_BORDER_ADD_SCHEDULE = UIColor.init(hex:"FF7700")
let AT_COLOR_LIGHT_GRAY = UIColor.init(hex:"D9D9D9")

//FONT_SIZE
let AT_FONT_SIZE_NORMAL = CGFloat(14)
let AT_FONT_SIZE_BIG = CGFloat(35)
let AT_FONT_SIZE_SMALL = CGFloat(17)
let AT_FONT_SIZE_SUPER = CGFloat(40)


let AT_FILL_IN_TEXTFIELD_ADD_NEW_schedule = TRColorUtil.makeColor4RGB(r: 255, g: 224, b: 199, alpha: 1)
let AT_FILL_IN_TEXTFIELD = TRColorUtil.getColor4Hexa(hexString: "#c0f75e")
let AT_COLOR_TITLE_INPUT_PERFORMACE = TRColorUtil.getColor4Hexa(hexString: "#f0f0f0")
let AT_COLOR_TITLE_INPUT_PERFORMACE_RED = TRColorUtil.getColor4Hexa(hexString: "#fef4f4")
let AT_COLOR_BLUE = TRColorUtil.getColor4Hexa(hexString: "#2c9dd3")

let AT_BASE_VIEW_35_TYPE_DATE = "DAT"
let AT_BASE_VIEW_35_TYPE_ELV = "ELV"
let AT_BASE_VIEW_35_TYPE_OPERATOR = "OPE"
let AT_BASE_VIEW_35_TYPE_TIME_FROM = "TFR"
let AT_BASE_VIEW_35_TYPE_TIME_TO = "TTO"

let AT_CORNER_RADIUS_BUTTON = CGFloat(7)


// schedule detail - button status

let AT_SCHEDULE_NEW_CREATE = 0
let AT_SCHEDULE_NEW_CONFIRM = 1
let AT_SCHEDULE_NEW_CONFIRM_OK = 2

let AT_SCHEDULE_DETAIL_VIEW = 11
let AT_SCHEDULE_DETAIL_EDIT = 12
let AT_SCHEDULE_DETAIL_CONFIRM = 13
let AT_SCHEDULE_DETAIL_DELETE = 14
let AT_SCHEDULE_DETAIL_CONFIRM_OK = 15
//let AT_SCHEDULE_DETAIL_CREATE_NEW = 0
//let AT_SCHEDULE_DETAIL_CREATE_NEW = 0
//let AT_SCHEDULE_DETAIL_CREATE_NEW = 0
//let AT_SCHEDULE_DETAIL_CREATE_NEW = 0



let AT_LOGIN_BUTTON_COLOR = TRColorUtil.getColor4Hexa(hexString: "#2c9dd3")
let AT_LOGIN_BACKGROUND_COLOR = TRColorUtil.getColor4Hexa(hexString: "#ffffff")


let AT_APP_BASE_COLOR = TRColorUtil.getColor4Hexa(hexString: "#ffffff")
let AT_BUTTON_COLOR = TRColorUtil.getColor4Hexa(hexString: "#2c9dd3")
let AT_BUTTON_COLOR1 = TRColorUtil.getColor4Hexa(hexString: "#c0f75e")
let AT_BUTTON_COLOR2 = TRColorUtil.getColor4Hexa(hexString: "#096b9d")

//state of People / Rubbish
let AT_PEOPLE_RUBBISH_STATE_GOOD = "G"
let AT_PEOPLE_RUBBISH_STATE_HUMAN = "H"
let AT_PEOPLE_RUBBISH_STATE_RUBBISH = "R"

let AT_ORDER_DESC = "0"
let AT_ORDER_ASC = "1"

let AT_PERFORMANCE_INPUT_STATUS_SHOW = "show"
let AT_PERFORMANCE_INPUT_STATUS_MODIFY = "modify"
let AT_PERFORMANCE_INPUT_STATUS_CONFIRM = "confirm"
let AT_PERFORMANCE_INPUT_STATUS_CREATE_NEW = "createN"
let AT_PERFORMANCE_INPUT_STATUS_CONFIRM_NEW = "confirmN"

let AT_TABBAR_PERFORMANCE_INPUT = "tab input"
let AT_TABBAR_PERFORMANCE_CONFIRM = "tab confirm"

//---------------------------------------------------------------------------------------------
// Notification
//---------------------------------------------------------------------------------------------
let AT_NOTIFICATION_DOUBLE_TAP_ON_TABBAR = "LW_NOTIFICATION_DOUBLE_TAP_ON_TABBAR"

//---------------------------------------------------------------------------------------------
// filter by japanse
//---------------------------------------------------------------------------------------------
//japanese
let aRows = ["あ","い","う","え","お"]
let kaRows = ["か","が","き","きゃ","きゅ","きょ","ぎ","ぎゃ","ぎゅ","ぎょ","く","ぐ","け","げ","こ","ご"]
let saRows = ["さ","ざ","し","しゃ","しゅ","しょ","じ","じゃ","じゅ","じょ","す","ず","せ","ぜ","そ","ぞ"]
let taRows = ["た","だ","ち","ちゃ","ちゅ","ちょ","ぢ","つ","づ","て","で","と","ど"]
let naRows = ["な","に","にゃ","にゅ","にょ","ぬ","ね","の"]
let haRows = ["は","ば","ぱ","ひ","ひゃ","ひゅ","ひょ","び","びゃ","びゅ","びょ","ぴ","ぴゃ","ぴゅ","ぴょ","ふ","ぶ","ぷ","へ","べ","ぺ","ほ","ぼ","ぽ"]
let maRows = ["ま","み","みゃ","みゅ","みょ","む","め","も"]
let yaRows = ["や","ゆ","よ"]
let raRows = ["ら","り","りゃ","りゅ","りょ","る","れ","ろ"]
let waRows = ["わ"]
let rows = ["あ","か","さ","た","な","は","ま","や","ら","わ"]

var dailyScrollOffset: CGPoint! = CGPoint.init(x: 0, y: 2*SCHEDULE_HEIGHT)
let HOUR_ADD = 6

let AT_SCHEDULE_STATUS_ADJUSTING = 1
let AT_SCHEDULE_STATUS_CONFIRM = 2
let AT_SCHEDULE_STATUS_REJECT = 3
let AT_SCHEDULE_STATUS_DECIDED = 4

let TAG_ROW_INFO = 0
let TAG_ROW_CUSTOMER = 1
let TAG_ROW_STARTDATE = 2
let TAG_ROW_ENDDATE = 3
let TAG_ROW_START_TIME = 4
let TAG_ROW_END_TIME = 41
let TAG_ROW_REQUIRED_TIME = 21
let TAG_ROW_ELV = 5
let TAG_ROW_CATEGORY = 6
let TAG_ROW_GOOD = 7
let TAG_ROW_GATE = 8
let TAG_ROW_FROM = 9
let TAG_ROW_TO = 10
let TAG_ROW_TO2 = 102
let TAG_ROW_TO3 = 103
let TAG_ROW_TIME = 11
let TAG_ROW_VERHICLE = 12
let TAG_ROW_PACKING = 13
let TAG_ROW_IS_FORK_LIFT = 14
let TAG_ROW_NOTE = 15
let TAG_ROW_CAMERA = 16
let TAG_ROW_BUTTON = 17
let TAG_ROW_CREATER = 18
let TAG_ROW_UPDATER = 19
let TAG_ROW_STATUS = 20

let MODE_EDIT_NONE = 1
let MODE_EDIT_CUS_CUS = 2
let MODE_EDIT_PRO_CUS = 3
let MODE_EDIT_PRO_PRO = 4
let MODE_EDIT_SCHEDULE = 5
