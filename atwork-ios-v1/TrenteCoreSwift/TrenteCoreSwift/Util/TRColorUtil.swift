//
//  TRColorUtil.swift
//  TrenteCoreSwift
//
//  Created by TrungND on 5/26/17.
//  Copyright © 2017 Trente. All rights reserved.
//

import UIKit

public class TRColorUtil {
    
//    MARK: get UIColor object for hexa string
    public class func getColor4Hexa(hexString: String) -> UIColor{
        let colorString = hexString.replacingOccurrences(of: "#", with: "").uppercased()
        var alpha, red, blue, green: CGFloat?
        
        switch (colorString.count) {
        case 3: // #RGB
            alpha   = 1
            red     = colorComponentFrom(string: colorString, start: 0, length: 1)
            green   = colorComponentFrom(string: colorString, start: 1, length: 1)
            blue    = colorComponentFrom(string: colorString, start: 2, length: 1)
            break;
            
        case 4: // #ARGB
            alpha   = colorComponentFrom(string: colorString, start: 0, length: 1)
            red     = colorComponentFrom(string: colorString, start: 1, length: 1)
            green   = colorComponentFrom(string: colorString, start: 2, length: 1)
            blue    = colorComponentFrom(string: colorString, start: 3, length: 1)
            break;
            
        case 6: // #RRGGBB
            alpha   = 1
            red     = colorComponentFrom(string: colorString, start: 0, length: 2)
            green   = colorComponentFrom(string: colorString, start: 2, length: 2)
            blue    = colorComponentFrom(string: colorString, start: 4, length: 2)
            break;
            
        case 8: // #AARRGGBB
            alpha   = colorComponentFrom(string: colorString, start: 0, length: 2)
            red     = colorComponentFrom(string: colorString, start: 2, length: 2)
            green   = colorComponentFrom(string: colorString, start: 4, length: 2)
            blue    = colorComponentFrom(string: colorString, start: 6, length: 2)
            break;
            
        default:
            NSException.raise(NSExceptionName(rawValue: "Invalid color value"), format: "Color value %@ is invalid.  It should be a hex value of the form #RBG, #ARGB, #RRGGBB, or #AARRGGBB", arguments: getVaList([hexString]))
            break;
        }
        let color = UIColor.init(red: red!, green: green!, blue: blue!, alpha: alpha!)
        return color
    }
    
    public class func colorComponentFrom(string: String, start: Int, length: Int) -> CGFloat {
        let start = string.index(string.startIndex, offsetBy: start)
        let end = string.index(start, offsetBy: length)
        let substring = String(string[start..<end])
        
        let fullHex = length == 2 ? substring: NSString.init(format: "%@%@", [substring, substring]) as String
        let value = UInt8(fullHex, radix: 16)
        return CGFloat(value!) / 255.0;
    }
    
    public class func makeColor4RGB(r: Float, g: Float, b: Float, alpha: Float) -> UIColor{
        return UIColor.init(red: CGFloat(r / 255.0), green: CGFloat(g / 255.0), blue: CGFloat(b / 255.0), alpha: CGFloat(alpha))
    }
}
