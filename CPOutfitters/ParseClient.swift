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
    
    func fetchArticlesWithCompletion(completion completion:([PFObject]?, NSError?) -> ()) {
        let query = PFQuery(className: "Article")
        query.limit = 40
        query.findObjectsInBackgroundWithBlock {
            (articles: [PFObject]?, error: NSError?) -> Void in
            completion(articles, nil)
        }
    }
    
    /* Reusable save with completion block */
    func saveArticleWithCompletion(completion completion:(article: PFObject?, error: NSError?) -> ()) {
        let article = PFObject(className: "Article")
        article.saveInBackgroundWithBlock {
            (success: Bool?, error: NSError?) -> Void in
            if ((success) != nil) {
                completion(article: article, error: nil)
            } else {
                completion(article: nil, error: error)
            }
        }
    }
    
    /* Reusable save block without completion block */
    func saveArticle(completion completion:(article: PFObject?, error: NSError?) -> ()) {
        let article = PFObject(className: "Article")
        article.saveInBackgroundWithBlock {
            (success: Bool?, error: NSError?) -> Void in
            if ((success) != nil) {
                print("Saved article succesfully")
            } else {
                print("Error: \(error?.localizedDescription)")
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
