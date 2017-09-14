//
//  VIP_StreamListTableViewCell.swift
//  vvp
//
//  Created by Andrey Kotlyarov on 12.09.17.
//  Copyright © 2017 Virtual Video Pass. All rights reserved.
//

import UIKit

class VIP_StreamListTableViewCell: UITableViewCell
{
    
    @IBOutlet var viewThumb_constraintH: NSLayoutConstraint!
    @IBOutlet var viewThumb: UIView!
    @IBOutlet var imgThumb: UIImageView!
    
    @IBOutlet var viewStatus: UIView!
    @IBOutlet var lblStatus: UILabel!
    @IBOutlet var viewDuration: UIView!
    @IBOutlet var lblDuration: UILabel!
    
    
    
    @IBOutlet var viewCaption: UIView!
    @IBOutlet var viewUserIcon: UIView!
    @IBOutlet var imgUserIcon: UIImageView!
    @IBOutlet var imgUserIconMask: UIImageView!
    
    
    @IBOutlet var lblCaptionLine: UILabel!
    @IBOutlet var lblUserLine: UILabel!
    @IBOutlet var lblOrgLine: UILabel!
    
    
    
    
    
    
    
    func updateByStream(_ stream: VIM_Stream)
    {
        self.viewStatus.backgroundColor = VIM_DesignData.current.getColorForStreamState(stream.state)
        self.lblStatus.text = VIM_DesignData.current.getTitleForStreamState(stream.state)
        
        
        
        
        
        
        self.viewDuration.backgroundColor = UIColor.black
        self.lblDuration.text = stream.formatDuration()
        
        
        
        
        lblCaptionLine.text = stream.title
        lblUserLine.text = "\(stream.owner) - \(stream.connectedUsers) views"
        lblOrgLine.text = stream.desc
        //lblOrgLine.text = "\(stream.formatOwnerLetter()) - " + stream.desc
        
        
        imgUserIcon.image = getImageLetter(stream.formatOwnerLetter())
        
        
        
        
        
        if stream.thumbnailImage != nil
        {
            self.imgThumb.image = stream.thumbnailImage
        }
        else
        {
            self.imgThumb.image = nil
            
            let session = URLSession.shared
            var task = URLSessionDownloadTask()
            
            
            //
            //DEBUG
            //
            print("load image - start \(Date())")
            
            let url: URL! = URL(string: stream.thumbnailSrc)
            task = session.downloadTask(
                with: url,
                completionHandler:
                {
                    (location: URL?, response: URLResponse?, error: Error?) -> Void in
                    
                    
                    if let data = try? Data(contentsOf: url)
                    {
                        DispatchQueue.main.async(
                            execute:
                            {
                                () -> Void in
                                
                                let img: UIImage! = UIImage(data: data)
                                
                                // не туда!!!
                                self.imgThumb.image = img
                                
                                
                                stream.thumbnailImage = img
                                //tableView.reloadData()
                                
                                
                                //DEBUG
                                print("load image - done \(Date())")
                            }
                        )
                    }
                }
            )
            task.resume()
            //
            //
            //
            
        }
    }
    
    
    
    
    
    private func getImageLetter(_ letter: Character) -> UIImage?
    {
        let bgColor = VIM_DesignData.current.getBGColorForLetter(letter)
        let textColor = UIColor.white
        let textFont = UIFont(name: "Helvetica Bold", size: 29)!
        
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(imgUserIcon.frame.size, false, scale)
        bgColor.set()
        UIRectFill(imgUserIcon.frame)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.center
        
        let textFontAttributes = [
            NSFontAttributeName: textFont,
            NSForegroundColorAttributeName: textColor,
            NSParagraphStyleAttributeName: paragraphStyle,
            NSBaselineOffsetAttributeName: -3.5,
            ] as [String : Any]
        image?.draw(in: CGRect(origin: CGPoint.zero, size: imgUserIcon.frame.size))
        
        let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: imgUserIcon.frame.size)
        String(letter).draw(in: rect, withAttributes: textFontAttributes)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
        
        self.separatorInset = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)
        self.layoutMargins = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)
        
        self.viewThumb_constraintH.constant = VIM_DesignData.current.viewerThumbLarge_H
        
        
        
        
        //
        // User Icon Mask setting
        //
        imgUserIconMask.image = imgUserIconMask.image?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        imgUserIconMask.tintColor = UIColor.white
        
        
        
        
        
        
        
        
        
        
        
        
        
        self.viewThumb.backgroundColor = UIColor.lightGray.withAlphaComponent(0.25)
        self.viewCaption.backgroundColor = UIColor.white.withAlphaComponent(0.00)
        self.viewUserIcon.backgroundColor = UIColor.lightGray.withAlphaComponent(0.25)
        
        self.viewStatus.backgroundColor = VIM_DesignData.current.colorRed.withAlphaComponent(0.75)
        self.viewDuration.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        
    }
    
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
