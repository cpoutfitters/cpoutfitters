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
                print(error?.localizedDescription)
            }
        }
    }

    func saveArticle(article: Article, completion:(success: Bool, error: NSError?) -> ()) {
        article.mediaImage.saveInBackgroundWithBlock { (success, error: NSError?) in
            if success {
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
    func deleteArticle(article: Article, completion:(success: Bool, error: NSError?) -> ()) {
        article.deleteInBackgroundWithBlock(completion)
    }
    
}
