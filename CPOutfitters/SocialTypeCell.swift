//
//  SocialTypeCell.swift
//  CPOutfitters
//
//  Created by Cory Thompson on 4/4/16.
//  Copyright © 2016 SnazzyLLama. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class SocialTypeCell: UITableViewCell {
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    @IBOutlet weak var topImageView: PFImageView!
    @IBOutlet weak var bottomImageView: PFImageView!
    @IBOutlet weak var footwearImageView: PFImageView!
    @IBOutlet weak var profileImageView: PFImageView!
    
    var post: PFObject! {
        didSet {
            let author = post["author"] as? PFUser
            self.authorLabel.text = author?["fullname"] as? String
            self.captionLabel.text = post["caption"] as? String
            
            profileImageView.file = author?["profilePicture"] as? PFFile
            
            //topImageView = post["topImage"] as? PFImageView
            
//            topImageView.imageView?.image = 
//            if let imageFile = post["image"] as? PFFile {
//                imageFile.getDataInBackgroundWithBlock { (imageData: NSData?, error: NSError?) in
//                    if error == nil {
//                        if let imageData = imageData {
//                            self.pictureImageView.image = UIImage(data: imageData)
//                        }
//                    }
//                }
//            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
