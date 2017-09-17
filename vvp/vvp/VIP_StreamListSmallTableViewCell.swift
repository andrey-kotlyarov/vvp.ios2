//
//  VIP_StreamListSmallTableViewCell.swift
//  vvp
//
//  Created by Andrey Kotlyarov on 17.09.17.
//  Copyright © 2017 Virtual Video Pass. All rights reserved.
//

import UIKit



class VIP_StreamListSmallTableViewCell: UITableViewCell
{

    @IBOutlet var viewThumb_constraintW: NSLayoutConstraint!
    @IBOutlet var viewThumb_constraintH: NSLayoutConstraint!
    @IBOutlet var viewThumb: UIView!
    @IBOutlet var imgThumb: UIImageView!
    
    @IBOutlet var viewStatus: UIView!
    @IBOutlet var lblStatus: UILabel!
    @IBOutlet var viewDuration: UIView!
    @IBOutlet var lblDuration: UILabel!
    
    
    @IBOutlet var viewCaption_constraintH: NSLayoutConstraint!
    @IBOutlet var viewCaption: UIView!
    //@IBOutlet var viewUserIcon: UIView!
    //@IBOutlet var imgUserIcon: UIImageView!
    //@IBOutlet var imgUserIconMask: UIImageView!
    
    
    @IBOutlet var lblCaptionLine: UILabel!
    @IBOutlet var lblUserLine: UILabel!
    @IBOutlet var lblOrgLine: UILabel!
    
    
    var myRowIndex: Int = -1
    
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
        
        self.separatorInset = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)
        self.layoutMargins = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)
        
        self.viewThumb_constraintW.constant = VIM_DesignData.current.viewerThumbSmall_W
        self.viewThumb_constraintH.constant = VIM_DesignData.current.viewerThumbSmall_H
        self.viewCaption_constraintH.constant = VIM_DesignData.current.viewerThumbSmall_H
        
        
        
        
        //
        // User Icon Mask setting
        //
        //imgUserIconMask.image = imgUserIconMask.image?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        //imgUserIconMask.tintColor = UIColor.white
        
        
        
        
        self.viewThumb.backgroundColor = UIColor.lightGray.withAlphaComponent(0.25)
        self.viewCaption.backgroundColor = UIColor.white.withAlphaComponent(0.00)
        //self.viewUserIcon.backgroundColor = UIColor.lightGray.withAlphaComponent(0.25)
        
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
        self.lblDuration.text = stream.formatDuration()
        
        
        lblCaptionLine.text = stream.title
        lblUserLine.text = "\(stream.owner) - \(stream.connectedUsers) views"
        lblOrgLine.text = stream.desc
        
        
        //imgUserIcon.image = VIU_UI.getImageLetter(stream.owner, frame: imgUserIcon.frame)
    }
    
    
}
