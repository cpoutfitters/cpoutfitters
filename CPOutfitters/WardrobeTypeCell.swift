//
//  WardrobeTypeCell.swift
//  CPOutfitters
//
//  Created by Eric Gonzalez on 3/10/16.
//  Copyright © 2016 SnazzyLLama. All rights reserved.
//

import UIKit
import ParseUI

class WardrobeTypeCell: UICollectionViewCell {

    @IBOutlet weak var articleView: PFImageView!
    
    var article: Article! {
        didSet {
            articleView.file = article.mediaImage
            articleView.loadInBackground()
        }
    }
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
