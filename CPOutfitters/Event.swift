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
    
    //All pfusers will be user
    var host: User!
    var details: String?
    var date: NSDate?
    var title: String?
    var invited: [User]?
    var attending: [User]?
    var notAttending: [User]?
    var outfits: [User: Outfit]?
    
    init(object: PFObject) {
        super.init()
        
        self.host = object["host"] as! User
        self.details = object["details"] as? String
        self.date = object["date"] as? NSDate
        self.title = object["title"] as? String
        self.invited = object["invited"] as? [User]
        self.attending = object["attending"] as? [User]
        self.notAttending = object["not_attending"] as? [User]
        self.outfits = object["outfit"] as? [User: Outfit]
    }
}
