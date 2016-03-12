//
//  User.swift
//  CPOutfitters
//
//  Created by Aditya Purandare on 11/03/16.
//  Copyright © 2016 SnazzyLLama. All rights reserved.
//

import UIKit
import Parse

class User: PFObject {

    var username: String?
    var email: String?
    var friends: [PFUser]?
    var profileImage: PFFile?
    var bio: String?
    
}
