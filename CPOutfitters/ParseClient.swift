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
        //And of predicates
        query.whereKey("owner", equalTo: PFUser.currentUser()!)
        //query.whereKey("user_id", equalTo: "hr9PAFNpcg")
        query.limit = 40
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            if objects != nil {
                let articleArray = Article.articlesWithArray(objects!)
                completion(articleArray, nil)
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
    func searchArticlesWithParams(params: NSDictionary, completion:([Article]?, NSError?) ->()) {
        
        let searchValue: String?
        searchValue = params["search"] as? String
        let searchTerms = searchValue?.characters.split {$0 == " "}.map(String.init)
        
        /*
         Logic
         (key:color_group ^ value:blue) v (key:attire ^ value:blue) v (key:article ^ value: blue) v
         (key:color_group ^ value:casual) v (key:attire ^ value:casual) v (key:article ^ value: casual) v
         (key:color_group ^ value:shirt) v (key:attire ^ value:shirt) v (key:article ^ value: shirt)
        */
        
        let predicate = NSPredicate(format: "color_group == \(searchTerms![0]) OR occasion == \(searchTerms![0]) OR type == \(searchTerms![0]) OR color_group == \(searchTerms![1]) OR occasion == \(searchTerms![1]) OR type == \(searchTerms![1]) OR color_group == \(searchTerms![2]) OR occasion == \(searchTerms![2]) OR type == \(searchTerms![2])")
//        let query = PFQuery(className: "Article", predicate: predicate)

        let conditions: [String] = [searchTerms![0], searchTerms![1], searchTerms![2]]
        
        print(conditions)
        let query: PFQuery = self.generateQueryWithPredicateFromConditions(conditions)
        query.whereKey("primary_color", containedIn: conditions)

        
        query.orderByDescending("timestamp")
        query.limit = 20
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            if objects != nil {
                let articleArray = Article.articlesWithArray(objects!)
                completion(articleArray, nil)
            } else {
                print(error?.localizedDescription)
            }
        }
    }
    
    private func generateQueryWithPredicateFromConditions(conditions: [String]) -> PFQuery {
        var predicates: [NSPredicate] = []
        for condition in conditions {
            predicates.append(NSPredicate(format: "primary_color = %@", condition))
        }
        let predicate = NSCompoundPredicate.init(orPredicateWithSubpredicates: predicates)
        return PFQuery(className: "Article", predicate: predicate)
    }

    func searchArticlesWithCompletion(searchString: String, completion:([PFObject]?, NSError?) -> ()) {

        let query = PFQuery(className: "Article")
        query.whereKey("Search Key", containsString: searchString)
        query.orderByDescending("timestamp")
        query.limit = 20
        query.findObjectsInBackgroundWithBlock(completion)
    }
}
