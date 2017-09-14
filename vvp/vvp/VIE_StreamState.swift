//
//  VIE_StreamState.swift
//  vvp
//
//  Created by Andrey Kotlyarov on 14.09.17.
//  Copyright © 2017 Virtual Video Pass. All rights reserved.
//

import UIKit



enum VIE_StreamState: Int
{
    case not_strated  = 10
    case started      = 20
    case paused       = 30
    case finished     = 40
    
    static let count: Int = 4
    
    var title: String
    {
        get
        {
            switch self
            {
                case .not_strated:
                    return "Not Started"
                case .started:
                    return "Started"
                case .paused:
                    return "Paused"
                case .finished:
                    return "Finished"
                //default:
                //    return String(self.rawValue)
            }
        }
    }
    
    
    var description: String
    {
        var desc = String()
        
        //desc += super.description + " - "
        
        desc += "VIM_STREAM_STATE ("
        desc += "title = '\(self.title)'; "
        desc += "state = '\(self)'"
        desc += ")"
        
        return desc
    }
    
    
    
}
