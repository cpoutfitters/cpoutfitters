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
        var outfitObject = Outfit()
        outfitObject.owner = PFUser.currentUser()!
        var topComponentID = ""
        var bottomComponentID = ""
        var footwearComponentID = ""
        PFCloud.callFunctionInBackground("recommend", withParameters: params as [NSObject : AnyObject]?) { (components: AnyObject?, error: NSError?) in
            if let components = components {
                topComponentID = components["topComponent"] as String
                bottomComponentID = components["bottomComponent"] as String
                footwearComponentID = components["footwearComponent"] as String
                //completion(outfit as? Outfit,error)
            }
        }
        ParseClient.sharedInstance.fetchArticles(["objectId":topComponentID]) { (articles:[Article]?, error: NSError?) in
            if let article = articles[0] {
                outfitObject.topComponent = article
            } else {
                print(error?.localizedDescription)
            }
        }
        ParseClient.sharedInstance.fetchArticles(["objectId":bottomComponentID]) { (articles:[Article]?, error: NSError?) in
            if let article = articles[0] {
                outfitObject.bottomComponent = article
            } else {
                print(error?.localizedDescription)
            }
        }
        ParseClient.sharedInstance.fetchArticles(["objectId":footwearComponentID]) { (articles:[Article]?, error: NSError?) in
            if let article = articles[0] {
                outfitObject.footwearComponent = article
            } else {
                print(error?.localizedDescription)
            }
        }
        if (outfitObject.topComponent != nil) && (outfitObject.bottomComponent != nil) && (outfitObject.footwearComponent != nil) {
            completion(outfitObject, nil)
        } else {
            completion(nil, error)
        }
    }
    
    // Function for deletion of article from server
    func deleteArticle(article: Article, completion:(success: Bool, error: NSError?) -> ()) {
        article.deleteInBackgroundWithBlock(completion)
    }
    
}
