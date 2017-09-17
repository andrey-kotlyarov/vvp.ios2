//
//  VIM_DesignData.swift
//  vvp
//
//  Created by Kotlyarov Andrey on 06.09.17.
//  Copyright © 2017 Virtual Video Pass. All rights reserved.
//

import UIKit

class VIM_DesignData: NSObject
{
    static let current = VIM_DesignData()
    
    
    let sizeType: Int
    
    let colorBG_L: UIColor
    let colorBG: UIColor
    let colorBG_D: UIColor
    
    let colorLogo: UIColor
    let colorRed: UIColor
    let colorTint: UIColor
    
    /*
    let viewerThumb_W: CGFloat
    let viewerThumb_H: CGFloat
    let viewerRow_H: CGFloat
    */
    
    let viewerThumbLarge_W: CGFloat
    let viewerThumbLarge_H: CGFloat
    let viewerRowLarge_H: CGFloat
    
    let viewerThumbLarge_W_px: Int
    let viewerThumbLarge_H_px: Int
    
    
    
    let viewerThumbSmall_W: CGFloat
    //let viewerCaptionSmall_W: CGFloat
    let viewerThumbSmall_H: CGFloat
    let viewerRowSmall_H: CGFloat
    
    let viewerThumbSmall_W_px: Int
    let viewerThumbSmall_H_px: Int
    
    
    override private init()
    {
        self.sizeType = Int(UIScreen.main.scale)
        
        self.colorBG_L = VIU_Color.colorFromHexString(hex: "#0f80bf")!
        self.colorBG   = VIU_Color.colorFromHexString(hex: "#0e608f")!
        self.colorBG_D = VIU_Color.colorFromHexString(hex: "#0d405f")!
        
        self.colorLogo = VIU_Color.colorFromHexString(hex: "#ff8400")!
        self.colorRed  = VIU_Color.colorFromHexString(hex: "#e71a1a")!
        self.colorTint = VIU_Color.colorFromHexString(hex: "#0e608f")!
        
        
        /*
        self.viewerThumb_W = UIScreen.main.bounds.width - 32.0
        self.viewerThumb_H = (9.0 * self.viewerThumb_W) / 16.0
        self.viewerRow_H = self.viewerThumb_H + (16.0 + 8.0 + 16.0 + 51.0)
        */
        
        self.viewerThumbLarge_W = UIScreen.main.bounds.width - 32.0
        self.viewerThumbLarge_H = (9.0 * self.viewerThumbLarge_W) / 16.0
        self.viewerRowLarge_H = self.viewerThumbLarge_H + (16.0 + 8.0 + 16.0 + 51.0)
        
        self.viewerThumbLarge_W_px = Int(0.5 + Double(self.viewerThumbLarge_W) * Double(UIScreen.main.scale))
        self.viewerThumbLarge_H_px = Int(0.5 + Double(self.viewerThumbLarge_H) * Double(UIScreen.main.scale))
        
        
        
        
        self.viewerThumbSmall_W = (UIScreen.main.bounds.width - (16.0 + 8.0 + 20.0 + 16.0)) / 2.5
        //self.viewerCaptionSmall_W = UIScreen.main.bounds.width - (16.0 + 8.0 + 20.0 + 16.0 + self.viewerThumbSmall_W)
        self.viewerThumbSmall_H = (9.0 * self.viewerThumbSmall_W) / 16.0
        self.viewerRowSmall_H = self.viewerThumbSmall_H + (8.0 + 8.0)
        
        self.viewerThumbSmall_W_px = Int(0.5 + Double(self.viewerThumbSmall_W) * Double(UIScreen.main.scale))
        self.viewerThumbSmall_H_px = Int(0.5 + Double(self.viewerThumbSmall_H) * Double(UIScreen.main.scale))
        
        
        
        
        
        super.init()
        
        
        
        UIApplication.shared.delegate!.window!?.tintColor = self.colorBG
        //AppDelegate.win
        
        
        //
        //
        //
        //print("VIM_DesignData: init")
    }
    
    
    func getColorForStreamState(_ state: VIE_StreamState) -> UIColor
    {
        switch state
        {
            case .not_strated:
                return UIColor.red
            case .started:
                return self.colorRed
            case .paused:
                return UIColor.gray
            case .finished:
                return self.colorTint
            //default:
            //    return self.colorTint
        }
    }
    
