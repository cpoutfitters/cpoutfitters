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

    var owner: User?
    var requestors: [User]?
    var createdDate: NSDate?
    var lastModified: NSDate?
    var comments: [Message]?
    
    override init() {
        super.init()
    }
    
    init(object: PFObject) {
        super.init()
        
        self.owner = object["owner"] as? User
        self.requestors = object["requestors"] as? [User]
        self.createdDate = object.createdAt!
        self.lastModified = object.updatedAt!
        self.comments = object["comments"] as? [Message]
    }
}
