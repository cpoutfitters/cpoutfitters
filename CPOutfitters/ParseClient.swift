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
        query.limit = 40
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            let articleArray = Article.articlesWithArray(objects!)
            completion(articleArray, nil)
        }
    }
    
    func saveArticleWithCompletion(article: Article, completion:(success: Bool?, error: NSError?) -> ()) {
        
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
