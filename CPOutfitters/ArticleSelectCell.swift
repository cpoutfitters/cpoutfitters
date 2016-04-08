//
//  ArticleSelectCell.swift
//  CPOutfitters
//
//  Created by Aditya Purandare on 06/04/16.
//  Copyright © 2016 SnazzyLLama. All rights reserved.
//

import UIKit

class ArticleSelectCell: UICollectionViewCell {
    
    @IBOutlet weak var articleImageView: UIImageView!
    
    var article: Article! {
        didSet{
            let articleImageFile = article.mediaImage
            
            articleImageFile.getDataInBackgroundWithBlock {
                (imageData: NSData?, error: NSError?) -> Void in
                if let imageData = imageData {
                    self.articleImageView.image = UIImage(data:imageData)
                }
            }
        }
    }
}
