//
//  VIE_ThumbType.swift
//  vvp
//
//  Created by Andrey Kotlyarov on 17.09.17.
//  Copyright © 2017 Virtual Video Pass. All rights reserved.
//

import UIKit



enum VIE_ThumbType: Int
{
    case large  = 1
    case small  = 2
    
    static let count: Int = 2
    
    var title: String
    {
        get
        {
            switch self
            {
            case .large:
                return "Large"
            case .small:
                return "Small"
            //default:
                //return String(self.rawValue)
            }
        }
    }
    
    
    var description: String
    {
        var desc = String()
        
        //desc += super.description + " - "
        
        desc += "VIM_THUMB-TYPE ("
        desc += "title = '\(self.title)'; "
        desc += "type = '\(self)'"
        desc += ")"
        
        return desc
    }
    
    
    
}
