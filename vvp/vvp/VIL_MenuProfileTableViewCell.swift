//
//  VIL_MenuProfileTableViewCell.swift
//  vvp
//
//  Created by Andrey Kotlyarov on 10.09.17.
//  Copyright © 2017 Virtual Video Pass. All rights reserved.
//

import UIKit

class VIL_MenuProfileTableViewCell: UITableViewCell
{
    
    @IBOutlet var lblFullName: UILabel!
    @IBOutlet var lblNickname: UILabel!
    
    @IBOutlet var viewUserIcon: UIView!
    @IBOutlet var imgUserIcon: UIImageView!
    @IBOutlet var imgUserIconMask: UIImageView!
    
    
    
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
        
        imgUserIconMask.image = imgUserIconMask.image?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        imgUserIconMask.tintColor = UIColor.white
        
        
        self.viewUserIcon.backgroundColor = UIColor.lightGray.withAlphaComponent(0.25)
        
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    func myUpdateCell(profile: VIM_Profile)
    {
        lblFullName.text = "\(profile.firstName) \(profile.lastName)"
        lblNickname.text = "\(profile.username)"
        
        imgUserIcon.image = VIU_UI.getImageLetter(profile.fullName, frame: imgUserIcon.frame)
    }
    
}
