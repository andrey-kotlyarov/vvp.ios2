//
//  VIM_StorageImage.swift
//  vvp
//
//  Created by Kotlyarov Andrey on 15.09.17.
//  Copyright © 2017 Virtual Video Pass. All rights reserved.
//

import UIKit



class VIM_StorageImage: NSObject
{
    let src: String
    var image: UIImage?
    //var loadedAt: Date?
    var expireAt: Date?
    
    
    init(src: String)
    {
        self.src = src
        self.image = nil
        //self.loadedAt = nil
        self.expireAt = nil
        
        super.init()
    }
    
    
    
    override var description: String
    {
        var desc = String()
        
        //desc += super.description + " - "
        
        desc += "VIM_STORAGE-IMAGE ("
        desc += "src = '\(self.src)'; "
        desc += "image = '" + (self.image != nil ? "\(self.image!)" : "[nil]") + "'; "
        //desc += "loadedAt = '" + (self.loadedAt != nil ? "\(self.loadedAt!)" : "[nil]") + "'; "
        desc += "expireAt = '" + (self.expireAt != nil ? "\(self.expireAt!)" : "[nil]") + "'; "
        
        desc += ")"
        
        return desc
    }

}
