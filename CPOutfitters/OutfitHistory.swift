//
//  ScheduledOutfit.swift
//  CPOutfitters
//
//  Created by Aditya Purandare on 11/03/16.
//  Copyright © 2016 SnazzyLLama. All rights reserved.
//

import UIKit
import Parse

class OutfitHistory: PFObject {
    
    var userId: String?
    var date: NSDate?
    var outfit: Outfit?
    var sharedWith: [User]?
    
    override init() {
        super.init()
    }
    
    init(object: PFObject) {
        super.init()
        
        self.userId = object["user_id"] as? String
        self.date = object["date"] as? NSDate
        self.outfit = object["outfit"] as? Outfit
        self.sharedWith = object["shared_with"] as? [User]
    }
}
