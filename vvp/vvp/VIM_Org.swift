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
    let title: String
    
    
    
    init(dict: NSDictionary)
    {
        self.orgId = dict["org_id"] as! Int
        self.name = dict["name"] as! String
        self.title = dict["title"] as! String
        
        super.init()
    }
    
    init(id: Int, name: String, title: String)
    {
        self.orgId = id
        self.name = name
        self.title = title
    }
    
    
    override var description: String
    {
        var desc = String()
        
        //desc += super.description + " - "
        
        desc += "VIM_ORG ("
        desc += "orgId = \(self.orgId); "
        desc += "name = '\(self.name)'; "
        desc += "title = '\(self.title)'; "
        
        desc += ")"
        
        return desc
    }
    
}
