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
    @IBOutlet var lblCaptionLine: UILabel!
    @IBOutlet var lblUserLine: UILabel!
    @IBOutlet var lblOrgLine: UILabel!
    
    
    
    
    
    
    
    //func updateByStream(_ stream: VIM_Stream, tableView: UITableView)
    func updateByStream(_ stream: VIM_Stream)
    {
        self.viewStatus.backgroundColor = VIM_DesignData.current.colorRed
        self.lblStatus.text = "LIVE"
        
        self.viewDuration.backgroundColor = UIColor.black
        self.lblDuration.text = stream.formatDuration()
        
        
        
        
        lblCaptionLine.text = stream.title
        lblUserLine.text = "\(stream.owner) - \(stream.connectedUsers) views"
        lblOrgLine.text = stream.desc
        
        
        
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
            
            //var letter = stream.owner.substring(to: stream.owner.index(after: 0)).uppercased()
            var letter = stream.owner.substring(to: stream.owner.index(after: stream.owner.startIndex ))

            var iv: UIImageView = UIImageView(frame: CGRect(origin: .zero, size: viewUserIcon.frame.size))
            iv.image = textToImage(drawText: letter as NSString)
            
            viewUserIcon.addSubview(iv)
            
            
        }
    }
    
    
    func textToImage(drawText text: NSString) -> UIImage
    {
        var image: UIImage! = imageWithSize(size: viewUserIcon.frame.size, filledWithColor: VIM_DesignData.current.colorBG)
        
        
        let textColor = UIColor.white
        let textFont = UIFont(name: "Helvetica Bold", size: 29)!
        
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(image.size, false, scale)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.center
        
        let textFontAttributes = [
            NSFontAttributeName: textFont,
            NSForegroundColorAttributeName: textColor,
            NSParagraphStyleAttributeName: paragraphStyle,
            NSBaselineOffsetAttributeName: -4,
            ] as [String : Any]
        image.draw(in: CGRect(origin: CGPoint.zero, size: image.size))
        
        let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: image.size)
        text.draw(in: rect, withAttributes: textFontAttributes)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    func imageWithSize(size: CGSize, filledWithColor color: UIColor = UIColor.clear, scale: CGFloat = 0.0, opaque: Bool = false) -> UIImage
    {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, opaque, scale)
        color.set()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
    
    
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
        
        self.separatorInset = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)
        self.layoutMargins = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)
        
        self.viewThumb_constraintH.constant = VIM_DesignData.current.viewerThumbLarge_H
        
        
        self.viewThumb.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        self.viewCaption.backgroundColor = UIColor.white.withAlphaComponent(0.0)
        self.viewUserIcon.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        
        self.viewStatus.backgroundColor = VIM_DesignData.current.colorRed
        self.viewDuration.backgroundColor = UIColor.black
        
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
