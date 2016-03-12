//
//  RestClient.swift
//  CPOutfitters
//
//  Created by Aditya Purandare on 12/03/16.
//  Copyright © 2016 SnazzyLLama. All rights reserved.
//

import UIKit
import Parse

class RestClient: NSObject {
    
    class var sharedInstance: RestClient {
        struct Static {
            static let instance = RestClient()
        }
        return Static.instance
    }
    
    func fetchArticlesWithCompletion(completion completion:([PFObject]?, NSError?) -> ()) {
        let query = PFQuery(className: "Article")
        query.limit = 40
        query.findObjectsInBackgroundWithBlock(completion)
    }
    
    func fetchOutfitsWithCompletion(completion completion:([PFObject]?, NSError?) -> ()) {
        let query = PFQuery(className: "Outfit")
        query.limit = 40
        query.findObjectsInBackgroundWithBlock(completion)
    }
    
    func loadProfileImageWithCompletion(params: NSDictionary, completion:([PFObject]?, NSError?) -> ()) {
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
    
    func searchArticlesWithCompletion(searchString: String, completion:([PFObject]?, NSError?) -> ()) {

        let query = PFQuery(className: "Article")
        query.whereKey("Search Key", containsString: searchValue!)
        query.orderByDescending("timestamp")
        query.limit = 20
        query.findObjectsInBackgroundWithBlock(completion)
    }


}
