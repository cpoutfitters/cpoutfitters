//
//  Feedback.swift
//  CPOutfitters
//
//  Created by Aditya Purandare on 11/03/16.
//  Copyright © 2016 SnazzyLLama. All rights reserved.
//

import UIKit
import Parse

class Feedback: PFObject {

    var user: PFUser?
    var requestor: PFUser?
    var outfit: Outfit?
    var createdDate: NSDate?
    var lastModified: NSDate?
    var comments: [String]?
    
    init(object: PFObject) {
        super.init()
        
        self.user = object["user"] as? PFUser
        self.requestor = object["requestor"] as? PFUser
        self.outfit = object["outfit"] as? Outfit
        self.createdDate = object.createdAt!
        self.lastModified = object.updatedAt!
        self.comments = object["comments"] as? [String]
    }
}
