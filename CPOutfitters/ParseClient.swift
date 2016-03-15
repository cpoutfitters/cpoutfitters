//
//  RestClient.swift
//  CPOutfitters
//
//  Created by Aditya Purandare on 12/03/16.
//  Copyright © 2016 SnazzyLLama. All rights reserved.
//

import UIKit
import Parse

class ParseClient: NSObject {
    
//    class var sharedInstance: ParseClient {
//        struct Static {
//            static let instance =  ParseClient()
//        }
//        return Static.instance
//    }
    static let sharedInstance = ParseClient()
    
    func fetchArticles(completion completion:([Article]?, NSError?) -> ()) {
        let query = PFQuery(className: "Article")
        query.limit = 40
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            let articleArray = Article.articlesWithArray(objects!)
            completion(articleArray, nil)
        }
    }
    
    func saveArticleWithCompletion(articleObject: Article?, completion:(success: Bool?, error: NSError?) -> ()) {
        var article = PFObject(className: "Article")
        
        article = articleObject!
        
        article["type"] = articleObject!.type!
        article["short"] = articleObject!.short!
        article["primary_color"] = articleObject!.primaryColor!
        article["primary_color_categories"] = articleObject!.primaryColorCategories!
        article["attire"] = articleObject!.attire!
        article["favorite_status"] = articleObject!.favorite!
        article["shared_with"] = articleObject!.sharedWith!
        article["media_image"] = articleObject!.mediaImage!
        article["last_worn"] = articleObject!.lastWorn!
        article["use_count"] = articleObject!.useCount
        
        article.saveInBackgroundWithBlock {
            (success: Bool?, error: NSError?) -> Void in
            if ((success) != nil) {
                completion(success: true, error: nil)
            } else {
                completion(success: false, error: error)
            }
        }
    }
    
    func fetchOutfitsWithCompletion(completion completion:([PFObject]?, NSError?) -> ()) {
        let query = PFQuery(className: "Outfit")
        query.limit = 40
        query.findObjectsInBackgroundWithBlock(completion)
    }
    
    func searchArticlesWithCompletion(searchString: String, completion:([PFObject]?, NSError?) -> ()) {

        let query = PFQuery(className: "Article")
        query.whereKey("Search Key", containsString: searchString)
        query.orderByDescending("timestamp")
        query.limit = 20
        query.findObjectsInBackgroundWithBlock(completion)
    }


}
