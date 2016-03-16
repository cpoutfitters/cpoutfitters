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
    
    var owner: User?
    var date: NSDate?
    var outfit: Outfit?
    var sharedWith: [User]?
    
    override class func initialize() {
        struct Static {
            static var onceToken : dispatch_once_t = 0;
        }
        dispatch_once(&Static.onceToken) {
            self.registerSubclass()
        }
    }
    
    static func parseClassName() -> String {
        return "OutfitHistory"
    }
    
    override init() {
        super.init()
    }
    
    init(object: PFObject) {
        super.init()
        
        self.owner = object["owner"] as? User
        self.date = object["date"] as? NSDate
        self.outfit = object["outfit"] as? Outfit
        self.sharedWith = object["shared_with"] as? [User]
    }
}
