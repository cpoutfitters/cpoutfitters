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
}
