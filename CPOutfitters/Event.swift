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
    
    var host: User?
    var details: String?
    var date: NSDate?
    var title: String?
    var invited: [PFUser]?
    var attending: [PFUser]?
    var not_attending: [PFUser]?
    var outfit: Outfit?
}
