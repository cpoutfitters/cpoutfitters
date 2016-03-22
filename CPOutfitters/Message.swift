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
    
    override class func initialize() {
        struct Static {
            static var onceToken : dispatch_once_t = 0;
        }
        dispatch_once(&Static.onceToken) {
            self.registerSubclass()
        }
    }
    
    static func parseClassName() -> String {
        return "Message"
    }
    
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
