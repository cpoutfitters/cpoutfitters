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
    
    @NSManaged var owner: PFUser
    @NSManaged var type: String
    @NSManaged var short: Bool
    @NSManaged var primaryColor: String
    @NSManaged var primaryColorCategories: [String]
    @NSManaged var occasion: [String]
    @NSManaged var favorite: Bool
    @NSManaged var sharedWith: [PFUser]
    @NSManaged var mediaImage: PFFile
    @NSManaged var swatchImage: PFFile
    @NSManaged var lastWorn: NSDate
    @NSManaged var useCount: Int
    
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
    
    
    class func articlesWithArray(array: [PFObject]) -> [Article] {
        var articles = [Article]()
        for element in array {
//            articles.append(Article(object: element))
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
