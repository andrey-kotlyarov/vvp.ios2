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
    
    
    
    var myRowIndex: Int = -1
    
    
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
       
        
        //self.separatorInset = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)
        //self.layoutMargins = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)
        
        self.viewThumb_constraintH.constant = VIM_DesignData.current.viewerThumbLarge_H
        
        
        
        
        //
        // User Icon Mask setting
        //
        self.imgUserIconMask.image = imgUserIconMask.image?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        self.imgUserIconMask.tintColor = UIColor.white
        
        
        
        
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
    
    
    
    func updateByStream(_ stream: VIM_Stream, theRowIndex: Int)
    {
        self.myRowIndex = theRowIndex
        
        self.viewStatus.backgroundColor = VIM_DesignData.current.getColorForStreamState(stream.state)
        self.lblStatus.text = VIM_DesignData.current.getTitleForStreamState(stream.state)
        
        
        
        
        
        
        self.viewDuration.backgroundColor = UIColor.black
        self.lblDuration.text = VIU_String.formatTime(duration: stream.duration)
        
        
        
        
        self.lblCaptionLine.text = stream.title
        self.lblUserLine.text = "\(stream.owner.fullName) - \(stream.connectedUsers) views"
        self.lblOrgLine.text = stream.desc
        
        
        self.imgUserIcon.image = VIU_UI.getImageLetter(stream.owner.fullName, frame: imgUserIcon.frame)
    }


}
