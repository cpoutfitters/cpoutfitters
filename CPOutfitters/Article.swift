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
    var useCount: Int?
    
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
        self.useCount = object["use_count"] as? Int
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
    
    class func fetchArticlesWithCompletion(completion completion:([PFObject]?, NSError?) -> ()) {
        let query = PFQuery(className: "Article")
        query.limit = 40
        query.findObjectsInBackgroundWithBlock(completion)
    }
    
    class func loadProfileImageWithCompletion(params: NSDictionary, completion:([PFObject]?, NSError?) -> ()) {
        let obj = params
        var userName: String?
        for (key, value) in obj {
            userName = value as? String
        }
        print(userName!)
        let query = PFQuery(className: "_User")
        query.whereKey("username", equalTo: userName!)
        query.limit = 20
        query.findObjectsInBackgroundWithBlock(completion)
    }
    
    class func searchPostsWithCompletion(params: NSDictionary, completion:([PFObject]?, NSError?) -> ()) {
        let obj = params
        var searchKey: String?
        var searchValue: String?
        for (key, value) in obj {
            searchKey = key as? String
            searchValue = value as? String
        }
        print("Key: \(searchKey!), Value: \(searchValue!)")
        let query = PFQuery(className: "Post")
        query.whereKey(searchKey!, containsString: searchValue!)
        query.orderByDescending("timestamp")
        query.limit = 20
        query.findObjectsInBackgroundWithBlock(completion)
    }

}
