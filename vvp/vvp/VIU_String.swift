//
//  VIU_String.swift
//  vvp
//
//  Created by Kotlyarov Andrey on 18.09.17.
//  Copyright © 2017 Virtual Video Pass. All rights reserved.
//

import UIKit



class VIU_String
{
    
    
    public static func characterByString(_ str: String) -> Character
    {
        var character: Character = " "
        
        for c in str.uppercased().characters
        {
            if (c >= "A" && c <= "Z") || ((c >= "0" && c <= "9"))
            {
                character = c
                break
            }
        }
        
        return character
    }
    
    
    
    public static func formatTime(duration: Int) -> String
    {
        var d = ""
        
        let s: Int = duration % 60
        var m: Int = duration / 60
        let h: Int = m / 60
        m = m % 60
        
        
        if h > 0
        {
            d += "\(h):"
        }
        
        d += (m > 9 ? "" : "0") + "\(m):"
        d += (s > 9 ? "" : "0") + "\(s)"
        
        return d
    }
    
    
    
}
