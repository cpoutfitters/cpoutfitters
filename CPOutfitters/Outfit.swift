//
//  Outfit.swift
//  CPOutfitters
//
//  Created by Aditya Purandare on 08/03/16.
//  Copyright © 2016 SnazzyLLama. All rights reserved.
//

import UIKit
import Parse

class Outfit: PFObject {
    
    var name: String?
    var components: [Article]?
    var favorite: Bool?
    var sharedWith: [PFUser]?
    var lastWorn: NSDate?
    var useCount: Int = 0
    
    init(object: PFObject) {
        super.init()

        self.name = object["name"] as? String
        self.components = object["articles"] as? [Article]
        self.favorite = object["favorite"] as? Bool
        self.sharedWith = object["shared_with"] as? [PFUser]
        self.lastWorn = object["last_worn"] as? NSDate
        self.useCount = (object["use_count"] as? Int) ?? 0
    }

}
