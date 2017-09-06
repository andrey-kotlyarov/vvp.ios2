//
//  VIM_Profile.swift
//  vvp
//
//  Created by Kotlyarov Andrey on 06.09.17.
//  Copyright © 2017 Virtual Video Pass. All rights reserved.
//

import UIKit



class VIM_Profile: NSObject
{
    let fname: String
    let lname: String
    
    
    
    init(dict: NSDictionary)
    {
        self.fname = dict["fname"] as! String
        self.lname = dict["lname"] as! String
        
        return
    }
    
    
    
    override var description: String
    {
        var desc = String()
        
        //desc += super.description + " - "
        
        desc += "VIM_PROFILE ("
        desc += "fname = '" + self.fname + "'; "
        desc += "lname = '" + self.lname + "'"
        desc += ")"
        
        return desc
    }

}
