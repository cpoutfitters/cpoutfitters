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
import ChameleonFramework

class SocialTypeCell: UITableViewCell {
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    @IBOutlet weak var topImageView: PFImageView!
    @IBOutlet weak var bottomImageView: PFImageView!
    @IBOutlet weak var footwearImageView: PFImageView!
    @IBOutlet weak var profileImageView: PFImageView!
    
    @IBOutlet weak var topImageAverageColorView: UIView!
    @IBOutlet weak var bottomImageAverageColorView: UIView!
    
    
    
    var post: PFObject! {
        didSet {
            let author = post["author"] as? PFUser
            self.authorLabel.text = author?["fullname"] as? String
            self.captionLabel.text = post["caption"] as? String
            
            //profileImageView.image = author?["profilePicture"] as? PFFile
            
            if let profileImageFile = author?["profilePicture"] as? PFFile {
                profileImageFile.getDataInBackgroundWithBlock({ (imageData: NSData?, error: NSError?) in
                    if error == nil {
                        if let imageData = imageData {
                            self.profileImageView.image = UIImage(data: imageData)
                        }
                    }
                })
            }
            
            if let topImageFile = post["topImage"] as? PFFile {
                topImageFile.getDataInBackgroundWithBlock({ (imageData: NSData?, error: NSError?) in
                    if error == nil {
                        if let imageData = imageData {
                            self.topImageView.image = UIImage(data: imageData)
                            self.topImageAverageColorView.backgroundColor = UIColor(averageColorFromImage: self.topImageView.image)
                        }
                    }
                })
            }
            
            if let bottomImageFile = post?["bottomImage"] as? PFFile {
                bottomImageFile.getDataInBackgroundWithBlock({ (imageData: NSData?, error: NSError?) in
                    if error == nil {
                        if let imageData = imageData {
                            self.bottomImageView.image = UIImage(data: imageData)
                            self.bottomImageAverageColorView.backgroundColor = UIColor(averageColorFromImage: self.bottomImageView.image)
                        }
                    }
                })
            }
            
            if let footwearImageFile = post?["footwearImage"] as? PFFile {
                footwearImageFile.getDataInBackgroundWithBlock({ (imageData: NSData?, error: NSError?) in
                    if error == nil {
                        if let imageData = imageData {
                            self.footwearImageView.image = UIImage(data: imageData)
                        }
                    }
                })
            }
            
            
            //topImageView.image
            
            
            
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
