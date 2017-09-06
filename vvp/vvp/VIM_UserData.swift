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
    private let _isLocalMode = true
    
    private let _keyLaunchNumber = "LAUNCH_NUMBER"
    private let _keyToken = "TOKEN"
    
    var launchNumber: Int
    var token: String?
    
    
    
    override private init()
    {
        //print("user data init - start")
        self.launchNumber = 0
        self.token = nil
        
        
        let userDefaults = UserDefaults.standard
        
        // --- LAUNCH NUMBER ---
        self.launchNumber = userDefaults.integer(forKey: self._keyLaunchNumber) + 1
        
        // --- TOKEN ---
        self.token = userDefaults.object(forKey: self._keyToken) as! String?
        
        super.init()
        
        //
        //
        //
        print("VIM_UserData: launchNum = \(launchNumber); token = \(token ?? "-")")
        
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
        desc += "token = " + (self.token == nil ? "[empty]" : self.token!) + "; "
        desc += ")"
        
        return desc
    }
}
