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
