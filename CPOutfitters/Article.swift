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
    
    var type: String?
    var short: Bool?
    var primaryColor: String?
    var primaryColorCategories: [String]?
    var attire: [String]?
    var favoriteStatus: Bool?
    var sharedWith: [PFUser]?
    var mediaImage: PFFile?
    var lastWorn: NSDate?
    var useCount: Int = 0
    
    init(object: PFObject) {
        super.init()
        
        self.type = object["type"] as? String
        self.short = object["short"] as? Bool
        self.primaryColor = object["primary_color"] as? String
        self.primaryColorCategories = object["primary_color_categories"] as? [String]
        self.attire = object["attire"] as? [String]
        self.favoriteStatus = object["favorite"] as? Bool
        self.sharedWith = object["shared_with"] as? [PFUser]
        self.mediaImage = object["image"] as? PFFile
        self.lastWorn = object["last_worn"] as? NSDate
        self.useCount = (object["use_count"] as? Int) ?? 0
    }
    
    class func articlesWithArray(array: [PFObject]) -> [Article] {
        var articles = [Article]()
        for element in array {
            articles.append(Article(object: element))
        }
        return articles
    }
    
    class func getPFFileFromImage(image: UIImage?) -> PFFile? {
        if let image = image {
            if let imageData = UIImagePNGRepresentation(image) {
                return PFFile(name: "image.png", data: imageData)
            }
        }
        return nil
    }
}
