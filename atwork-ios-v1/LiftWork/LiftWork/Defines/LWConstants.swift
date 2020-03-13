//
//  LWConstants.swift
//  LiftWork
//
//  Created by CuongNV on 5/14/18.
//  Copyright © 2018 Trente. All rights reserved.
//

import TrenteCoreSwift
let APP_DELEGATE = UIApplication.shared.delegate as? AppDelegate
//COLORS
let LW_COLOR_BLACK = UIColor.init(hex:"000000")
let LW_COLOR_WHITE = UIColor.init(hex:"ffffff")
let LW_COLOR_GRAY = UIColor.init(hex:"f0f0f0")
let LW_COLOR_BLUE_LIGHT = UIColor.init(hex:"2c9dd3")
let LW_COLOR_BLUE_DARK = UIColor.init(hex:"096b9d")
let LW_COLOR_GREEN = UIColor.init(hex:"c0f75e")
let LW_COLOR_PINK = UIColor.init(hex:"fef4f4")
let LW_COLOR_RED = UIColor.init(hex:"802826")
let LW_COLOR_BORDER = UIColor.init(hex:"D8D8D8")
let LW_COLOR_LIGHT_GRAY = UIColor.init(hex:"D9D9D9")

//FONT_SIZE
let LW_FONT_SIZE_NORMAL = CGFloat(25)
let LW_FONT_SIZE_BIG = CGFloat(35)
let LW_FONT_SIZE_SMALL = CGFloat(17)
let LW_FONT_SIZE_SUPER = CGFloat(40)


let LW_FILL_IN_TEXTFIELD = TRColorUtil.getColor4Hexa(hexString: "#c0f75e")
let LW_COLOR_TITLE_INPUT_PERFORMACE = TRColorUtil.getColor4Hexa(hexString: "#f0f0f0")
let LW_COLOR_TITLE_INPUT_PERFORMACE_RED = TRColorUtil.getColor4Hexa(hexString: "#fef4f4")
let LW_COLOR_BLUE = TRColorUtil.getColor4Hexa(hexString: "#2c9dd3")

let LW_BASE_VIEW_35_TYPE_DATE = "DAT"
let LW_BASE_VIEW_35_TYPE_ELV = "ELV"
let LW_BASE_VIEW_35_TYPE_OPERATOR = "OPE"
let LW_BASE_VIEW_35_TYPE_TIME_FROM = "TFR"
let LW_BASE_VIEW_35_TYPE_TIME_TO = "TTO"

let LW_CORNER_RADIUS_BUTTON = CGFloat(7)



let LW_LOGIN_BUTTON_COLOR = TRColorUtil.getColor4Hexa(hexString: "#2c9dd3")
let LW_LOGIN_BACKGROUND_COLOR = TRColorUtil.getColor4Hexa(hexString: "#ffffff")


let LW_APP_BASE_COLOR = TRColorUtil.getColor4Hexa(hexString: "#ffffff")
let LW_BUTTON_COLOR = TRColorUtil.getColor4Hexa(hexString: "#2c9dd3")
let LW_BUTTON_COLOR1 = TRColorUtil.getColor4Hexa(hexString: "#c0f75e")
let LW_BUTTON_COLOR2 = TRColorUtil.getColor4Hexa(hexString: "#096b9d")

//state of People / Rubbish
let LW_PEOPLE_RUBBISH_STATE_GOOD = "G"
let LW_PEOPLE_RUBBISH_STATE_HUMAN = "H"
let LW_PEOPLE_RUBBISH_STATE_RUBBISH = "R"

let LW_ORDER_DESC = "0"
let LW_ORDER_ASC = "1"

let LW_PERFORMANCE_INPUT_STATUS_SHOW = "show"
let LW_PERFORMANCE_INPUT_STATUS_MODIFY = "modify"
let LW_PERFORMANCE_INPUT_STATUS_CONFIRM = "confirm"
let LW_PERFORMANCE_INPUT_STATUS_CREATE_NEW = "createN"
let LW_PERFORMANCE_INPUT_STATUS_CONFIRM_NEW = "confirmN"

let LW_TABBAR_PERFORMANCE_INPUT = "tab input"
let LW_TABBAR_PERFORMANCE_CONFIRM = "tab confirm"

//---------------------------------------------------------------------------------------------
// Notification
//---------------------------------------------------------------------------------------------
let LW_NOTIFICATION_DOUBLE_TAP_ON_TABBAR = "LW_NOTIFICATION_DOUBLE_TAP_ON_TABBAR"

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

//Connecton mark
let MATERIAL_MARK = "、"
let FLOOR_MARK = "-"
let COMMA_MARK = ","
