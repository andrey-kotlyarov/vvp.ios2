//
//  VIL_LoginTableViewCell.swift
//  vvp
//
//  Created by Andrey Kotlyarov on 06.09.17.
//  Copyright © 2017 Virtual Video Pass. All rights reserved.
//

import UIKit

class VIL_LoginTableViewCell: UITableViewCell
{
    @IBOutlet var txtField: UITextField!

    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
        
        self.separatorInset = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)
        self.layoutMargins = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
