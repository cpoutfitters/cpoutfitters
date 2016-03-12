//
//  Wardrobe.swift
//  CPOutfitters
//
//  Created by Eric Gonzalez on 3/9/16.
//  Copyright © 2016 SnazzyLLama. All rights reserved.
//

import UIKit
import Parse

class Wardrobe: PFObject {
    
    var sharedWith: [PFUser]?
    var savedOutfits: [Outfit]?
    var articles: [Article]?
    
    init(object: PFObject) {
        super.init()

        self.sharedWith = object["shared_with"] as? [PFUser]
        self.savedOutfits = object["favorite_outfits"] as? [Outfit]
        self.articles = object["articles"] as? [Article]
    }
}
