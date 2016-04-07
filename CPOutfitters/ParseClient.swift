//
//  RestClient.swift
//  CPOutfitters
//
//  Created by Aditya Purandare on 12/03/16.
//  Copyright © 2016 SnazzyLLama. All rights reserved.
//
/*
 Params of User Class:
 var friends: [User]?
 var profileImage: PFFile?
 var bio: String?
 var sharedWith: [User]?
 */

import UIKit
import Parse

class ParseClient: NSObject {

    static let sharedInstance = ParseClient()

    func fetchArticles(params: NSDictionary, completion:([Article]?, NSError?) -> ()) {
        
        let query = PFQuery(className: "Article")
        
        for (key, value) in params {
            query.whereKey(key as! String, containsString: value as? String)
        }
        
        query.whereKey("owner", equalTo: PFUser.currentUser()!)
        query.limit = 40
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            if let articles = objects as? [Article] {
                completion(articles, nil)
            } else {
                print("Parse Client: \(error?.localizedDescription)")
            }
        }
    }

    func saveArticle(article: Article, completion:(success: Bool, error: NSError?) -> ()) {
        article.mediaImage.saveInBackgroundWithBlock { (success, error: NSError?) in
            if success {
                article.saveInBackgroundWithBlock {
                    (success: Bool?, error: NSError?) -> Void in
                    if (success == true ) {
                        print("Parse Client: An article stored")
                        completion(success: true, error: nil)
                    } else {
                        print("Parse Client: \(error?.localizedDescription)")
                        completion(success: false, error: error)
                    }
                }
            } else {
                print("Parse Client: \(error?.localizedDescription)")
                completion(success: false, error: error)
            }
        }
        
    }

    func fetchOutfit(completion:([PFObject]?, NSError?) -> ()) {
        let query = PFQuery(className: "Outfit")
        query.limit = 40
        query.findObjectsInBackgroundWithBlock(completion)
    }

    func saveOutfit(outfit: Outfit, completion:(success: Bool, error: NSError?) -> ()) {
        outfit.saveInBackgroundWithBlock(completion)
    }
    
    func getRecommendedOutfit(params: NSDictionary, completion:(Outfit?, NSError?) -> ()) {

        PFCloud.callFunctionInBackground("recommend", withParameters: params as [NSObject : AnyObject]) { (outfit: AnyObject?, error: NSError?) in
                completion(outfit as? Outfit,error)
        }
    }
    
    // Function for deletion of article from server
    func deleteArticle(article: Article, completion:(success: Bool, error: NSError?) -> ()) {
        article.deleteInBackgroundWithBlock(completion)
    }
    
}