    func getTitleForStreamState(_ state: VIE_StreamState) -> String
    {
        switch state
        {
            case .not_strated:
                return "PREPARE"
            case .started:
                return "LIVE"
            case .paused:
                return "PAUSED"
            case .finished:
                return "DONE"
            //default:
            //    return ""
        }
    }
    
    
    func getBGColorForLetter(_ letter: Character) -> UIColor
    {
        var color = VIU_Color.colorFromHexString(hex: "#000000")!
        
        /*
        // A B C D E F G H I J K L M N O P Q R S T U V W X Y Z
        // 0 1 2 3 4 5 6 7 8 9
        switch letter
        {
            case "A":
                color = VIU_Color.colorFromHexString(hex: "#F44336")!
            case "B":
                color = VIU_Color.colorFromHexString(hex: "#E91E63")!
            case "C":
                color = VIU_Color.colorFromHexString(hex: "#9C27B0")!
            case "D":
                color = VIU_Color.colorFromHexString(hex: "#673AB7")!
            case "E", "7":
                color = VIU_Color.colorFromHexString(hex: "#3F51B5")!
            case "F", "4":
                color = VIU_Color.colorFromHexString(hex: "#2196F3")!
            case "G", "8":
                color = VIU_Color.colorFromHexString(hex: "#03A9F4")!
            case "H", "3":
                color = VIU_Color.colorFromHexString(hex: "#00BCD4")!
            case "I", "5":
                color = VIU_Color.colorFromHexString(hex: "#009688")!
            case "J":
                color = VIU_Color.colorFromHexString(hex: "#4CAF50")!
            case "K":
                color = VIU_Color.colorFromHexString(hex: "#8BC34A")!
            case "L":
                color = VIU_Color.colorFromHexString(hex: "#CDDC39")!
            case "M":
                color = VIU_Color.colorFromHexString(hex: "#FFEB3B")!
            case "N", "9":
                color = VIU_Color.colorFromHexString(hex: "#FFC107")!
            case "O", "1":
                color = VIU_Color.colorFromHexString(hex: "#FF9800")!
            case "P":
                color = VIU_Color.colorFromHexString(hex: "#FF5722")!
            case "Q":
                color = VIU_Color.colorFromHexString(hex: "#795548")!
            case "R":
                color = VIU_Color.colorFromHexString(hex: "#607D8B")!
            case "S", "6":
                color = VIU_Color.colorFromHexString(hex: "#B71C1C")!
            case "T", "2":
                color = VIU_Color.colorFromHexString(hex: "#880E4F")!
            case "U":
                color = VIU_Color.colorFromHexString(hex: "#4A148C")!
            case "V":
                color = VIU_Color.colorFromHexString(hex: "#311B92")!
            case "W":
                color = VIU_Color.colorFromHexString(hex: "#1A237E")!
            case "X":
                color = VIU_Color.colorFromHexString(hex: "#0D47A1")!
            case "Y":
                color = VIU_Color.colorFromHexString(hex: "#01579B")!
            case "Z", "0":
                color = VIU_Color.colorFromHexString(hex: "#006064")!
            default:
                color = VIU_Color.colorFromHexString(hex: "#000000")!
        }
        */
        
        // A B C D E F G H I J K L M N O P Q R S T U V W X Y Z
        // 0 1 2 3 4 5 6 7 8 9
        switch letter
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
    
    
    
    
    
    
    
    
    
    func setColorsByDefault()
    {
        //TODO if need
    }
    
    func setColorsByProfile(_ profile: VIM_Profile?)
    {
        if let profile = profile
        {
            //TODO if need
            var _ = profile
            setColorsByDefault()
        }
        else
        {
            setColorsByDefault()
        }
    }
    
    
    override var description: String
    {
        var desc = String()
        
        //desc += super.description + " - "
        
        desc += "VIM_DESIGN-DATA ("
        desc += "sizeType = " + String(self.sizeType) + "; "
        
        desc += "colorBG = " + self.colorBG.description + "; "
        desc += "colorBG_L = " + self.colorBG_L.description + "; "
        desc += "colorBG_D = " + self.colorBG_D.description + "; "
        
        desc += "colorLogo = " + self.colorLogo.description + "; "
        desc += "colorRed = " + self.colorRed.description + "; "
        desc += "colorTint = " + self.colorTint.description + "; "
        
        
        //desc += "locale = " + self.locale.description + "; "
        //desc += "dateFormatterLong = " + self.dateFormatterLong.description + "; "
        //desc += "dateFormatterMiddle = " + self.dateFormatterMiddle.description + "; "
        //desc += "dateFormatterShort = " + self.dateFormatterShort.description + "; "
        //desc += "dateFormatterAPI = " + self.dateFormatterAPI.description + "; "
        //desc += "timeFormatter = " + self.timeFormatter.description + "; "
        //desc += "timeFormatterAPI = " + self.timeFormatterAPI.description + "; "
        
        desc += ")"
        
        return desc
    }
}
