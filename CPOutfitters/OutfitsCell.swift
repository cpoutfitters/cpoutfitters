//
//  OutfitsCell.swift
//  CPOutfitters
//
//  Created by Aditya Purandare on 04/04/16.
//  Copyright © 2016 SnazzyLLama. All rights reserved.
//

import UIKit

class OutfitsCell: UITableViewCell {

    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var inverseCategoryImage: UIImageView!
    @IBOutlet weak var inverseCategoryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
