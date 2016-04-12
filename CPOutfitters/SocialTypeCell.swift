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
    @IBOutlet weak var imageContainerView: UIView!
    
    var topImageView: UIImageView!
    var bottomImageView: UIImageView!
    var footwearImageView: UIImageView!
    var imageViewArray = [UIImageView]()
    
    var post: PFObject! {
        didSet {
            let author = post["author"] as? PFUser
            self.authorLabel.text = author?["username"] as? String
            self.captionLabel.text = post["caption"] as? String
            
//            let imageFile = post["topImage"] as! PFFile
//            imageFile.getDataInBackgroundWithBlock { (imageData: NSData?, error: NSError?) in
//                if error == nil {
//                    if let imageData = imageData {
//                        self.pictureImageView.image = UIImage(data: imageData)
//                    }
//                }
//            }
            let topImageFile = post["topImage"] as? PFFile
            let bottomImageFile = post["bottomImage"] as? PFFile
            let footwearImageFile = post["footwearImage"] as? PFFile
            var imageArray = [PFFile]()
            
            if let topImageFile = topImageFile {
                imageArray.append(topImageFile)
            }
            if let bottomImageFile = bottomImageFile {
                imageArray.append(bottomImageFile)
            }
            if let footwearImageFile = footwearImageFile {
                imageArray.append(footwearImageFile)
            }
            
            setupImages(imageArray.count)
            
            for (index, image) in imageArray.enumerate() {
                image.getDataInBackgroundWithBlock { (imageData: NSData?, error: NSError?) in
                    if error == nil {
                        if let imageData = imageData {
                            self.imageViewArray[index].image = UIImage(data: imageData)
                            self.imageViewArray[index].layer.anchorPoint = CGPointMake(0.0, 0.0)
                            self.imageContainerView.addSubview(self.imageViewArray[index])
                            print(self.imageViewArray[index].bounds)
                        }
                    }
                }
            }
        }
    }
    
    func setupImages(count: Int) {
        switch count {
        case 1:
            topImageView = UIImageView()
            imageContainerView.addSubview(topImageView)
            topImageView.frame = CGRect(origin: imageContainerView.bounds.origin, size: imageContainerView.bounds.size)
            imageViewArray.append(topImageView)
        case 2:
            topImageView = UIImageView()
            bottomImageView = UIImageView()
            imageContainerView.addSubview(topImageView)
            bottomImageView.addSubview(bottomImageView)
            topImageView.frame = CGRect(origin: imageContainerView.bounds.origin, size: CGSize(width: imageContainerView.bounds.width / 2, height: imageContainerView.bounds.height / 2))
            bottomImageView.frame = CGRect(origin: CGPoint(x: imageContainerView.bounds.width / 2, y: imageContainerView.bounds.height / 2), size: CGSize(width: imageContainerView.bounds.width / 2, height: imageContainerView.bounds.height / 2))
            imageViewArray.append(topImageView)
            imageViewArray.append(bottomImageView)
        case 3:
            topImageView = UIImageView()
            bottomImageView = UIImageView()
            footwearImageView = UIImageView()
            imageContainerView.addSubview(topImageView)
            imageContainerView.addSubview(bottomImageView)
            imageContainerView.addSubview(footwearImageView)
            topImageView.frame = CGRect(origin: imageContainerView.bounds.origin, size: CGSize(width: imageContainerView.bounds.width / 3, height: imageContainerView.bounds.height / 3))
            bottomImageView.frame = CGRect(origin: CGPoint(x: imageContainerView.bounds.width / 3, y: imageContainerView.bounds.height / 3), size: CGSize(width: imageContainerView.bounds.width / 3, height: imageContainerView.bounds.height / 3))
            footwearImageView.frame = CGRect(origin: CGPoint(x: 2 * imageContainerView.bounds.width / 3, y: 2 * imageContainerView.bounds.height / 3), size: CGSize(width: imageContainerView.bounds.width / 3, height: imageContainerView.bounds.height / 3))
            imageViewArray.append(topImageView)
            imageViewArray.append(bottomImageView)
            imageViewArray.append(footwearImageView)
        default:
            print("Error: Invalid number of items in imageArray")
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
