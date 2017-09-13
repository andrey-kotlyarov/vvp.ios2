//
//  VIM_StreamList.swift
//  vvp
//
//  Created by Kotlyarov Andrey on 13.09.17.
//  Copyright © 2017 Virtual Video Pass. All rights reserved.
//

import UIKit

class VIM_StreamList: NSObject
{
    var streams: [VIM_Stream]
    let createdAt: Date
    
    
    init(dict: NSDictionary)
    {
        self.streams = []
        let json_streams = dict["streams"] as! NSArray
        
        
        for i in 1...24
        {
        for json_stream in json_streams
        {
            let stream = VIM_Stream(dict: json_stream as! NSDictionary)
            self.streams.append(stream)
        }
        }
        self.createdAt = Date()
        
        super.init()
    }
    
    
    override var description: String
    {
        var desc = String()
        
        //desc += super.description + " - "
        
        desc += "VIM_STREAM-LIST ("
        desc += "STREAMS:"
        
        for st in self.streams
        {
            desc += st.description
        }
        
        desc += "cratedAt = " + "'\(self.createdAt)'; "
        
        desc += ")"
        
        return desc
    }
    
}
