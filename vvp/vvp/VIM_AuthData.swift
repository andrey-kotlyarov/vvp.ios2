//
//  VIM_AuthData.swift
//  vvp
//
//  Created by Kotlyarov Andrey on 06.09.17.
//  Copyright © 2017 Virtual Video Pass. All rights reserved.
//

import UIKit



class VIM_AuthData: NSObject
{
    static let current = VIM_AuthData()
    
    
    
    var token: String?
    var profile: VIM_Profile?
    //var org: VIM_Org?
    //var menu: VIM_Menu?
    
    var username: String?
    var password: String?
    //var availableOrgs: [VIM_Org]?
    
    
    
    override private init()
    {
        self.token = nil
        self.profile = nil
        //self.org = nil
        //self.menu = nil
        
        self.username = nil
        self.password = nil
        //self.availableOrgs = nil
        
        super.init()
        
        
        //
        //
        //
        //print("VIM_AuthData: init")
    }
    
    
    
    func isAutentified() -> Bool
    {
        return (self.token != nil && self.profile != nil)
    }
    
    func updateBy(username: String, password: String)
    {
        self.token = nil;
        self.profile = nil;
        //self.org = nil;
        //self.menu = nil;
        
        self.username = username
        self.password = password
        
        /*
        self.availableOrgs = []
        let json_items = dict["items"] as! NSArray
        
        for json_item in json_items
        {
            let org = JEM_Org(dict: json_item as! NSDictionary)
            self.availableOrgs!.append(org)
        }
        */
    }
    
    //func updateBy(#dict: NSDictionary)
    func updateBy(_ dict: NSDictionary)
    {
        self.username = nil
        self.password = nil
        //self.availableOrgs = nil
        
        
        self.token = dict["token"] as! String?
        self.profile = VIM_Profile(dict: dict["profile"] as! NSDictionary)
        //self.org = VIM_Org(dict: dict["org"] as! NSDictionary)
        //self.menu = VIM_Menu(dict: dict["menu"] as! NSDictionary)
        
        VIM_DesignData.current.setColorsByProfile(self.profile)
    }
    
    
    
    
    func clearAuthData()
    {
        self.token = nil;
        self.profile = nil;
        //self.org = nil;
        //self.menu = nil;
        
        //
        //
        //????
        //self.username = nil
        //self.password = nil
        //
        //
        //
        
        VIM_DesignData.current.setColorsByDefault()
    }
    
    
    
    
    override var description: String
    {
        var desc = String()
        
        //desc += super.description + " - "
        
        desc += "VIM_AUTH-DATA ("
        desc += "token = " + (self.token == nil ? "[empty]" : self.token!) + "; "
        
        desc += "profile = " + (self.profile == nil ? "[empty]" : self.profile!.description) + "; "
        //desc += "org = " + (self.org == nil ? "[empty]" : self.org!.description) + "; "
        //desc += "menu = " + (self.menu == nil ? "[empty]" : self.menu!.description) + "; "
        
        desc += "username = " + (self.username == nil ? "[empty]" : self.username!) + "; "
        desc += "password = " + (self.password == nil ? "[empty]" : self.password!) + "; "
        //desc += "availableOrgs = " + (self.availableOrgs == nil ? "[empty]" : self.availableOrgs!.description) + ""
        
        desc += ")"
        
        return desc
    }
    
    
    
}
