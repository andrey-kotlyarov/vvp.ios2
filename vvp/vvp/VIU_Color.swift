//
//  VIU_Color.swift
//  vvp
//
//  Created by Kotlyarov Andrey on 06.09.17.
//  Copyright © 2017 Virtual Video Pass. All rights reserved.
//

import UIKit



class VIU_Color
{
    static public func colorFromHexString(hex: String?, withAlpha alpha: CGFloat = 1.0) -> UIColor?
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
    
    
    
    static public func colorByCharacter(character: Character) -> UIColor
    {
        var color: UIColor = VIU_Color.colorFromHexString(hex: "#000000")!
        
        switch character
        {
        case "A":
            color = VIU_Color.colorFromHexString(hex: "#C62828")!
        case "B":
            color = VIU_Color.colorFromHexString(hex: "#AD1457")!
        case "C":
            color = VIU_Color.colorFromHexString(hex: "#6A1B9A")!
        case "D":
            color = VIU_Color.colorFromHexString(hex: "#4527A0")!
        case "E", "7":
            color = VIU_Color.colorFromHexString(hex: "#283593")!
        case "F", "4":
            color = VIU_Color.colorFromHexString(hex: "#1565C0")!
        case "G", "8":
            color = VIU_Color.colorFromHexString(hex: "#0277BD")!
        case "H", "3":
            color = VIU_Color.colorFromHexString(hex: "#00838F")!
        case "I", "5":
            color = VIU_Color.colorFromHexString(hex: "#00695C")!
        case "J":
            color = VIU_Color.colorFromHexString(hex: "#2E7D32")!
        case "K":
            color = VIU_Color.colorFromHexString(hex: "#558B2F")!
        case "L":
            color = VIU_Color.colorFromHexString(hex: "#9E9D24")!
        case "M":
            color = VIU_Color.colorFromHexString(hex: "#F9A825")!
        case "N", "9":
            color = VIU_Color.colorFromHexString(hex: "#FF8F00")!
        case "O", "1":
            color = VIU_Color.colorFromHexString(hex: "#EF6C00")!
        case "P":
            color = VIU_Color.colorFromHexString(hex: "#D84315")!
        case "Q":
            color = VIU_Color.colorFromHexString(hex: "#4E342E")!
        case "R":
            color = VIU_Color.colorFromHexString(hex: "#37474F")!
        case "S", "6":
            color = VIU_Color.colorFromHexString(hex: "#B71C1C")!
        case "T", "2":
            color = VIU_Color.colorFromHexString(hex: "#311B92")!
        case "U":
            color = VIU_Color.colorFromHexString(hex: "#0D47A1")!
        case "V":
            color = VIU_Color.colorFromHexString(hex: "#006064")!
        case "W":
            color = VIU_Color.colorFromHexString(hex: "#1B5E20")!
        case "X":
            color = VIU_Color.colorFromHexString(hex: "#827717")!
        case "Y":
            color = VIU_Color.colorFromHexString(hex: "#E65100")!
        case "Z", "0":
            color = VIU_Color.colorFromHexString(hex: "#BF360C")!
        default:
            color = VIU_Color.colorFromHexString(hex: "#000000")!
        }
        
        return color
    }
    
    
}
