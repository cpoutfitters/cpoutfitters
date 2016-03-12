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

    var user: User?
    var requestor: User?
    var outfit: Outfit?
    var createdDate: NSDate?
    var lastModified: NSDate?
    var comments: [String]?
}
