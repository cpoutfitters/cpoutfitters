//
//  FabricViewCell.swift
//  CPOutfitters
//
//  Created by Aditya Purandare on 22/04/16.
//  Copyright © 2016 SnazzyLLama. All rights reserved.
//

import UIKit

class FabricViewCell: UICollectionViewCell {
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    var article: Article! {
        
        didSet{
            let userImageFile = article.mediaImage
            
            userImageFile.getDataInBackgroundWithBlock {
                (imageData: NSData?, error: NSError?) -> Void in
                if error == nil {
                    if let imageData = imageData {
                        self.photoImageView.image = UIImage(data:imageData)
                    }
                }
            }
        }
    }
}
