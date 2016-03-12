//
//  ScheduledOutfit.swift
//  CPOutfitters
//
//  Created by Aditya Purandare on 11/03/16.
//  Copyright © 2016 SnazzyLLama. All rights reserved.
//

import UIKit
import Parse

class ScheduledOutfit: PFObject {
    
    var date: NSDate?
    var outfit: Outfit?
    var owner: User?
    var sharedWith: User?
    var feedback: String?
}
