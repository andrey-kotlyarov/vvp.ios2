//
//  VIM_Stream.swift
//  vvp
//
//  Created by Kotlyarov Andrey on 13.09.17.
//  Copyright © 2017 Virtual Video Pass. All rights reserved.
//

import UIKit



class VIM_Stream: NSObject
{
    let streamId: Int
    let state: VIE_StreamState
    
    let name: String
    let thumbSrc: String
    
    let title: String
    let desc: String
    
    let owner: VIM_Profile
    let connectedUsers: Int
    let duration: Int
    
    let videoURL: URL?
    let isTest: Bool
    
    
    
    init(dict: NSDictionary)
    {
        self.streamId = dict["stream_id"] as! Int
        self.state = VIE_StreamState(rawValue: dict["state"] as! Int)!
        
        self.name = dict["name"] as! String
        self.thumbSrc = dict["thumb_src"] as! String
        self.title = dict["title"] as! String
        self.desc = dict["desc"] as! String
        self.owner = VIM_Profile(dict: dict["owner"] as! NSDictionary)
        self.connectedUsers = dict["connected_users"] as! Int
        self.duration = dict["duration"] as! Int
        
        self.videoURL = URL(string: dict["video_url"] as! String)
        self.isTest = dict["is_test"] as! Bool
        
        super.init()
    }
    
    
    
    
    func takeThumbLargeSrc() -> String
    {
        return self.takeThumbSrc(width: VIM_DesignData.current.viewerThumbLarge_W_px, height: VIM_DesignData.current.viewerThumbLarge_H_px)
    }
    func takeThumbSmallSrc() -> String
    {
        return self.takeThumbSrc(width: VIM_DesignData.current.viewerThumbSmall_W_px, height: VIM_DesignData.current.viewerThumbSmall_H_px)
    }
    
    private func takeThumbSrc(width: Int, height: Int) -> String
    {
        var src = self.thumbSrc
        var w = width, h = height
        
        if self.isTest
        {
            if w <= 208
            {
                w = 208; h = 117
            }
            else if w <= 252
            {
                w = 252; h = 142
            }
            else if w <= 425
            {
                w = 425; h = 239
            }
            else if w <= 576
            {
                w = 576; h = 324
            }
            else if w <= 686
            {
                w = 686; h = 386
            }
            else/* if w <= 1146*/
            {
                w = 1146; h = 645
            }
        }
        
        src = src.replacingOccurrences(of: "[WIDTH]", with: String(w))
        src = src.replacingOccurrences(of: "[HEIGHT]", with: String(h))
        
        return src
    }
    
    
    
    override var description: String
    {
        var desc = String()
        
        //desc += super.description + " - "
        
        desc += "VIM_STREAM ("
        desc += "streamId = '\(self.streamId)'; "
        desc += "name = '\(self.name)'; "
        desc += "thumbSrc = '\(self.thumbSrc)'; "
        desc += "title = '\(self.title)'; "
        desc += "desc = '\(self.desc)'; "
        desc += "owner = '\(self.owner.description)'; "
        desc += "connectedUsers = '\(self.connectedUsers)'; "
        desc += "duration = '\(self.duration)'; "
        desc += "videoUrl = '\(String(describing: self.videoURL))'; "
        desc += "isTest = '\(self.isTest ? "YES" : "NO")'"
        
        desc += ")"
        
        return desc
    }
    
    
}
