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
    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    var post: PFObject! {
        didSet {
            let author = post["author"] as? PFUser
            self.authorLabel.text = author?["username"] as? String
            self.captionLabel.text = post["caption"] as? String
            
            let imageFile = post["topImage"] as! PFFile
            imageFile.getDataInBackgroundWithBlock { (imageData: NSData?, error: NSError?) in
                if error == nil {
                    if let imageData = imageData {
                        self.pictureImageView.image = UIImage(data: imageData)
                    }
                }
            }
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
