//
//  Artifact.swift
//  CPOutfitters
//
//  Created by Aditya Purandare on 07/03/16.
//  Copyright © 2016 SnazzyLLama. All rights reserved.
//

import UIKit
import Parse

class Article: PFObject, PFSubclassing {
    
    var type: String?
    var short: Bool?
    var primaryColor: String?
    var primaryColorCategories: [String]?
    var attire: [String]?
    var favorite: Bool?
    var sharedWith: [PFUser]?
    var mediaImage: PFFile?
    var lastWorn: NSDate?
    var useCount: Int = 0
    
    override class func initialize() {
        struct Static {
            static var onceToken : dispatch_once_t = 0;
        }
        dispatch_once(&Static.onceToken) {
            self.registerSubclass()
        }
    }
    
    static func parseClassName() -> String {
        return "Article"
    }
    
    class func createWithObject(object: PFObject) -> Article {
        let article = Article()
        
        article.type = object["type"] as? String
        article.short = object["short"] as? Bool
        article.primaryColor = object["primary_color"] as? String
        article.primaryColorCategories = object["primary_color_categories"] as? [String]
        article.attire = object["attire"] as? [String]
        article.favorite = object["favorite"] as? Bool
        article.sharedWith = object["shared_with"] as? [PFUser]
        article.mediaImage = object["image"] as? PFFile
        article.lastWorn = object["last_worn"] as? NSDate
        article.useCount = (object["use_count"] as? Int) ?? 0
        
        return article
    }
    
    class func articlesWithArray(array: [PFObject]) -> [Article] {
        var articles = [Article]()
        for element in array {
            articles.append(Article.createWithObject(element))
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
