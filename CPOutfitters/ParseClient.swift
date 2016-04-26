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
    func countArticles(params: NSDictionary, completion:(Int32?, NSError?) -> ()) {
        let query = PFQuery(className:"Article")
        let obj = params
        var userName: PFUser?
        for (key, value) in obj {
            userName = value as? PFUser
        }
        query.whereKey("owner", equalTo: userName!)
        query.countObjectsInBackgroundWithBlock {
            (count: Int32, error: NSError?) -> Void in
            if error == nil {
                completion(count, nil)
            } else {
                print(error?.localizedDescription)
            }
        }

    }
    
    func loadProfileImageWithCompletion(params: NSDictionary, completion:([PFObject]?, NSError?) -> ()) {
        let obj = params
        var userName: String?
        for (key, value) in obj {
            userName = value as? String
        }
        let query = PFQuery(className: "_User")
        query.whereKey("username", equalTo: userName!)
        query.limit = 20
        query.findObjectsInBackgroundWithBlock(completion)
    }
    
    func getArticle(articleId: String, completion:(Article?, NSError?) -> ()) {
        let article = Article(className: articleId)
        article.fetchInBackgroundWithBlock { (result, error) -> Void in
            completion(result as? Article, error)
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
    
    func getRecommendedOutfit(params: NSDictionary, completion:(String, Article?, NSError?) -> ()) {
        
        // Retrieve top
        var query = PFQuery(className: "Article")
        query.whereKey("type", equalTo: "top")
        query.whereKey("owner", equalTo: PFUser.currentUser()!)
        for (key, value) in params {
            query.whereKey(key as! String, equalTo: value)
        }
        query.limit = 1
        query.findObjectsInBackgroundWithBlock { (articles, error) -> Void in
            completion("top", articles?.first as? Article, error)
        }
        
        // retrieve bottom
        query = PFQuery(className: "Article")
        query.whereKey("type", equalTo: "bottom")
        query.whereKey("owner", equalTo: PFUser.currentUser()!)
        for (key, value) in params {
            query.whereKey(key as! String, equalTo: value)
        }
        query.limit = 1
        query.findObjectsInBackgroundWithBlock { (articles, error) -> Void in
            completion("bottom", articles?.first as? Article, error)
        }
        
        // retrieve footwear
        query = PFQuery(className: "Article")
        query.whereKey("type", equalTo: "footwear")
        query.whereKey("owner", equalTo: PFUser.currentUser()!)
        for (key, value) in params {
            query.whereKey(key as! String, equalTo: value)
        }
        query.limit = 1
        query.findObjectsInBackgroundWithBlock { (articles, error) -> Void in
            completion("footwear", articles?.first as? Article, error)
        }
        
    }
    
    // Function for deletion of article from server
    func deleteArticle(article: Article, completion:(success: Bool, error: NSError?) -> ()) {
        article.deleteInBackgroundWithBlock(completion)
    }
    
    func getUser(params: NSDictionary, completion:(PFUser?, NSError?) -> ()) {
        let query = PFQuery(className: "_User")
        let username = PFUser.currentUser()?.username
        query.whereKey("username", equalTo: username!)
        query.limit = 1
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            if let objects = objects as? [PFUser] {
                let user = objects[0]
                completion(user, nil)
            } else {
                print(error?.localizedDescription)
            }
        }
    }
    func logoutUser() {
        PFUser.logOutInBackgroundWithBlock { (error:NSError?) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("User logged out")
                NSNotificationCenter.defaultCenter().postNotificationName(userDidLogoutNotification, object: nil)
            }
        }
    }
    func updateInfo(params: NSDictionary, completion:(success: Bool, error: NSError?) -> ()) {
        let obj = params
        var userName: String?
        for (key, value) in obj {
            userName = value as? String
        }
        let query = PFQuery(className: "_User")
        let username = PFUser.currentUser()?.username
        query.whereKey("username", equalTo: username!)
    }
}
