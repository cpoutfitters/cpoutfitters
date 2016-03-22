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

    static let sharedInstance = ParseClient()

    func fetchArticles(params: NSDictionary, completion:([Article]?, NSError?) -> ()) {
        let query = PFQuery(className: "Article")

        //And of predicates
        query.whereKey("user_id", equalTo: "aditya.p1993@hotmail.com")
        query.limit = 40
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            let articleArray = Article.articlesWithArray(objects!)
            completion(articleArray, nil)
        }
    }

    func saveArticle(articleObject: Article, completion:(success: Bool?, error: NSError?) -> ()) {

        let article = PFObject(className: "Article")

        article["owner"] = articleObject.owner
        article["type"] = articleObject.type
        article["short"] = articleObject.short
        article["primary_color"] = articleObject.primaryColor
        article["primary_color_categories"] = articleObject.primaryColorCategories
        article["occasion"] = articleObject.occasion
        article["favorite"] = articleObject.favorite
        article["shared_with"] = articleObject.sharedWith
        article["media_image"] = Article.getPFFileFromImage(UIImage(named: "event"))
        article["last_worn"] = articleObject.lastWorn
        article["use_count"] = articleObject.useCount

        article.saveInBackgroundWithBlock {
            (success: Bool?, error: NSError?) -> Void in
            if (success == true ) {
                print("An article stored")
                completion(success: true, error: nil)
            } else {
                print(error?.localizedDescription)
                completion(success: false, error: error)
            }
        }
    }

    func fetchOutfitsWithCompletion(completion completion:([PFObject]?, NSError?) -> ()) {
        let query = PFQuery(className: "Outfit")
        query.limit = 40
        query.findObjectsInBackgroundWithBlock(completion)
    }

    // Function for deletion of article from server
    func deleteArticle(article: Article, completion:(success: Bool?, error: NSError?) -> ()) {
        article.deleteInBackgroundWithBlock({ (success: Bool?, error: NSError?) -> Void in
            if ((success) != nil) {
                completion(success: true, error: nil)
            } else {
                completion(success: false, error: error)
            }
        })
    }
    
    //Search with conjuctions across category, color and type
    func searchArticlesWithParams(params: NSDictionary, completion:() ->()) {
        
//        let searchValue: String?
//        searchValue = params["search"]
//        searchValue?.characters.split {$0 == " "}.map(String.init)
//        
//        let predicate = NSPredicate(format: " AND ")
//        let query = PFQuery(className: "Article", predicate: predicate)
//        query.whereKey("Search Key", containsString: searchString)
//        query.whereKey("Search Key", containsString: searchString)
//
//        query.whereKey("Search Key", containsString: searchString)
//
//        query.orderByDescending("timestamp")
//        query.limit = 20
//        query.findObjectsInBackgroundWithBlock(completion)
    }

    func searchArticlesWithCompletion(searchString: String, completion:([PFObject]?, NSError?) -> ()) {

        let query = PFQuery(className: "Article")
        query.whereKey("Search Key", containsString: searchString)
        query.orderByDescending("timestamp")
        query.limit = 20
        query.findObjectsInBackgroundWithBlock(completion)
    }
}
