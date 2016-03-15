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
    
    var date: NSDate?
    var outfit: Outfit?
    var owner: PFUser?
    var sharedWith: [PFUser]?
    var feedback: String?
    
    init(object: PFObject) {
        super.init()
        
        self.date = object["date"] as? NSDate
        self.outfit = object["outfit"] as? Outfit
        self.owner = object["owner"] as? PFUser
        self.sharedWith = object["shared_with"] as? [PFUser]
        self.feedback = object["feedback"] as? String
    }
}
