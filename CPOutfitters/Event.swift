//
//  Event.swift
//  CPOutfitters
//
//  Created by Aditya Purandare on 11/03/16.
//  Copyright © 2016 SnazzyLLama. All rights reserved.
//

import UIKit
import Parse

class Event: PFObject {
    
    var host: String?
    var details: String?
    var date: NSDate?
    var title: String?
    var invited: [PFUser]?
    var attending: [PFUser]?
    var notAttending: [PFUser]?
    var outfits: [PFUser: Outfit]?
    
    override class func initialize() {
        struct Static {
            static var onceToken : dispatch_once_t = 0;
        }
        dispatch_once(&Static.onceToken) {
            self.registerSubclass()
        }
    }
    
    static func parseClassName() -> String {
        return "Event"
    }
    
    override init() {
        super.init()
    }
    
    init(object: PFObject) {
        super.init()
        
        self.host = object["host"] as? String
        self.details = object["details"] as? String
        self.date = object["date"] as? NSDate
        self.title = object["title"] as? String
        self.invited = object["invited"] as? [PFUser]
        self.attending = object["attending"] as? [PFUser]
        self.notAttending = object["not_attending"] as? [PFUser]
        self.outfits = object["outfit"] as? [PFUser: Outfit]
    }
}
