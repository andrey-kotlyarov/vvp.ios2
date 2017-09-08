//
//  VIM_Org.swift
//  vvp
//
//  Created by Kotlyarov Andrey on 08.09.17.
//  Copyright © 2017 Virtual Video Pass. All rights reserved.
//

import UIKit



class VIM_Org: NSObject
{
    let orgId: Int
    let name: String
    
    
    
    init(dict: NSDictionary)
    {
        self.orgId = dict["id"] as! Int
        self.name = dict["name"] as! String
        
        return
    }
    
    
    
    override var description: String
    {
        var desc = String()
        
        //desc += super.description + " - "
        
        desc += "VIM_ORG ("
        desc += "orgId = \(self.orgId); "
        desc += "name = '\(self.name)'; "
        
        desc += ")"
        
        return desc
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    /*
    let orgId: Int
    let name: String
    let abbr: String?
    let colorPrimary: UIColor?
    let colorSecondary: UIColor?
    let logoMD5: String?
    let logoSrc: String?
    
    
    
    init(dict: NSDictionary)
    {
        self.orgId = dict["id"] as! Int
        self.name = dict["name"] as! String
        self.abbr = dict["abbr"] as! String?
        self.colorPrimary = JEU_Color.colorFromHexString(dict["colorprimary"] as! String?, withAlpha: 1.0)
        self.colorSecondary = JEU_Color.colorFromHexString(dict["colorsecondary"] as! String?, withAlpha: 1.0)
        self.logoMD5 = dict["logomd5"] as! String?
        self.logoSrc = dict["logosrc"] as! String?
        
        return
    }
    
    
    
    override var description: String
    {
        var desc = String()
        
        //desc += super.description + " - "
        
        desc += "JEM_ORG ("
        desc += "id = " + String(self.orgId) + "; "
        desc += "name = '" + self.name + "'; "
        
        desc += "abbr = " + (self.abbr == nil ? "[empty]" : "'" + self.abbr! + "'") + "; "
        desc += "colorPrimary = " + (self.colorPrimary == nil ? "[empty]" : "'" + self.colorPrimary!.description + "'") + "; "
        desc += "colorSecondary = " + (self.colorSecondary == nil ? "[empty]" : "'" + self.colorSecondary!.description + "'") + "; "
        desc += "logoMD5 = " + (self.logoMD5 == nil ? "[empty]" : "'" + self.logoMD5! + "'") + "; "
        desc += "logoSrc = " + (self.logoSrc == nil ? "[empty]" : "'" + self.logoSrc! + "'") + ""
        
        desc += ")"
        
        return desc
    }
    */
}
