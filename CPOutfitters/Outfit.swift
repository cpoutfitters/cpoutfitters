//
//  Outfit.swift
//  CPOutfitters
//
//  Created by Aditya Purandare on 08/03/16.
//  Copyright © 2016 SnazzyLLama. All rights reserved.
//

import UIKit
import Parse

class Outfit: PFObject, PFSubclassing {
    
    @NSManaged var owner: PFUser!
    @NSManaged var topComponent: Article
    @NSManaged var bottomComponent: Article
    @NSManaged var footwearComponent: Article
    @NSManaged var favorite: Bool
    @NSManaged var lastWorn: NSDate?
    @NSManaged var useCount: Int
    
    override class func initialize() {
        struct Static {
            static var onceToken : dispatch_once_t = 0;
        }
        dispatch_once(&Static.onceToken) {
            self.registerSubclass()
        }
    }
    
    static func parseClassName() -> String {
        return "Outfit"
    }
}
