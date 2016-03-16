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
    
    var owner: User?
    var name: String?
    var components: [Article]?
    var favorite: Bool?
    var lastWorn: NSDate?
    var useCount: Int = 0
    
    override init() {
        super.init()
    }
    
    init(object: PFObject) {
        super.init()

        self.owner = object["owner"] as? User
        self.name = object["name"] as? String
        self.components = object["articles"] as? [Article]
        self.favorite = object["favorite"] as? Bool
        self.lastWorn = object["last_worn"] as? NSDate
        self.useCount = (object["use_count"] as? Int) ?? 0
    }

}
