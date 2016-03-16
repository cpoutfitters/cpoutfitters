//
//  Feedback.swift
//  CPOutfitters
//
//  Created by Aditya Purandare on 11/03/16.
//  Copyright © 2016 SnazzyLLama. All rights reserved.
//

import UIKit
import Parse

class Feedback: PFObject, PFSubclassing {

    var owner: User?
    var outfit: Outfit?
    var requestors: [User]?
    var createdDate: NSDate?
    var lastModified: NSDate?
    var comments: [Message]?
    
    override class func initialize() {
        struct Static {
            static var onceToken : dispatch_once_t = 0;
        }
        dispatch_once(&Static.onceToken) {
            self.registerSubclass()
        }
    }
    
    static func parseClassName() -> String {
        return "Feedback"
    }
    
    override init() {
        super.init()
    }
    
    init(object: PFObject) {
        super.init()
        
        self.owner = object["owner"] as? User
        self.outfit = object["outfit"] as? Outfit
        self.requestors = object["requestors"] as? [User]
        self.createdDate = object.createdAt!
        self.lastModified = object.updatedAt!
        self.comments = object["comments"] as? [Message]
    }
}
