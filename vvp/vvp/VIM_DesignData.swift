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
    
    let viewerThumb_W: CGFloat
    let viewerThumb_H: CGFloat
    let viewerRow_H: CGFloat
    
    
    
    
    override private init()
    {
        self.sizeType = Int(UIScreen.main.scale)
        
        self.colorBG_L = VIU_Color.colorFromHexString(hex: "#0f80bf")!
        self.colorBG   = VIU_Color.colorFromHexString(hex: "#0e608f")!
        self.colorBG_D = VIU_Color.colorFromHexString(hex: "#0d405f")!
        
        self.colorLogo = VIU_Color.colorFromHexString(hex: "#ff8400")!
        self.colorRed  = VIU_Color.colorFromHexString(hex: "#e71a1a")!
        self.colorTint = VIU_Color.colorFromHexString(hex: "#0e608f")!
        
        
        
        self.viewerThumb_W = UIScreen.main.bounds.width - 36.0
        self.viewerThumb_H = (9.0 * self.viewerThumb_W) / 16.0
        self.viewerRow_H = self.viewerThumb_H + 90.0
        
        super.init()
        
        //
        //
        //
        //print("VIM_DesignData: init")
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
