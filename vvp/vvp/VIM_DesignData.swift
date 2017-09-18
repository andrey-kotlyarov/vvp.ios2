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
    
    
    //let sizeType: Int
    
    let colorBG_L: UIColor
    let colorBG: UIColor
    let colorBG_D: UIColor
    
    let colorLogo: UIColor
    let colorRed: UIColor
    let colorTint: UIColor
    
    
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
        //self.sizeType = Int(UIScreen.main.scale)
        
        self.colorBG_L = VIU_Color.colorFromHexString(hex: "#0f80bf")!
        self.colorBG   = VIU_Color.colorFromHexString(hex: "#0e608f")!
        self.colorBG_D = VIU_Color.colorFromHexString(hex: "#0d405f")!
        
        self.colorLogo = VIU_Color.colorFromHexString(hex: "#ff8400")!
        self.colorRed  = VIU_Color.colorFromHexString(hex: "#e71a1a")!
        self.colorTint = VIU_Color.colorFromHexString(hex: "#0e608f")!
        
        
        
        self.viewerThumbLarge_W = UIScreen.main.bounds.width - 32.0
        self.viewerThumbLarge_H = (9.0 * self.viewerThumbLarge_W) / 16.0
        self.viewerRowLarge_H = self.viewerThumbLarge_H + (16.0 + 8.0 + 16.0 + 51.0)
        
        self.viewerThumbLarge_W_px = Int(0.5 + Double(self.viewerThumbLarge_W) * Double(UIScreen.main.scale))
        self.viewerThumbLarge_H_px = Int(0.5 + Double(self.viewerThumbLarge_H) * Double(UIScreen.main.scale))
        
        
        
        
        self.viewerThumbSmall_W = (UIScreen.main.bounds.width - (16.0 + 8.0 + 20.0 + 16.0)) / 2.5
        self.viewerThumbSmall_H = (9.0 * self.viewerThumbSmall_W) / 16.0
        self.viewerRowSmall_H = self.viewerThumbSmall_H + (8.0 + 8.0)
        
        self.viewerThumbSmall_W_px = Int(0.5 + Double(self.viewerThumbSmall_W) * Double(UIScreen.main.scale))
        self.viewerThumbSmall_H_px = Int(0.5 + Double(self.viewerThumbSmall_H) * Double(UIScreen.main.scale))
        
        
        
        
        
        super.init()
        
        
        
        UIApplication.shared.delegate!.window!?.tintColor = self.colorTint
        
        
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
    
    
    
    
    
    
    
    /**/
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
    /**/
    
    override var description: String
    {
        var desc = String()
        
        //desc += super.description + " - "
        
        desc += "VIM_DESIGN-DATA ("
        //desc += "sizeType = " + String(self.sizeType) + "; "
        
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
