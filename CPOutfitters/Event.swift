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
    
    var host: PFUser?
    var details: String?
    var date: NSDate?
    var title: String?
    var invited: [PFUser]?
    var attending: [PFUser]?
    var notAttending: [PFUser]?
    var outfits: NSDictionary?
    
    init(object: PFObject) {
        super.init()
        
        self.host = object["host"] as? PFUser
        self.details = object["details"] as? String
        self.date = object["date"] as? NSDate
        self.title = object["title"] as? String
        self.invited = object["invited"] as? [PFUser]
        self.attending = object["attending"] as? [PFUser]
        self.notAttending = object["not_attending"] as? [PFUser]
        self.outfits = object["outfit"] as? NSDictionary
    }
}
