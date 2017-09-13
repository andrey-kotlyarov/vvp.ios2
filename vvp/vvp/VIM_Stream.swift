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
    
    let name: String
    let thumbnailSrc: String
    var thumbnailImage: UIImage?
    
    let title: String
    let desc: String
    
    let owner: String
    let connectedUsers: Int
    let duration: Int
    
    
    init(dict: NSDictionary)
    {
        self.streamId = dict["id"] as! Int
        self.name = dict["name"] as! String
        self.thumbnailSrc = dict["thumbnail_src"] as! String
        self.title = dict["title"] as! String
        self.desc = dict["desc"] as! String
        self.owner = dict["owner"] as! String
        self.connectedUsers = dict["connected_users"] as! Int
        self.duration = dict["duration"] as! Int
        
        self.thumbnailImage = nil
        /*
        self.thumbnailImage = nil
        do
        {
            let url = URL(string: self.thumbnailSrc)
            let imgData = try Data(contentsOf: url!)
            thumbnailImage = UIImage(data: imgData)!
        }
        catch
        {
            
        }
        */
        
        super.init()
    }
    
    
    func formatDuration() -> String
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
    
    
    
    override var description: String
    {
        var desc = String()
        
        //desc += super.description + " - "
        
        desc += "VIM_STREAM ("
        desc += "streamId = '\(self.streamId)'; "
        desc += "name = '\(self.name)'; "
        desc += "thumbnailSrc = '\(self.thumbnailSrc)'; "
        desc += "title = '\(self.title)'; "
        desc += "desc = '\(self.desc)'; "
        desc += "owner = '\(self.owner)'; "
        desc += "connectedUsers = '\(self.connectedUsers)'; "
        desc += "duration = '\(self.duration)'"
        
        desc += ")"
        
        return desc
    }
    
    
}
