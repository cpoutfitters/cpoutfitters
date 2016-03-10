//
//  WardrobeTypeCell.swift
//  CPOutfitters
//
//  Created by Eric Gonzalez on 3/10/16.
//  Copyright © 2016 SnazzyLLama. All rights reserved.
//

import UIKit

class WardrobeTypeCell: UITableViewCell {

    @IBOutlet weak var pictureView: UIImageView!
    @IBOutlet weak var labelView: UILabel!
    
    var type: String! {
        didSet {
            labelView.text = type
            
            switch(type) {
                case "Tops": fallthrough
                case "Bottoms": fallthrough
                case "Shoes": fallthrough
            default: break
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
