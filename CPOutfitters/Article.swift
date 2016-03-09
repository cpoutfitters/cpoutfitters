//
//  Artifact.swift
//  CPOutfitters
//
//  Created by Aditya Purandare on 07/03/16.
//  Copyright © 2016 SnazzyLLama. All rights reserved.
//

import UIKit
import Parse

class Article: PFObject {
    
    var wardrobe_id: String?
    var type: String?
    var short: Bool?
    var primary_color: String?
    var primary_color_categories: [String]?
    var attire: [String]?
    var favorite: Bool?
    var shared_with: [String]?
    var image: PFFile?
    var last_worn: NSDate?
    var use_count: Int?
    
    init(object: PFObject) {
        super.init()
        
        self.wardrobe_id = "\(object["wardrobe_id"])"
        self.type = object["type"] as? String
        self.short = object["short"] as? Bool
        self.primary_color = object["primary_color"] as? String
        self.primary_color_categories = object["primary_color_categories"] as? [String]
        self.attire = object["attire"] as? [String]
        self.favorite = object["favorite"] as? Bool
        self.shared_with = object["shared_with"] as? [String]
        self.image = object["image"] as? PFFile
        self.last_worn = object["last_worn"] as? NSDate
        self.use_count = object["user_count"] as? Int
    }
    
    class func articleWithArray(array: [PFObject]) -> [Article] {
        var articles = [Article]()
        for element in array {
            articles.append(Article(object: element))
        }
        return articles
    }

}
