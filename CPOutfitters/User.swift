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

    var friends: [User]?
    var profileImage: PFFile?
    var bio: String?
    var sharedWith: [User]?
    
    override init() {
        super.init()
    }
    
    init(object: PFObject) {
        super.init()
        
        self.friends = object["friends"] as? [User]
        self.profileImage = object["profile_image"] as? PFFile
        self.bio = object["bio"] as? String
        self.sharedWith = object["shared_with"] as? [User]
    }
}
