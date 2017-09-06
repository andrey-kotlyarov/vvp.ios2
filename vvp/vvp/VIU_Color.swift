//
//  VIU_Color.swift
//  vvp
//
//  Created by Kotlyarov Andrey on 06.09.17.
//  Copyright © 2017 Virtual Video Pass. All rights reserved.
//

import UIKit



class VIU_Color: NSObject
{
    static func colorFromHexString(hex: String?, withAlpha alpha: CGFloat = 1.0) -> UIColor?
    {
        if let hex = hex
        {
            var cString: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
            
            if (cString.hasPrefix("#"))
            {
                let index = cString.index(cString.startIndex, offsetBy: 1)
                cString = cString.substring(from: index)
            }
            
            if (cString.characters.count == 6)
            {
                var rgbValue:UInt32 = 0
                Scanner(string: cString).scanHexInt32(&rgbValue)
                
                let color: UIColor =
                    UIColor(
                        red: CGFloat(Float((rgbValue & 0xFF0000) >> 16)/255),
                        green: CGFloat(Float((rgbValue & 0x00FF00) >> 8)/255),
                        blue: CGFloat(Float(rgbValue & 0x0000FF)/255),
                        alpha: CGFloat(alpha)
                )
                return color
            }
            
            return UIColor.gray
        }
        
        return nil
    }
}
