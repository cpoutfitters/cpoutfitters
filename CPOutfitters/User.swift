//
//  User.swift
//  CPOutfitters
//
//  Created by Aditya Purandare on 11/03/16.
//  Copyright © 2016 SnazzyLLama. All rights reserved.
//

import UIKit
import Parse

class User: PFUser {

    var friends: [String]?
    var profileImage: PFFile?
    var bio: String?
    var sharedWith: [String]?
    
    override class func initialize() {
        struct Static {
            static var onceToken : dispatch_once_t = 0;
        }
        dispatch_once(&Static.onceToken) {
            self.registerSubclass()
        }
    }

    override init() {
        super.init()
    }
    
    init(object: PFUser) {
        super.init()
        
        self.friends = object["friends"] as? [String]
        self.profileImage = object["profile_image"] as? PFFile
        self.bio = object["bio"] as? String
        self.sharedWith = object["shared_with"] as? [String]
    }
}
