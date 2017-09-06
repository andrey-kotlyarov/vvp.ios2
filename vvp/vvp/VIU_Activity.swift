//
//  VIU_Activity.swift
//  vvp
//
//  Created by Andrey Kotlyarov on 07.09.17.
//  Copyright © 2017 Virtual Video Pass. All rights reserved.
//

import UIKit

class VIU_Activity: NSObject
{
    private var _activityView: UIView?
    private var _activityWheel: UIActivityIndicatorView?
    
    
    override init()
    {
        self._activityView = nil
        self._activityWheel = nil
        
        super.init()
    }
    
    
    func showWithAlpha(_ alpha: Float)
    {
        let delegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let window: UIWindow = delegate.window!
        
        self._activityView = UIView(frame: CGRect(x: 0, y: 0, width: window.bounds.size.width, height: window.bounds.size.height))
        self._activityView?.backgroundColor = UIColor.black
        self._activityView?.alpha = CGFloat(alpha)
        
        self._activityWheel = UIActivityIndicatorView(frame: CGRect(x: window.bounds.size.width / 2 - 12, y: window.bounds.size.height / 2 - 12, width: 24, height: 24))
        self._activityWheel?.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        
        /*
         self._activityWheel?.autoresizingMask = (
         [UIViewAutoresizing.FlexibleLeftMargin, UIViewAutoresizing.FlexibleRightMargin, UIViewAutoresizing.FlexibleTopMargin, UIViewAutoresizing.FlexibleBottomMargin]
         )
         */
        let autoresizingFlags: UIViewAutoresizing = [.flexibleLeftMargin, .flexibleRightMargin, .flexibleTopMargin, .flexibleBottomMargin]
        self._activityWheel?.autoresizingMask = autoresizingFlags
        
        
        
        
        
        self._activityWheel?.alpha = 1.0
        
        //self._activityView?.addSubview(self._activityWheel)
        window.addSubview(self._activityView!)
        window.addSubview(self._activityWheel!)
        
        self._activityWheel?.startAnimating()
    }
    
    func show()
    {
        self.showWithAlpha(0.5)
    }
    
    func hide()
    {
        self._activityWheel?.stopAnimating()
        
        self._activityWheel?.removeFromSuperview()
        self._activityView?.removeFromSuperview()
        
        self._activityView = nil
        self._activityWheel = nil
    }
}
