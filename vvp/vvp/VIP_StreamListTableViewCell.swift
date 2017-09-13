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
    @IBOutlet var imgThumbnail: UIImageView!
    @IBOutlet var imgThumbnail_constraintH: NSLayoutConstraint!

    @IBOutlet var imgUserIcon: UIImageView!
    @IBOutlet var lblStreamTitle: UILabel!
    @IBOutlet var lblUserLine: UILabel!
    @IBOutlet var lblOrgLine: UILabel!
    
    
    
    func updateByStream(_ stream: VIM_Stream)
    {
        imgThumbnail.backgroundColor = UIColor.lightGray
        imgUserIcon.backgroundColor = UIColor.red
        
        
        imgThumbnail.image = stream.thumbnailImage
        /*
        do
        {
            let url = URL(string: stream.thumbnailSrc)
            let imgData = try Data(contentsOf: url!)
            imgThumbnail.image = UIImage(data: imgData)
        }
        catch
        {
            print("ERROR!!!")
        }
        */
        
        lblStreamTitle.text = stream.title
        lblUserLine.text = "\(stream.owner) - \(stream.connectedUsers) views"
        lblOrgLine.text = stream.desc
    }
    
    
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
        
        self.separatorInset = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)
        self.layoutMargins = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)
        
        imgThumbnail_constraintH.constant = VIM_DesignData.current.viewerThumb_H
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
