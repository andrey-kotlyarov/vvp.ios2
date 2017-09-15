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
        let bgColor = VIM_DesignData.current.getBGColorForLetter(letter)
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
        return self.getImageLetter(self.getOneLetter(str), frame: frame, font: font)
    }
    
    
    public static func getOneLetter(_ str: String) -> Character
    {
        var character: Character = " "
        
        for c in str.uppercased().characters
        {
            if (c >= "A" && c <= "Z") || ((c >= "0" && c <= "9"))
            {
                character = c
                break
            }
        }
        
        return character
    }
}
