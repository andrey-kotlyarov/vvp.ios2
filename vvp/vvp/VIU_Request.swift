//
//  VIU_Request.swift
//  vvp
//
//  Created by Kotlyarov Andrey on 06.09.17.
//  Copyright © 2017 Virtual Video Pass. All rights reserved.
//

import UIKit



class VIU_Request: NSObject
{
    private var _urlRequest: NSMutableURLRequest
    private var _postValues: [String: String]
    
    
    
    init(cmd: String)
    {
        //var url: URL? = URL(string: "https://www2.jevin.net/ws/wsJevin2.aspx")
        var url: URL? = URL(string: "http://virtualvideopass.com/WebAPI/ws_1")
        
        
        //if isLocalMode
        if VIM_UserData.current.isLocalMode()
        {
            url = URL(string: "http://10.3.15.21:8080/WebAPI/ws_1")
        }
        
        self._urlRequest = NSMutableURLRequest(url: url!)
        self._postValues = ["cmd": cmd]
    }
    
    
    /*
     class func correctedUrl(_ url: String) -> String
     {
         var newUrl: String = url
     
         //if isLocalMode
         if VIM_UserData.current.isLocalMode()
         {
             newUrl = url.replacingOccurrences(of: "localhost:12345", with: "10.3.15.21:8888")
         }
     
         return newUrl
     }
     */
    
    
    //func addPostValue(#val: String, forKey key: String)
    func addPostValue(_ val: String, forKey key: String)
    {
        self._postValues.updateValue(val, forKey: key)
    }
    
    func urlRequest() -> URLRequest
    {
        var postString: String = String()
        
        for (key, val) in self._postValues
        {
            postString += (postString.isEmpty ? "" : "&")
            postString += key
            postString += "="
            postString += val.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        }
        
        //let postData:NSData = postString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!
        let postData:Data = postString.data(using: String.Encoding.utf8)!
        
        self._urlRequest.httpMethod = "POST"
        //self._urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        self._urlRequest.httpBody = postData
        self._urlRequest.setValue(String(postData.count), forHTTPHeaderField: "Content-Length")
        self._urlRequest.httpShouldHandleCookies = false
        self._urlRequest.timeoutInterval = 30
        
        //self._urlRequest.cachePolicy = .ReloadIgnoringLocalCacheData
        self._urlRequest.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData
        
        
        
        return self._urlRequest as URLRequest
    }
    
     /*
     func isWWW2Jevin() -> Bool
     {
         return (_urlRequest.url!.host! == "www2.jevin.net")
     }
     */
    
    override var description: String
    {
        var desc = String()
        
        //desc += super.description + " - "
        
        desc += "VIU_REQUEST ("
        
        desc += "_urlRequest = " + "\(_urlRequest)" + "; "
        desc += "_postValues = " + "\(_postValues)" + "; "
        
        desc += ")"
        
        return desc
    }
}
