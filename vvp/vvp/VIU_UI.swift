//
//  VIU_UI.swift
//  vvp
//
//  Created by Kotlyarov Andrey on 15.09.17.
//  Copyright © 2017 Virtual Video Pass. All rights reserved.
//

import UIKit



class VIU_UI
{
    public static func getImageLetter(_ letter: Character, frame: CGRect, font: UIFont = UIFont(name: "Helvetica Bold", size: 29)!) -> UIImage?
    {
        let bgColor = VIU_Color.colorByCharacter(character: letter)
        let textColor = UIColor.white
        
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(frame.size, false, scale)
        bgColor.set()
        UIRectFill(frame)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.center
        
        let textFontAttributes = [
            NSFontAttributeName: font,
            NSForegroundColorAttributeName: textColor,
            NSParagraphStyleAttributeName: paragraphStyle,
            NSBaselineOffsetAttributeName: -3.5,
            ] as [String : Any]
        image?.draw(in: CGRect(origin: CGPoint.zero, size: frame.size))
        
        let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: frame.size)
        String(letter).draw(in: rect, withAttributes: textFontAttributes)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    public static func getImageLetter(_ str: String, frame: CGRect, font: UIFont = UIFont(name: "Helvetica Bold", size: 29)!) -> UIImage?
    {
        return self.getImageLetter(VIU_String.characterByString(str), frame: frame, font: font)
    }
    
    
    
    
    
    static public func alertError(title: String, errorMessage: String, viewController: UIViewController, code: Int? = nil)
    {
        var message = errorMessage
        var header = ""
        
        if VIM_UserData.current.isDebugMode()
        {
            header = title
        }
        if VIM_UserData.current.isDebugMode(), let code = code
        {
            message += "\n(code = \(code))"
        }
        
        
        
        
        let alertController = UIAlertController(title: header, message: message, preferredStyle: .alert)
        //alertController.view.tintColor = VIM_DesignData.current.colorTint
        
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(action)
        
        viewController.present(alertController, animated: true, completion: nil)
    }
    static public func alertError(title: String, error: Error?, viewController: UIViewController, code: Int? = nil) -> Void
    {
        self.alertError(title: title, errorMessage: error?.localizedDescription ?? "", viewController: viewController, code: code)
    }
}
