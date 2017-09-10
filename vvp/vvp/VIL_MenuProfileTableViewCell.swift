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
    
    
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
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
    }
    
}
