//
//  VIM_ImageData.swift
//  vvp
//
//  Created by Kotlyarov Andrey on 15.09.17.
//  Copyright © 2017 Virtual Video Pass. All rights reserved.
//

import UIKit


class VIM_ImageData: NSObject
{
    static let current = VIM_ImageData()
    
    private var storageImages: [String: VIM_StorageImage]
    
    
    
    
    
    // TTL by default in seconds
    private let _defaultTimeToLive: TimeInterval = 300
    
    
    
    
    
    override private init()
    {
        self.storageImages = [:]
        
        
        super.init()
    }

    
    
    func imageBy(src: String, completationBlock: @escaping (UIImage?) -> Void)
    {
        self.imageBy(src: src, ttl: _defaultTimeToLive, completationBlock: completationBlock)
    }
    
    func imageBy(src: String, ttl: TimeInterval, completationBlock: @escaping (UIImage?) -> Void)
    {
        //
        // Clear old srss
        //
        for storageImage in self.storageImages
        {
            if let expireAt = storageImage.value.expireAt
            {
                if Date() > expireAt
                {
                    self.storageImages.removeValue(forKey: storageImage.value.src)
                }
            }
        }
        //
        //
        //
        
        
        
        if src.isEmpty
        {
            completationBlock(nil)
            return
        }
        
        
        if let storageImage = self.storageImages[src]
        {
            if let image = storageImage.image
            {
                completationBlock(image)
            }
            //else
            //{
            //    completationBlock(nil)
            //}
        }
        else
        {
            let storageImage = VIM_StorageImage(src: src)
            self.storageImages[src] = storageImage
            
            let task: URLSessionDownloadTask = URLSession.shared.downloadTask(
                with: URL(string: src)!,
                completionHandler:
                {
                    (location: URL?, response: URLResponse?, error: Error?) -> Void in
                    
                    /*
                    if let error = error
                    {
                        completationBlock(nil)
                        return
                    }
                    */
                    
                    if let location = location
                    {
                        if let data = try? Data(contentsOf: location)
                        {
                            DispatchQueue.main.async(
                                execute:
                                {
                                    () -> Void in
                                    
                                    let img: UIImage! = UIImage(data: data)
                                    
                                    self.storageImages[src]?.image = img
                                    self.storageImages[src]?.expireAt = Date(timeIntervalSinceNow: ttl)
                                    
                                    completationBlock(img)
                                    //completationBlock(self.storageImages[src]?.image)
                                    
                                }
                            )
                        }
                    }
                    
                }
            )
            task.resume()
        }
    }
    
    
    
    
    
    
    
    override var description: String
    {
        var desc = String()
        
        //desc += super.description + " - "
        
        desc += "VIM_IMAGE-DATA ("
        desc += "storeImages = '\(self.storageImages)'; "
        desc += ")"
        
        return desc
    }
}






