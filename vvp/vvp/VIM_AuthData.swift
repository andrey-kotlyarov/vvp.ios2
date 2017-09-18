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
    var orgs: [VIM_Org]?
    var org: VIM_Org?
    
    var streamList: VIM_StreamList?
    var stream: VIM_Stream?
    
    //var menu: VIM_Menu?
    
    //var username: String?
    //var password: String?
    //var availableOrgs: [VIM_Org]?
    
    
    
    override private init()
    {
        self.token = nil
        self.profile = nil
        self.orgs = nil
        self.org = nil
        
        self.streamList = nil
        self.stream = nil
        
        super.init()
    }
    
    
    
    func isAutentified() -> Bool
    {
        return (self.token != nil && self.profile != nil)
    }
    
    func updateBy(_ dict: NSDictionary)
    {
        //self.username = nil
        //self.password = nil
        //self.availableOrgs = nil
        
        
        self.token = dict["token"] as! String?
        self.profile = VIM_Profile(dict: dict["profile"] as! NSDictionary)
        self.org = nil
        
        
        self.orgs = []
        let json_org_items = dict["orgs"] as! NSArray
        
        for json_org_item in json_org_items
        {
            let org_item = VIM_Org(dict: json_org_item as! NSDictionary)
            self.orgs?.append(org_item)
            
            if org_item.orgId == VIM_UserData.current.orgId
            {
                org = org_item
            }
        }
        
        if org == nil && orgs != nil && orgs!.count > 0
        {
            self.org = self.orgs![0]
        }
        
        self.clearStreamList()
        
        //
        //VIM_DesignData.current.setColorsByOrg(self.org)
        //VIM_DesignData.current.setColorsByProfile(self.profile)
        //
    }
    
    func updateStreamListBy(dict: NSDictionary)
    {
        self.stream = nil
        
        let sl = VIM_StreamList(dict: dict)
        self.streamList = sl
    }
    
    func clearStreamList()
    {
        self.streamList = nil
        self.stream = nil
    }
    
    
    func clearAuthData()
    {
        self.token = nil
        self.profile = nil
        self.orgs = nil
        self.org = nil
        
        self.streamList = nil
        self.stream = nil
        
        //
        //VIM_DesignData.current.setColorsByDefault()
        //
    }
    
    
    
    
    override var description: String
    {
        var desc = String()
        
        //desc += super.description + " - "
        
        desc += "VIM_AUTH-DATA ("
        desc += "token = " + (self.token == nil ? "[nil]" : self.token!) + "; "
        
        desc += "profile = " + (self.profile == nil ? "[nil]" : self.profile!.description) + "; "
        desc += "orgs = " + (self.orgs == nil ? "[nil]" : self.orgs!.description) + "; "
        desc += "org = " + (self.org == nil ? "[nil]" : self.org!.description) + "; "
        
        desc += "streamList = " + (self.streamList == nil ? "[nil]" : self.streamList!.description) + "; "
        desc += "stream = " + (self.stream == nil ? "[nil]" : self.stream!.description) + "; "
        
        
        
        //desc += "menu = " + (self.menu == nil ? "[empty]" : self.menu!.description) + "; "
        
        //desc += "username = " + (self.username == nil ? "[empty]" : self.username!) + "; "
        //desc += "password = " + (self.password == nil ? "[empty]" : self.password!) + "; "
        //desc += "availableOrgs = " + (self.availableOrgs == nil ? "[empty]" : self.availableOrgs!.description) + ""
        
        desc += ")"
        
        return desc
    }
    
    
    
}
