//
//  VIM_UserData.swift
//  vvp
//
//  Created by Kotlyarov Andrey on 06.09.17.
//  Copyright © 2017 Virtual Video Pass. All rights reserved.
//

import UIKit



class VIM_UserData: NSObject
{
    static let current = VIM_UserData()
    
    private let _isDebugMode = true
    private let _isLocalMode = false
    
    private let _keyLaunchNumber = "LAUNCH_NUMBER"
    private let _keyToken = "TOKEN"
    private let _keyOrgId = "ORG_ID"
    
    var launchNumber: Int
    var token: String?
    var orgId: Int?
    
    
    
    override private init()
    {
        //print("user data init - start")
        self.launchNumber = 0
        self.token = nil
        self.orgId = nil
        
        
        // --- LAUNCH NUMBER ---
        self.launchNumber = UserDefaults.standard.integer(forKey: self._keyLaunchNumber) + 1
        
        // --- TOKEN ---
        self.token = UserDefaults.standard.object(forKey: self._keyToken) as! String?
        
        // --- ORG_ID ---
        //self.orgId = userDefaults.integer(forKey: self._keyOrgId)
        self.orgId = UserDefaults.standard.object(forKey: self._keyOrgId) as! Int?
 
        super.init()
        
        //DEBUG
        //print("VIM_UserData: launchNum = \(launchNumber); token = \(token ?? "[nil]"); orgId = \(orgId != nil ? String(orgId!) : "[nil]")")
        
        //SAVE DATA
        self.saveUserData()
        
        return
    }
    
    
    func isDebugMode() -> Bool
    {
        return self._isDebugMode
    }
    
    func isLocalMode() -> Bool
    {
        return self._isLocalMode
    }
    
    
    func saveUserData()
    {
        let userDefaults = UserDefaults.standard
        
        userDefaults.set(self.launchNumber, forKey: self._keyLaunchNumber)
        userDefaults.set(self.token, forKey: self._keyToken)
        userDefaults.set(self.orgId, forKey: self._keyOrgId)
        
        userDefaults.synchronize()
        
        return
    }
    
    func clearUserData()
    {
        self.token = nil
        
        self.saveUserData()
        
        return
    }
    
    
    
    override var description: String
    {
        var desc = String()
        
        //desc += super.description + " - "
        
        desc += "VIM_USER-DATA ("
        desc += "launchNumber = " + String(launchNumber) + "; "
        desc += "token = " + (self.token == nil ? "[nil]" : self.token!) + "; "
        desc += "orgId = " + (orgId != nil ? String(orgId!) : "[nil]")
        desc += ")"
        
        return desc
    }
}
