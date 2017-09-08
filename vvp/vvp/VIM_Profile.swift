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
    let userId: Int
    let username: String
    let firstName: String
    let lastName: String
    
    
    
    init(dict: NSDictionary)
    {
        self.userId = dict["id"] as! Int
        self.username = dict["username"] as! String
        self.firstName = dict["first_name"] as! String
        self.lastName = dict["last_name"] as! String
        
        return
    }
    
    
    
    override var description: String
    {
        var desc = String()
        
        //desc += super.description + " - "
        
        desc += "VIM_PROFILE ("
        desc += "userId = '\(self.userId)'; "
        desc += "username = '\(self.username)'; "
        desc += "firstName = '\(self.firstName)'; "
        desc += "lastName = '\(self.lastName)'"
        desc += ")"
        
        return desc
    }

}
