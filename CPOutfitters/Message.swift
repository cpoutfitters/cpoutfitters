//
//  Message.swift
//  CPOutfitters
//
//  Created by Aditya Purandare on 16/03/16.
//  Copyright © 2016 SnazzyLLama. All rights reserved.
//

import UIKit
import Parse

class Message: PFObject {
    
    var author: User?
    var date: NSDate?
    var contents: String?
    
    override init() {
        super.init()
    }
    
    init(object: PFObject) {
        super.init()
        
        self.author = object["author"] as? User
        self.date = object["date"] as? NSDate
        self.contents = object["contents"] as? String
    }
}
