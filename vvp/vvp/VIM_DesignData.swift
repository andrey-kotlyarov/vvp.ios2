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
    
    
    
    override private init()
    {
        self.sizeType = Int(UIScreen.main.scale)
        
        self.colorBG_L = VIU_Color.colorFromHexString(hex: "#0f80bf")!
        self.colorBG   = VIU_Color.colorFromHexString(hex: "#0e608f")!
        self.colorBG_D = VIU_Color.colorFromHexString(hex: "#0d405f")!
        
        self.colorLogo = VIU_Color.colorFromHexString(hex: "#ff8400")!
        self.colorRed = VIU_Color.colorFromHexString(hex: "#e71a1a")!
        
        
        //print("VIM_DesignData init")
    }

}
